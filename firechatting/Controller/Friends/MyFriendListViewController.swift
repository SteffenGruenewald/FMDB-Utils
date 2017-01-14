//
//  MyFriendListViewController.swift
//  OUT
//
//  Created by MidnightSun on 1/13/17.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class MyFriendListViewController: BaseViewController {
    
    
    @IBOutlet weak var tblFriendsOut: UITableView!
    @IBOutlet weak var tblMyfriends: UITableView!
<<<<<<< HEAD
    @IBOutlet weak var btnBack: UIButton!
    var myFriendsArray: [FriendModel] = []
    
=======

    var myFriendsArray: [UserModel] = []
    var unFriendsArray: [UserModel] = []


>>>>>>> a170ee1e7e363c9507b756f913c0cb6357939989
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
<<<<<<< HEAD
        
        let viewControllers = self.navigationController?.viewControllers
        
        
        if viewControllers?.count == 1
        {
            btnBack.isHidden = true
        }
        else
        {
            btnBack.isHidden = false
        }
=======


>>>>>>> a170ee1e7e363c9507b756f913c0cb6357939989
        // Do any additional setup after loading the view.
        
        tblFriendsOut.separatorColor = .clear
        tblMyfriends.separatorColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getFriendsOut()
        getFriends()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
<<<<<<< HEAD
    func getFriendsOut(){
        
        self.myFriendsArray = myFriends
        self.tblMyfriends.reloadData()
    }
    func getFriends() {
        
    }
=======

    override func viewWillAppear(_ animated: Bool) {
        setLists()
    }

    func setLists()
    {
        myFriendsArray = []
        unFriendsArray = []
        for user in globalUsersArray{
            if (firebaseUserAuthInstance.isMyFriend(userid: user.user_id) == Constants.FRIEND_UNFRIEND)
            {
                unFriendsArray.append(user)
            }
            else{

                myFriendsArray.append(user)
            }
        }
    }



>>>>>>> a170ee1e7e363c9507b756f913c0cb6357939989
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MyFriendListViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< HEAD
        
        if tableView == tblFriendsOut{
      
            return 10
        } else {
         
            return myFriendsArray.count
        }
=======
        var count = 0
        if(tblMyfriends == tableView){
            count = myFriendsArray.count
        }
        else{
            count = unFriendsArray.count
        }
      
        return count
>>>>>>> a170ee1e7e363c9507b756f913c0cb6357939989
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        if tableView == tblFriendsOut{

            let user = unFriendsArray[indexPath.row]
            cell.lblUsername.text = user.user_firstName + " " + user.user_lastName
            cell.imvUser.setImageWith(storageRefString: user.user_imageUrl, placeholderImage: UIImage(named: "ic_user_placeholder")!)
        } else {
            print("Hi")
<<<<<<< HEAD
             let user_myFriends = myFriendsArray[indexPath.row]
            let cell:MyfriendsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyfriendsTableViewCell") as! MyfriendsTableViewCell
            cell.imvMyfriends.setImageWith(storageRefString: user_myFriends.friend_user.user_imageUrl, placeholderImage: UIImage(named: "ic_user_placeholder")!)
            cell.lblMyfriendsUserName.text = user_myFriends.friend_user.user_name
            
            return cell
=======
      
            let user = myFriendsArray[indexPath.row]
            cell.lblUsername.text = user.user_firstName + " " + user.user_lastName
            cell.imvUser.setImageWith(storageRefString: user.user_imageUrl, placeholderImage: UIImage(named: "ic_user_placeholder")!)
>>>>>>> a170ee1e7e363c9507b756f913c0cb6357939989
        }
        return cell
    }
    

  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("selected")
        
    }
 
    
}
