//
//  UserDetailViewController.swift
//  FelineFitness
//
//  Created by Huijing on 12/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit

class UserDetailViewController: BaseViewController {

    @IBOutlet weak var imvUserPhoto: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnFriend: UIButton!

    var isMyFriend = ""

    var user = UserModel()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        isMyFriend = firebaseUserAuthInstance.isMyFriend(userid: user.user_id)

        imvUserPhoto.setImageWith(storageRefString: user.user_imageUrl, placeholderImage: UIImage(named: "ic_user_placeholder")!)
        lblUsername.text = user.user_name
        lblEmail.text = user.user_emailAddress
        if  isMyFriend != Constants.FRIEND_UNFRIEND
        {
            btnFriend.setTitle("Remove from Contacts", for: .normal)
        }
        else
        {
            btnFriend.setTitle("Add Contacts", for: .normal)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnFriendTapped(_ sender: Any) {
        isMyFriend = firebaseUserAuthInstance.isMyFriend(userid: user.user_id)

        if  isMyFriend == Constants.FRIEND_UNFRIEND
        {
            showLoadingView()
            firebaseUserAuthInstance.requestFriend(userid: user.user_id, completion: {
                message in
                self.hideLoadingView()
                if message == Constants.SUCCESS_PROCESS
                {                    
                    self.btnFriend.setTitle("Remove from Contacts", for: .normal)
                }
                else{
                    self.showToastWithDuration(string: message, duration: 3.0)
                }
            })
        }
        else
        {
            showLoadingView()
            firebaseUserAuthInstance.removeFriend(userid: user.user_id, completion: {
                message in
                self.hideLoadingView()
                if message == Constants.SUCCESS_PROCESS{
                    self.btnFriend.setTitle("Add Contacts", for: .normal)
                }
                else
                {
                    self.showToastWithDuration(string: message, duration: 3.0)
                }
            })
        }

    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
