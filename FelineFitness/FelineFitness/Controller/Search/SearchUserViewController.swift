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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getUsers()
    {

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


}
