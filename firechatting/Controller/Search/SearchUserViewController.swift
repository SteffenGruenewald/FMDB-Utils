//
//  SearchViewController.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit

//import SDWebImage

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

        tblUserList.separatorColor = .clear


    }

    override func viewWillAppear(_ animated: Bool) {
        getUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getUsers()
    {
        self.searchUsersArray = globalUsersArray
        self.tblUserList.reloadData()

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
        cell.imvUser.setImageWith(storageRefString: user.user_imageUrl, placeholderImage: UIImage(named: "ic_user_placeholder")!)
        cell.lblUsername.text = user.user_name

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowIndex = indexPath.row

        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        detailVC.user = searchUsersArray[rowIndex]
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)

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






