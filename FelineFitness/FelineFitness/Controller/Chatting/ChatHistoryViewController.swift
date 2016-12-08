//
//  ChatHistoryViewController.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit

class ChatHistoryViewController: BaseViewController {

    @IBOutlet weak var tblChatHistory: UITableView!
    var historyArray : [FriendModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.navigationController.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    




}


extension ChatHistoryViewController:UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let friend = historyArray[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatHistoryTableViewCell", for: indexPath) as! ChatHistoryTableViewCell
        cell.imvUserImage.sd_setImage(with: URL(string: friend.friend_user.user_imageUrl), placeholderImage: UIImage(named: "ic_user_placeholder"))
        cell.lblUsername.text = friend.friend_user.user_name
        cell.lblLastMessage.text = friend.friend_lastmessage
        cell.lblTime.text = friend.friend_lastmessagetime

        return cell
    }

   
    
    
}


