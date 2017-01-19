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

    var myFriendsArray: [UserModel] = []
    var unFriendsArray: [UserModel] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true


        // Do any additional setup after loading the view.
        
        tblFriendsOut.separatorColor = .clear
        tblMyfriends.separatorColor = .clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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

        tblFriendsOut.reloadData()
        tblMyfriends.reloadData()
    }


    @IBAction func backBtnTapped(_ sender: Any) {
        
            _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func nextBtnTapped(_ sender: Any) {
        let addMeFrinedsViewCon = self.storyboard?.instantiateViewController(withIdentifier: "AddedMeFriendsListViewController")
        
        self.navigationController?.pushViewController(addMeFrinedsViewCon!, animated:true)
    }
    

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
        var count = 0
        if(tblMyfriends == tableView){
            count = myFriendsArray.count
        }
        else{
            count = unFriendsArray.count
        }
      
        return count
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
            let user = myFriendsArray[indexPath.row]
            cell.lblUsername.text = user.user_firstName + " " + user.user_lastName
            cell.imvUser.setImageWith(storageRefString: user.user_imageUrl, placeholderImage: UIImage(named: "ic_user_placeholder")!)
        }
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let index = indexPath.row
        if (tableView == tblFriendsOut)
        {
            let user = unFriendsArray[index]
            let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
            detailVC.user = user
            //detailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVC, animated: true)

        }
        if (tableView == tblMyfriends)
        {
            let user = myFriendsArray[index]
            let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
            detailVC.user = user
            //detailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVC, animated: true)

        }
        
    }
 
    
}
