//
//  ChattingViewController.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit
import SDWebImage

class ChattingViewController: BaseViewController {


    @IBOutlet weak var imvFriend: UIImageView!
    @IBOutlet weak var lblFriendName: UILabel!

    var friend = UserModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initView()
    {
        imvFriend.sd_setImage(with: URL(string: friend.user_imageUrl), placeholderImage: UIImage(named: "ic_user_placeholder"))
        lblFriendName.text = friend.user_name
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

}
