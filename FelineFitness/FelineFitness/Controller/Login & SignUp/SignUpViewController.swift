//
//  SignUpViewController.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController , UITextFieldDelegate{

    @IBOutlet weak var imvProfile: UIImageView!

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!

    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!

    var profileImage : UIImage!

    var picker = UIImagePickerController()
    
    @IBOutlet weak var tblContentView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        setViewBorders()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func setViewBorders()
    {
        usernameView.layer.borderColor = UIColor.white.cgColor
        usernameView.layer.borderWidth = 2
        emailView.layer.borderColor = UIColor.white.cgColor
        emailView.layer.borderWidth = 2
        passwordView.layer.borderColor = UIColor.white.cgColor
        passwordView.layer.borderWidth = 2
        confirmPasswordView.layer.borderColor = UIColor.white.cgColor
        confirmPasswordView.layer.borderWidth = 2

    }


    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func profileImageTapped(_ sender: Any) {
        selectImageSource()
    }

    @IBAction func btnSignUpTapped(_ sender: Any) {
        doSignUp()
    }

    func doSignUp()
    {

        tblContentView.setContentOffset(CGPoint.zero, animated: true)

        let username = txtUsername.text!
        let email = txtEmail.text!
        let password = txtPassword.text!
        let image = profileImage

        let checkResult = checkValid(username: username, email: email, password: password, image: image)

        if checkResult == Constants.SUCCESS_PROCESS{
            showLoadingView()
            FirebaseUserAuthentication.signUp(username: username, email: email, password: password, profileImage: image, completion: {
                user, message in
                self.hideLoadingView()
                if user != nil{
                    currentUser = user!
                    
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



    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == txtUsername{
            txtEmail.becomeFirstResponder()
        }
        else if textField == txtEmail{
            txtPassword.becomeFirstResponder()
        }
        else if textField == txtPassword{
            txtConfirmPassword.becomeFirstResponder()
        }
        else if textField == txtConfirmPassword{
            doSignUp()
        }
        textField.resignFirstResponder()
        return true
    }



    func checkValid(username : String, email: String, password: String, image: UIImage?) -> String{
        if(username.characters.count == 0)
        {
            return Constants.ERROR_EMPTY_USERNAME
        }
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
        else if(txtConfirmPassword.text != password)
        {
            return Constants.ERROR_CONFIRM_PASSWORD
        }
        else if(image == nil)
        {
            return Constants.ERROR_NO_PROFILEIMAGE
        }

        return Constants.SUCCESS_PROCESS
    }

}

extension SignUpViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {



    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        profileImage = info[UIImagePickerControllerEditedImage] as! UIImage

        imvProfile.image = profileImage
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelgeate
    // open gallery
    func openGallery() {

        picker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }

    // open camera
    func openCamera() {

        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {

            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }

    func selectImageSource()
    {

        self.view.endEditing(true)

        let alertController = UIAlertController(title: "Select Image Source", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)

        let selectGalleryAction = UIAlertAction(title: "Gallery", style: .default, handler: { action in
            self.openGallery()

        })
        let selectCameraAction = UIAlertAction(title: "Camera",				 style: .default, handler: { action in

            self.openCamera()

        })
        let selectCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        })
        alertController.addAction(selectGalleryAction)
        alertController.addAction(selectCameraAction)
        alertController.addAction(selectCancel)


        self.navigationController?.present(alertController, animated: true, completion: nil)


    }


}
