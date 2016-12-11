//
//  LoginViewController.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, UITextFieldDelegate {

    //UI controls
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!



    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true

        if (defaults.value(forKey: Constants.USER_EMAIL) != nil)
        {
            txtEmail.text = defaults.value(forKey: Constants.USER_EMAIL) as? String
            txtPassword.text = defaults.value(forKey: Constants.USER_PASSWORD) as? String

            doLogin(email: txtEmail!.text!, password: txtPassword!.text!)
        }
        setViewBorders()
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

    func setViewBorders()
    {

        emailView.layer.borderColor = UIColor.white.cgColor
        emailView.layer.borderWidth = 2
        txtEmail.tintColor = UIColor.white

        passwordView.layer.borderWidth = 2
        passwordView.layer.borderColor = UIColor.white.cgColor
        txtPassword.tintColor = UIColor.white
    }


    @IBAction func btnLoginTapped(_ sender: Any) {
        doLogin(email: txtEmail!.text!, password: txtPassword!.text!)
    }

    func doLogin(email: String, password: String)
    {
        let message = checkValid(email: email, password: password)
        if  message == Constants.SUCCESS_PROCESS
        {
            showLoadingView()
            FirebaseUserAuthentication.signIn(email: email, password: password, completion: {
                userid, success in
                self.hideLoadingView()
                if success{
                    self.gotoMainScene()
                }
                else
                {
                    self.showToastWithDuration(string: "Firebase connection failed", duration: 3.0)
                }
                
            })

        }
        else
        {
            showToastWithDuration(string: message, duration: 3.0)
        }
    }




    func textFieldDidBeginEditing(_ textField: UITextField) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == txtEmail{
            txtPassword.becomeFirstResponder()
        }
        else {
            doLogin(email: txtEmail!.text!, password: txtPassword!.text!)
        }
        textField.resignFirstResponder()
        return true
    }


    func checkValid(email: String, password: String) -> String{
        if(email.characters.count == 0)
        {
            return Constants.ERROR_EMPTY_EMAIL
        }
        else if !CommonUtils.isValideEmail(email){
            return Constants.ERROR_INVALID_EMAIL
        }
        else if (password.characters.count == 0)
        {
            return Constants.ERROR_EMPTY_PASSWORD
        }

        return Constants.SUCCESS_PROCESS
    }






}
