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

        getHistoryArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getHistoryArray()
    {
        var friend = FriendModel()
        var user = UserModel()
        user.user_id = "a123"
        user.user_name = "Steffen Gruenewald"
        user.user_imageUrl = "http://35.162.10.72/shopping/upload/0c4bc85e48d664ccd64a62c184d5b19c.png"
        friend.friend_user = user
        friend.friend_roomid = "wefwiefwf[woe"
        friend.friend_lastmessagetime = "a day ago"
        friend.friend_lastmessage = "I have made a bag."
        historyArray.append(friend)


        friend = FriendModel()
        user = UserModel()
        user.user_id = "a156"
        user.user_name = "Liuying"
        user.user_imageUrl = "http://35.162.10.72/shopping/upload/3a2ad41b1bd817e9bc2aae983ac5fbed.jpg"
        friend.friend_user = user
        friend.friend_roomid = "wefwiefwf[woe"
        friend.friend_lastmessagetime = "a day ago"
        friend.friend_lastmessage = "I have made a bag."
        historyArray.append(friend)


        friend = FriendModel()
        user = UserModel()
        user.user_id = "ge15234"
        user.user_name = "John Smith"
        user.user_imageUrl = "http://35.162.10.72/shopping/upload/0a6b5c283831f884c20903feb84e088f.png"
        friend.friend_user = user
        friend.friend_roomid = "wefwiefwf[woe"
        friend.friend_lastmessagetime = "a day ago"
        friend.friend_lastmessage = "I have made a bag."
        historyArray.append(friend)

        friend = FriendModel()
        user = UserModel()
        user.user_id = "uiO00swfew"
        user.user_name = "Zhuxian"
        user.user_imageUrl = "http://35.162.10.72/shopping/upload/bdf03c9c8938c1c0577b3f943d27afbc.png"
        friend.friend_user = user
        friend.friend_roomid = "wefwiefwf[woe"
        friend.friend_lastmessagetime = "a day ago"
        friend.friend_lastmessage = "I have made a bag."
        historyArray.append(friend)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = historyArray[indexPath.row]
        let chattingViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChattingViewController") as! ChattingViewController
        chattingViewController.friend = friend.friend_user
        chattingViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chattingViewController, animated: true)

    }

   
    
    
}


