//
//  SetupPasswordViewController.swift
//  OUT
//
//  Created by Huijing on 21/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit

class SetupPasswordViewController: BaseViewController {


    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPasswrod: UITextField!

    @IBOutlet weak var txtPassCode1: UITextField!
    @IBOutlet weak var txtPassCode2: UITextField!
    @IBOutlet weak var txtPassCode3: UITextField!
    @IBOutlet weak var txtPassCode4: UITextField!
    @IBOutlet weak var txtPassCode5: UITextField!
    @IBOutlet weak var txtPassCode6: UITextField!


    var user = UserModel()

    var profileImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    func doSignUp()
    {
        self.view.endEditing(true)
        let checkResult = checkValid(securityId: "", password: txtPassword.text!, confirmPasswrod: txtConfirmPasswrod.text!)

        if checkResult == Constants.SUCCESS_PROCESS{
            showLoadingView()
            FirebaseUserAuthentication.signUp(username: user.user_name, email: user.user_emailAddress, password: user.user_password, profileImage: profileImage, firstName: user.user_firstName, lastName: user.user_lastName, completion: {
                user, message in
                self.hideLoadingView()
                if user != nil{
                    currentUser = user!
                    firebaseUserAuthInstance.initClass()
                    self.gotoMainScene()
                }
                self.showToastWithDuration(string: message, duration: 3.0)
            })
        }
        else
        {
            showToastWithDuration(string: checkResult, duration: 3.0)
        }
    }

    func checkValid(securityId : String, password: String, confirmPasswrod: String) -> String{


        var passCode = ""
        var passCodeConfirm = ""
        for i in 1...6{
            passCode = passCode + (self.view.viewWithTag(i) as! UITextField).text!
            passCodeConfirm = passCodeConfirm + (self.view.viewWithTag(i + 6) as! UITextField).text!
        }
        if passCode == passCodeConfirm && passCode.characters.count == 6{
        }
        else{
            return Constants.ERROR_EMPTY_PASSWORD
        }

        if (password.characters.count == 0)
        {
            return Constants.ERROR_EMPTY_PASSWORD
        }
        else if(password.characters.count < 6)
        {
            return Constants.ERROR_INVALID_PASSWORD
        }
        else if(confirmPasswrod != password)
        {
            return Constants.ERROR_CONFIRM_PASSWORD
        }
        user.user_password = password
        defaults.setValue(passCode, forKey: Constants.USER_PASSCODE)
        return Constants.SUCCESS_PROCESS
    }


    @IBAction func setUpPasswordButtonTapped(_ sender: Any) {
        doSignUp()

    }

    @IBAction func setPasscode(_ sender: UITextField) {

        if (sender.tag < 12){
            if(sender.text!.characters.count == 1){
                (self.view.viewWithTag(sender.tag + 1) as! UITextField).becomeFirstResponder()
            }
        }
        else{
            txtPassword.becomeFirstResponder()
        }
    }



}
