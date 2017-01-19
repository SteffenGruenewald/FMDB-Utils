//
//  LoginViewController.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit
import LocalAuthentication
import FacebookCore
import FacebookLogin


class LoginViewController: BaseViewController, UITextFieldDelegate {

    //UI controls
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    var passcodeDetected = false

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        setViewBorders()
        checkPassCodeDetected()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func gotoSetupPassword(){
        let passVC = storyboard?.instantiateViewController(withIdentifier: "SetupPasswordViewController") as! SetupPasswordViewController
        passVC.fromWhere = SetupPasswordViewController.FROM_LOGIN
        self.navigationController?.pushViewController(passVC, animated: true)
    }

    func checkPassCodeDetected() {

        guard let detected = UserDefaults.standard.value(forKey: "passcode_detected") else{
            return
        }
        let passcode_detected = detected as! Bool
        if passcode_detected{
            guard let usingtouchid = defaults.value(forKey: "use_touchid") else {
                gotoSetupPassword()
                return
            }

            if (usingtouchid as! Bool)
            {
                checkTouchID()
            }
            else{
                checkPassCode()
            }
        }
        else{
            gotoSetupPassword()
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
        self.view.endEditing(true)
        let message = checkValid(email: email, password: password)

        if  message == Constants.SUCCESS_PROCESS
        {
            if (passcodeDetected){
                showLoadingView()

                FirebaseUserAuthentication.signIn(email: email, password: password, completion: {
                    userid, success in
                    self.hideLoadingView()

                    if success{
                        if self.passcodeDetected{
                            self.gotoSwipeViewScene()
                        }
                        else{
                            self.checkPassCodeDetected()
                        }
                    }
                    else
                    {
                        self.showToastWithDuration(string: message, duration: 3.0)
                    }
                    
                })
            }
            else{
                checkPassCodeDetected()
            }

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


    func getUserInfoAndGotoMainScene(userid: String){
        self.showLoadingView()
        FirebaseUserAuthentication.initUserInfo(userid: userid, completion: {_,success in
            self.hideLoadingView()
            if success{
                self.gotoSwipeViewScene()
            }
        })
    }

    func checkPassCode(){
        let checkPassCodeVC = self.storyboard?.instantiateViewController(withIdentifier: "PassCodeCheckViewController")
        self.navigationController?.pushViewController(checkPassCodeVC!, animated: true)
    }

    func checkTouchID(){
        let authenticationContext = LAContext()
        var error:NSError?

        // 2. Check if the device has a fingerprint sensor
        // If not, show the user an alert view and bail out!
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {

            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return

        }
        self.view.isUserInteractionEnabled = false

        // 3. Check the fingerprint
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: "Only awesome people are allowed",
            reply: { [unowned self] (success, error) -> Void in

                if( success ) {
                    self.passcodeDetected = true

                    self.view.isUserInteractionEnabled = true
                    if (self.defaults.value(forKey: Constants.USER_EMAIL) != nil)
                    {
                        self.txtEmail.text = self.defaults.value(forKey: Constants.USER_EMAIL) as? String
                        self.txtPassword.text = self.defaults.value(forKey: Constants.USER_PASSWORD) as? String

                        let userid = self.defaults.value(forKey: Constants.USER_ID) as! String


                        self.getUserInfoAndGotoMainScene(userid: userid)

                        //doLogin(email: (defaults.value(forKey: Constants.USER_EMAIL) as? String)!, password: (defaults.value(forKey: Constants.USER_PASSWORD) as? String)!)
                    }

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

        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in 
            self.checkTouchID()
        })

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
    
    @IBAction func facebookLoginButtonTapped(_ sender: UIButton) {
        let loginManager = LoginManager()

        loginManager.logIn([.publicProfile , .email, .userFriends], viewController: self, completion: {
            loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                self.getFBUserInfo()
            }
        })


    }

    func getFBUserInfo() {

        showLoadingView()
        let request = GraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, picture.type(large), email"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        request.start { (response, result) in

            switch result {
            case .success(let value):
                let result = value.dictionaryValue
                let resultData: [String: AnyObject] = result as! [String: AnyObject]


                let user = UserModel()
                user.user_id = "fb" + (resultData["id"] as! String)

                user.user_firstName = resultData["first_name"] as! String
                user.user_lastName = resultData["last_name"] as! String
                user.user_emailAddress = resultData["email"] as! String
                user.user_imageUrl = (((resultData["picture"] as! [String: AnyObject])["data"] as! [String: AnyObject])["url"] as? String)!
                currentUser = user
                FirebaseUserAuthentication.loginWithFacebook(user: user, completion: {
                    success in
                    self.hideLoadingView()
                    if success{



                        UserDefaults.standard.set(user.user_emailAddress, forKey: Constants.USER_EMAIL)
                        UserDefaults.standard.set("", forKey: Constants.USER_PASSWORD)
                        UserDefaults.standard.set(user.user_id, forKey: Constants.USER_ID)


                        if (self.passcodeDetected){
                            self.gotoSwipeViewScene()
                        }
                        else{
                            UserDefaults.standard.set(false, forKey: "passcode_detected")
                            self.checkPassCodeDetected()
                        }
                    }

                })

            case .failed(let error):
                print(error)
                self.hideLoadingView()
            }
        }
    }




}
