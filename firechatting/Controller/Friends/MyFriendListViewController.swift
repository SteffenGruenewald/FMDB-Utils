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
    @IBOutlet weak var btnBack: UIButton!
    var myFriendsArray: [FriendModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        let viewControllers = self.navigationController?.viewControllers
        
        
        if viewControllers?.count == 1
        {
            btnBack.isHidden = true
        }
        else
        {
            btnBack.isHidden = false
        }
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
    func getFriendsOut(){
        
        self.myFriendsArray = myFriends
        self.tblMyfriends.reloadData()
    }
    func getFriends() {
        
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
        
        if tableView == tblFriendsOut{
      
            return 10
        } else {
         
            return myFriendsArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblFriendsOut{
            let cell:FriendsOutTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FriendsOutTableViewCell") as! FriendsOutTableViewCell
            cell.lblFriendsOutUserName.text = "friendsOut"
            return cell
        } else {
            print("Hi")
             let user_myFriends = myFriendsArray[indexPath.row]
            let cell:MyfriendsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyfriendsTableViewCell") as! MyfriendsTableViewCell
            cell.imvMyfriends.setImageWith(storageRefString: user_myFriends.friend_user.user_imageUrl, placeholderImage: UIImage(named: "ic_user_placeholder")!)
            cell.lblMyfriendsUserName.text = user_myFriends.friend_user.user_name
            
            return cell
        }
    }
    

  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("selected")
        
    }
 
    
}
