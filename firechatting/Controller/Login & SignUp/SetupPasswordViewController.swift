//
//  SetupPasswordViewController.swift
//  OUT
//
//  Created by Huijing on 21/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit
import LocalAuthentication

class SetupPasswordViewController: BaseViewController {


    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPasswrod: UITextField!


    @IBOutlet weak var switchTouchID: UISwitch!

    var enableTouchID = false
    var touchIDDetected = false

    var user = UserModel()

    var fromWhere = 1

    static let FROM_LOGIN = 0
    static let FROM_SIGNUP = 1


    var profileImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        if (fromWhere == SetupPasswordViewController.FROM_LOGIN){
            txtPassword.isHidden = true
            txtConfirmPasswrod.isHidden = true
        }
        // Do any additional setup after loading the view.
        guard  let usingtouchid = UserDefaults.standard.value(forKey: "use_touchid") else {
            UserDefaults.standard.set(enableTouchID, forKey: "use_touchid")
            switchTouchID.isOn = enableTouchID
            return
        }
        enableTouchID = usingtouchid as! Bool
        switchTouchID.isOn = enableTouchID


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

            self.defaults.set(true, forKey: "passcode_detected")
            if(fromWhere != SetupPasswordViewController.FROM_LOGIN)
            {
                showLoadingView()
                FirebaseUserAuthentication.signUp(username: user.user_name, email: user.user_emailAddress, password: user.user_password, profileImage: profileImage, firstName: user.user_firstName, lastName: user.user_lastName, phoneNumber: user.user_phonenumber, completion: {
                    user, message in
                    self.hideLoadingView()
                    if user != nil{
                        currentUser = user!
                        firebaseUserAuthInstance.initClass()
                        self.gotoSwipeViewScene()
                        
                    }
                    self.showToastWithDuration(string: message, duration: 3.0)
                })
            }
            else{
                let vcs = self.navigationController?.viewControllers
                let loginVC = vcs?[(vcs?.count)! - 2] as! LoginViewController
                loginVC.passcodeDetected = true
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        else
        {
            showToastWithDuration(string: checkResult, duration: 3.0)
        }
    }

    func checkValid(securityId : String, password: String, confirmPasswrod: String) -> String{


        var passCode = ""
        var passCodeConfirm = ""
        if (touchIDDetected && enableTouchID){
        }
        else{
            for i in 1...6{
                passCode = passCode + (self.view.viewWithTag(i) as! UITextField).text!
                passCodeConfirm = passCodeConfirm + (self.view.viewWithTag(i + 6) as! UITextField).text!
            }
            if passCode == passCodeConfirm && passCode.characters.count == 6{
                defaults.set(passCode, forKey: "passcode")
            }
            else{
                return Constants.ERROR_EMPTY_PASSCODE
            }
        }

        if (password.characters.count == 0 && fromWhere != SetupPasswordViewController.FROM_LOGIN)
        {
            return Constants.ERROR_EMPTY_PASSWORD
        }
        else if(password.characters.count < 6 && fromWhere != SetupPasswordViewController.FROM_LOGIN)
        {
            return Constants.ERROR_INVALID_PASSWORD
        }
        else if(confirmPasswrod != password && fromWhere != SetupPasswordViewController.FROM_LOGIN)
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

    @IBAction func touchIDSetUp(_ sender: UISwitch) {
        if (enableTouchID)
        {
            enableTouchID = false
            UserDefaults.standard.set(enableTouchID, forKey: "use_touchid")
        }
        else{
            checkTouchID()
        }
    }

    func checkTouchID(){
        enableTouchID = true
        UserDefaults.standard.set(enableTouchID, forKey: "use_touchid")
        // 1. Create a authentication context
        let authenticationContext = LAContext()
        var error:NSError?

        // 2. Check if the device has a fingerprint sensor
        // If not, show the user an alert view and bail out!
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {

            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return

        }

        // 3. Check the fingerprint
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: "Only awesome people are allowed",
            reply: { [unowned self] (success, error) -> Void in

                if( success ) {

                    self.touchIDDetected = true
                }else {

                    // Check if there is an error
                    if let error = error {

                        let message = self.errorMessageForLAErrorCode(error._code)
                        self.showAlertViewAfterEvaluatingPolicyWithMessage(message)

                    }

                }

        })
    }

    func errorMessageForLAErrorCode( _ errorCode:Int ) -> String{

        var message = ""

        switch errorCode {

        case LAError.Code.appCancel.rawValue:
            message = "Authentication was cancelled by application"

        case LAError.Code.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"

        case LAError.Code.invalidContext.rawValue:
            message = "The context is invalid"

        case LAError.Code.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"

        case LAError.Code.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"

        case LAError.Code.touchIDLockout.rawValue:
            message = "Too many failed attempts."

        case LAError.Code.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"

        case LAError.Code.userCancel.rawValue:
            message = "The user did cancel"

        case LAError.Code.userFallback.rawValue:
            message = "The user chose to use the fallback"

        default:
            message = "Did not find error code on LAError object"
            
        }
        
        return message
        
    }

    func showAlertWithTitle( _ title:String, message:String ) {

        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)

        DispatchQueue.main.async { () -> Void in

            self.present(alertVC, animated: true, completion: nil)

        }

    }

    //Mark - alerts

    func showAlertViewAfterEvaluatingPolicyWithMessage( _ message:String ){

        showAlertWithTitle("Error", message: message)

    }



    func showAlertViewIfNoBiometricSensorHasBeenDetected(){

        showAlertWithTitle("Error", message: "This device does not have a TouchID sensor.")
        
    }


}
