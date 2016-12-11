//
//  FirebaseUserAuthentication.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase



class FirebaseUserAuthentication{

    var friendRef : FIRDatabaseReference!
    var userRef : FIRDatabaseReference!

    static func createFIRUser(email: String, password: String, completion : @escaping (String, Bool) -> ())
    {
        NSLog("email = %@ , password = %@", email, password)

        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
            (user, error) in
            NSLog("USER ==== %@", user!.uid as String!)

            let userid = user?.uid
            if userid!.characters.count > 0
            {
                UserDefaults.standard.set(email, forKey: Constants.USER_EMAIL)
                UserDefaults.standard.set(password, forKey: Constants.USER_PASSWORD)
                completion(userid!, true)
            }
            else
            {
                completion(userid!, false)
            }
        })
    }

    static func addUserProfileImage(userid: String, profileImage: UIImage?, completion: @escaping (String, Bool) -> ())
    {
        if(userid.characters.count > 0 && profileImage != nil)
        {
            FirebaseStorageUtils.uploadImage(toURL: Constants.FIR_STORAGE_USERPROFILEDIRECTORY,userid: userid, image: profileImage!, completion: {
                imageURL, success in
                if success{
                    completion(imageURL, true)
                }
                else{
                    completion(imageURL, false)
                }
            })
        }
        else{
            completion(Constants.ERROR_FAIL_PROFILEIMAGE, false)
        }
    }


    static func signUp(username: String, email: String, password: String, profileImage: UIImage?, completion:@escaping (UserModel?, String) -> ())
    {
        createFIRUser(email: email, password: password, completion: {
            userid,success in

            if success{

                let user = UserModel()
                user.user_id = userid
                user.user_emailAddress = email
                user.user_password = password

                currentUser = user
                addUserProfileImage(userid: userid, profileImage: profileImage, completion: {imageURL, success in
                    if success{
                        user.user_name = username
                        user.user_imageUrl = imageURL
                        firebaseUserAuthInstance.createUserReference(userid: userid)
                        firebaseUserAuthInstance.registerUserInfo(user: user)
                        completion(user, Constants.SUCCESS_PROCESS)
                    }
                    else
                    {
                        user.user_name = username
                        user.user_imageUrl = imageURL
                        firebaseUserAuthInstance.createUserReference(userid: userid)
                        firebaseUserAuthInstance.registerUserInfo(user: user)
                        completion(user, Constants.ERROR_FAIL_PROFILEIMAGE)
                    }
                })

            }
            else {
                completion(nil, Constants.ERROR_REGISTRATION_FAIL)
            }
        })
    }

    static func signIn(email: String, password: String, completion: @escaping(String, Bool) -> ())
    {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {
            (user, error) in
            if error != nil{
                NSLog("\(error)")
                completion("", false)
            }
            else
            {
                UserDefaults.standard.set(email, forKey: Constants.USER_EMAIL)
                UserDefaults.standard.set(password, forKey: Constants.USER_PASSWORD)

                getUserInfo(userid: (user?.uid)!, completion: {
                    detailedUser in
                    if (detailedUser != nil)
                    {
                        currentUser = detailedUser!
                        completion((detailedUser?.user_id)!, true)
                    }
                    else{
                        completion("", false)
                    }
                })
            }
        })
    }

    static func signOut()
    {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

    static func getUserInfo(userid: String, completion: @escaping (UserModel?) -> ()){

        FIRDatabase.database().reference(withPath: Constants.FIR_USERINFODIRECTORY).child(userid).child(Constants.FIR_MYINFODIRECTORY).observeSingleEvent(of: .value, with: {(snapshot) in

            NSLog("\(snapshot)")

            let user = parseUser(snapShotItem: snapshot.value as? NSDictionary)
            completion(user)
        }) {
            (error) in
            print(error.localizedDescription)
            completion(nil)
        }
    }

    func createUserReference(userid: String){

        userRef = FIRDatabase.database().reference(withPath: Constants.FIR_USERINFODIRECTORY).child(userid).child(Constants.FIR_MYINFODIRECTORY)

    }

    func CreateMyFriendReference(userid: String, friend: FriendModel){
        friendRef = FIRDatabase.database().reference(withPath: Constants.FIR_USERINFODIRECTORY).child(userid).child(Constants.FIR_FRIENDDIRECTORY)
    }

    func registerUserInfo(user: UserModel)
    {
        var post : [String : AnyObject] = [:]
        post[Constants.USER_ID] = user.user_id as AnyObject!
        post[Constants.USER_EMAIL] = user.user_emailAddress as AnyObject!
        post[Constants.USER_PASSWORD] = user.user_password as AnyObject!
        post[Constants.USER_IMAGEURL] = user.user_imageUrl as AnyObject!
        post[Constants.USER_NAME] = user.user_name as AnyObject!
        post[Constants.USER_STATUS] = Constants.USER_ONLINE as AnyObject!
        userRef.setValue(post)
        if(UserDefaults.standard.value(forKey: Constants.DEVICE_TOKEN) != nil) {        let token = (UserDefaults.standard.value(forKey: Constants.DEVICE_TOKEN))! as! String
            if (token.characters.count == 0){
                setUserDeviceStatus(userid: user.user_id, token: (UserDefaults.standard.value(forKey: Constants.DEVICE_TOKEN))! as! String, status: Constants.USER_DEVICE_ONLINE)
            }
        }
    }

    func setUserDeviceStatus(userid: String, token: String, status: Int)
    {
        userRef.child(userid).child(Constants.USER_DEVICES).child(token).setValue(status)
    }


    /*

    func getFriendDeviceStatus(userid: String)
    {
        let curFriendRef = FIRDatabase.database().reference(withPath: Constants.FIR_USERINFODIRECTORY).child(userid).child(Constants.FIR_MYINFODIRECTORY).child(Constants.USER_DEVICES)
    }*/


    static func getAllUsers(completion: @escaping ([UserModel]) -> ())
    {
        FIRDatabase.database().reference(withPath: Constants.FIR_USERINFODIRECTORY).observeSingleEvent(of: .value, with: {(snapshot) in


            let childref = snapshot.children.allObjects as? [FIRDataSnapshot]

            if((childref?.count)! > 0){
                var users: [UserModel] = []

                for i in 0..<(childref?.count)!
                {
                    let postDict = childref?[i].value as? NSDictionary
                    let user = parseUser(snapShotItem: postDict)
                    if(user.user_id != currentUser.user_id){
                        users.append(user)
                    }
                }

                completion(users)
            }
            else
            {
                completion([])
            }

        }) {
            (error) in
            print(error.localizedDescription)
            completion([])
        }
    }

    static func parseUser(snapShotItem: NSDictionary?) -> UserModel
    {
        let user = UserModel()
        user.user_id = (snapShotItem?[Constants.USER_ID] as! String?)!
        user.user_name = (snapShotItem?[Constants.USER_NAME] as! String?)!
        user.user_imageUrl = (snapShotItem?[Constants.USER_IMAGEURL] as! String?)!
        user.user_emailAddress = (snapShotItem?[Constants.USER_EMAIL] as! String?)!
        user.user_status = String(snapShotItem?[Constants.USER_STATUS] as! Int)
        //user.user_id = (snapShotItem?[Constants.USER_ID] as! String?)!

        return user

    }

}

var firebaseUserAuthInstance = FirebaseUserAuthentication()
