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
        self.navigationController?.popViewController(animated: true)
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

        let checkResult = checkValid(securityId: "", password: txtPassword.text!, confirmPasswrod: txtConfirmPasswrod.text!)

        if checkResult == Constants.SUCCESS_PROCESS{
            showLoadingView()
            FirebaseUserAuthentication.signUp(username: user.user_name, email: user.user_emailAddress, password: user.user_password, profileImage: profileImage, completion: {
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
        return Constants.SUCCESS_PROCESS
    }


    @IBAction func setUpPasswordButtonTapped(_ sender: Any) {
        doSignUp()
    }


}
