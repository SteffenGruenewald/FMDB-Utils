//
//  ChattingViewController.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit
//import SDWebImage

class ChattingViewController: BaseViewController {


    @IBOutlet weak var imvFriend: UIImageView!
    @IBOutlet weak var lblFriendName: UILabel!

    @IBOutlet weak var tblChatList: UITableView!

    @IBOutlet weak var chatActionBarView: UIView!

    let kChatActionBarOriginalHeight: CGFloat = 55      //ActionBar orginal height
    let kChatActionBarMaxHeight: CGFloat = 80   //Expandable textview max
    
    @IBOutlet weak var inputTextView: UIPlaceHolderTextView!


    @IBOutlet weak var typingStatusViewHeightConstraint: NSLayoutConstraint!

    var friend = FriendModel()

    var picker = UIImagePickerController()


    var keyboardHeightConstraint: CGFloat = 0.0;  //Constraint of keyboard height

    @IBOutlet weak var actionBarPaddingBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var actionBarHeightContraint: NSLayoutConstraint!
    var timer : Timer!

    var writingInterval = 0.0

    var isTyping = false

    var itemDataSource:[MessageModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.

        initView()
        keyboardControl()
        tblChatList.separatorColor = .clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initView()
    {

        itemDataSource = [];
        typingStatusViewHeightConstraint.constant = 0.0
        imvFriend.setImageWith(storageRefString: friend.friend_user.user_imageUrl, placeholderImage: UIImage(named: "ic_user_placeholder")!)
        lblFriendName.text = friend.friend_user.user_name

        currentFriend = friend.friend_user;
        firebaseRealTimeMessageInstance.createCurrentReference(friend.friend_roomid)

        readChatOnce()

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(receivedMessage(_:)), name: NSNotification.Name(rawValue: Constants.STATUS_RECEIEVEDMESSAGE), object: nil)
        tblChatList.estimatedRowHeight = 100

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButtonTapped(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)

    }

    @IBAction func sendButtonTapped(_ sender: Any) {
        if (inputTextView.text!.characters.count > 0){
            let messageString = inputTextView.text!
            inputTextView.text = ""
            textViewDidChange(inputTextView)

            sendTextMessage(text: messageString)

        }
    }


}
