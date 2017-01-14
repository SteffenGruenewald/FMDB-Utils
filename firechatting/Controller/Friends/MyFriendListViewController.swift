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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
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

}

extension MyFriendListViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 10
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
            let cell:MyfriendsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyfriendsTableViewCell") as! MyfriendsTableViewCell
      
            cell.lblMyfriendsUserName.text = "my friend"
            return cell
        }
    }
    

  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("selected")
        
    }
 
    
}
