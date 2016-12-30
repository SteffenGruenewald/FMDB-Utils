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

        self.navigationController?.isNavigationBarHidden = true


        tblChatHistory.separatorColor = .clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        getFriends()
        tblChatHistory.reloadData()
    }

    func getFriends()
    {
        historyArray = myFriends
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
        ////NSLog(friend.friend_user.user_imageUrl)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatHistoryTableViewCell", for: indexPath) as! ChatHistoryTableViewCell
        cell.imvUserImage.setImageWith(storageRefString: friend.friend_user.user_imageUrl, placeholderImage: UIImage(named: "ic_user_placeholder")!)
        cell.lblUsername.text = friend.friend_user.user_name
        cell.lblLastMessage.text = friend.friend_lastmessage
        cell.lblTime.text = getTimeStringfromGMTTimeMillis(time: friend.friend_lastmessagetime).description
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = historyArray[indexPath.row]
        let chattingViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChattingViewController") as! ChattingViewController
        chattingViewController.friend = friend
        chattingViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chattingViewController, animated: true)

    }

   
    
    
}


