//
//  AddedMeFriendsListViewController.swift
//  OUT
//
//  Created by MidnightSun on 1/15/17.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class AddedMeFriendsListViewController: BaseViewController {

    @IBOutlet weak var tblAddedMeFriends: UITableView!
    var myFriendsArray: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        tblAddedMeFriends.separatorColor = .clear
        setLists()
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
        for friend in myFriends{
            myFriendsArray.append(friend.friend_user)
        }

        tblAddedMeFriends.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    @IBAction func backBtnTapped(_ sender: Any) {
          _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBtnTapped(_ sender: Any) {
        
        let addFrinedsViewCon = self.storyboard?.instantiateViewController(withIdentifier: "AddFriendsViewController")
        
        self.navigationController?.pushViewController(addFrinedsViewCon!, animated:true)
    }
    
}

extension AddedMeFriendsListViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        count = myFriendsArray.count
    
        return count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
      
            print("Hi")
            
            let user = myFriendsArray[indexPath.row]
            cell.lblUsername.text = user.user_firstName + " " + user.user_lastName
            cell.imvUser.setImageWith(storageRefString: user.user_imageUrl, placeholderImage: UIImage(named: "ic_user_placeholder")!)
      
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selected")
        
    }
    
    
}

