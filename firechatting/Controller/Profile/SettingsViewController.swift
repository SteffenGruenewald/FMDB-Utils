//
//  SettingsViewController.swift
//  OUT
//
//  Created by Huijing on 29/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController, UITextViewDelegate {

    @IBOutlet weak var switchOut: UISwitch!
    @IBOutlet weak var txtOutMessage: UITextView!
    @IBOutlet weak var sliderDistance: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
        sliderDistance.value = UserDefaults.standard.value(forKey: "distance") as! Float
        txtOutMessage.text = currentUser.user_mapMessage
        switchOut.isOn = currentUser.user_outStatus

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
    @IBAction func btnLogoutTapped(_ sender: UIButton) {
        defaults.removeObject(forKey: Constants.USER_EMAIL)
        defaults.removeObject(forKey: Constants.USER_PASSWORD)
        firebaseUserAuthInstance.signOut(completion: {
            success in
            if success{
                self.gotoStartScene()
            }
        })
        myFriends = []

    }
    @IBAction func changedOutStatus(_ sender: Any) {
        currentUser.user_outStatus = switchOut.isOn
        firebaseUserAuthInstance.updateUserInfo(user: currentUser)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        currentUser.user_mapMessage = txtOutMessage.text
        firebaseUserAuthInstance.updateUserInfo(user: currentUser)

    }
    
    @IBAction func changedDistance(_ sender: Any) {
        UserDefaults.standard.set(sliderDistance.value, forKey: "distance")
    }

    @IBAction func viewDidTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func moreButtonTapped(_ sender: Any) {
        let profileSettingVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        profileSettingVC.fromSettings = true
        self.navigationController?.pushViewController(profileSettingVC, animated: true)
    }

}
