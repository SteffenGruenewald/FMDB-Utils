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
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!

    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var emailAddressView: UIView!

    var profileImage : UIImage!

    var picker = UIImagePickerController()


    var fromSettings = false
    
    @IBOutlet weak var tblContentView: UITableView!

    @IBOutlet weak var btnSave: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewBorders()

        // Do any additional setup after loading the view.

        if(fromSettings){

            imvProfile.setImageWith(storageRefString: currentUser.user_imageUrl, placeholderImage: #imageLiteral(resourceName: "ic_user_placeholder"))

            txtUsername.text = currentUser.user_name
            txtFirstName.text = currentUser.user_firstName
            txtLastName.text = currentUser.user_lastName
            txtPhoneNumber.text = "\(currentUser.user_phonenumber)"
            txtEmailAddress.text = currentUser.user_emailAddress

            emailAddressView.isHidden = true
            //txtEmailAddress.text = currentUser.user_emailAddress
            btnSave.setTitle("Update Profile", for: .normal)
        }
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
        emailAddressView.layer.borderColor = UIColor.white.cgColor
        emailAddressView.layer.borderWidth = 2

    }


    @IBAction func backButtonTapped(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func profileImageTapped(_ sender: Any) {
        selectImageSource()
    }

    @IBAction func btnSignUpTapped(_ sender: Any) {
        if(fromSettings){
            saveProfile()
        }
        else{
            gotoPasswordPage()
        }
    }




    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == txtUsername{
            txtFirstName.becomeFirstResponder()
        }
        else if textField == txtFirstName{
            txtLastName.becomeFirstResponder()
        }
        else if textField == txtLastName{
            txtEmailAddress.becomeFirstResponder()
        }
        else if textField == txtEmailAddress{
            gotoPasswordPage()
        }
        textField.resignFirstResponder()
        return true
    }


    func gotoPasswordPage(){

        let message = checkValid(username: txtUsername.text!, email: txtEmailAddress.text!, firstname: txtFirstName.text!, lastname: txtLastName.text!, image: profileImage)
        if(message == Constants.SUCCESS_PROCESS){
            let setPasswordVC = storyboard?.instantiateViewController(withIdentifier: "SetupPasswordViewController") as! SetupPasswordViewController
            setPasswordVC.user.user_name = txtUsername.text!
            setPasswordVC.user.user_emailAddress = txtEmailAddress.text!
            setPasswordVC.user.user_firstName = txtFirstName.text!
            setPasswordVC.user.user_phonenumber = Int64(txtPhoneNumber.text!)!
            setPasswordVC.user.user_lastName = txtLastName.text!
            setPasswordVC.profileImage = profileImage
            self.navigationController?.pushViewController(setPasswordVC, animated: true)
        }
        else{
            showToastWithDuration(string: message, duration: 3.0)
        }

    }

    func saveProfile(){
        let message = checkValid(username: txtUsername.text!, email: txtEmailAddress.text!, firstname: txtFirstName.text!, lastname: txtLastName.text!, image: profileImage)
        if(message == Constants.SUCCESS_PROCESS){
            showLoadingView()
            FirebaseUserAuthentication.addUserProfileImage(userid: currentUser.user_id, profileImage: profileImage, completion: {
                imageUrl, success in
                self.hideLoadingView()
                if (success){
                    currentUser.user_name = self.txtUsername.text!
                    currentUser.user_emailAddress = self.txtEmailAddress.text!
                    currentUser.user_firstName = self.txtFirstName.text!
                    currentUser.user_phonenumber = Int64(self.txtPhoneNumber.text!)!
                    currentUser.user_lastName = self.txtLastName.text!
                    currentUser.user_imageUrl = imageUrl
                    firebaseUserAuthInstance.registerUserInfo(user: currentUser)
                }
            })
        }
        else{
            showToastWithDuration(string: message, duration: 3.0)
        }
    }



    func checkValid(username : String, email: String, firstname: String, lastname : String, image: UIImage?) -> String{
        if(username.characters.count == 0)
        {
            return Constants.ERROR_EMPTY_USERNAME
        }
        else if(firstname.characters.count == 0)
        {
            return Constants.ERROR_EMPTY_FIRSTNAME
        }
        else if(lastname.characters.count == 0)
        {
            return Constants.ERROR_EMPTY_LASTNAME
        }
        else if(email.characters.count == 0){
            return Constants.ERROR_EMPTY_EMAIL
        }
        else if !CommonUtils.isValideEmail(email){
            return Constants.ERROR_INVALID_EMAIL
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
