//
//  AddFriendsViewController.swift
//  OUT
//
//  Created by MidnightSun on 1/15/17.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class AddFriendsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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


    @IBAction func backBtnTapped(_ sender: Any) {
         _ = self.navigationController?.popViewController(animated:true)
    }

    
}
