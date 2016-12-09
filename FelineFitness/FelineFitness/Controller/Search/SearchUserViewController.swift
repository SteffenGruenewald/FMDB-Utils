//
//  SearchViewController.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit

import SDWebImage

class SearchUserViewController: BaseViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblUserList: UITableView!

    var searchUsersArray: [UserModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

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

        getUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getUsers()
    {
        var user = UserModel()
        user.user_id = "a123"
        user.user_name = "Steffen Gruenewald"
        user.user_imageUrl = "http://35.162.10.72/shopping/upload/0c4bc85e48d664ccd64a62c184d5b19c.png"
        searchUsersArray.append(user)

        user = UserModel()
        user.user_id = "a156"
        user.user_name = "Liuying"
        user.user_imageUrl = "http://35.162.10.72/shopping/upload/3a2ad41b1bd817e9bc2aae983ac5fbed.jpg"
        searchUsersArray.append(user)


        user = UserModel()
        user.user_id = "ge15234"
        user.user_name = "John Smith"
        user.user_imageUrl = "http://35.162.10.72/shopping/upload/0a6b5c283831f884c20903feb84e088f.png"
        searchUsersArray.append(user)

        user = UserModel()
        user.user_id = "uiO00swfew"
        user.user_name = "Zhuxian"
        user.user_imageUrl = "http://35.162.10.72/shopping/upload/bdf03c9c8938c1c0577b3f943d27afbc.png"
        searchUsersArray.append(user)

        //tblUserList.reloadData()
    }

    func getStringMatchUsers(_ keyword: String)
    {

    }
    @IBAction func backButtonTapped(_ sender: Any) {
        
    }

}

extension SearchUserViewController:UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchUsersArray.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let user = searchUsersArray[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.imvUser.sd_setImage(with: URL(string: user.user_imageUrl), placeholderImage: UIImage(named: "ic_user_placeholder"))
        cell.lblUsername.text = user.user_name

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }


}


extension SearchUserViewController: UISearchBarDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getStringMatchUsers(searchText)
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}






