//
//  PassCodeCheckViewController.swift
//  OUT
//
//  Created by Huijing on 16/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class PassCodeCheckViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkValid(){
        var passCode = ""
        for i in 1...6{
            passCode = passCode + (self.view.viewWithTag(i) as! UITextField).text!
        }

        if (defaults.value(forKey: "passcode") != nil)
        {
            if passCode == defaults.value(forKey: "passcode") as! String{
                let vcs = self.navigationController?.viewControllers
                let loginVC = vcs?[(vcs?.count)! - 2] as! LoginViewController
                loginVC.passcodeDetected = true
                _ = self.navigationController?.popViewController(animated: true)
            }
            else{
                self.showToastWithDuration(string: "Incorrect passcode. Try again", duration: 3.0)
                for i in 1...6{
                    (self.view.viewWithTag(i) as! UITextField).text = ""

                }
                (self.view.viewWithTag(1) as! UITextField).becomeFirstResponder()

            }
        }
    }

    @IBAction func setPasscode(_ sender: UITextField) {

        if (sender.tag < 6){
            if(sender.text!.characters.count == 1){
                (self.view.viewWithTag(sender.tag + 1) as! UITextField).becomeFirstResponder()
            }
        }
        else{
            checkValid()
        }
    }

    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
