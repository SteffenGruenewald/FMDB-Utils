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

        doLogin()
    }

    func doLogin()
    {
        gotoMainScene()
    }




    func textFieldDidBeginEditing(_ textField: UITextField) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        return true
    }

    func gotoMainScene()
    {
        let mainNavVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar")
        self.present(mainNavVC!, animated: true, completion: nil)
    }






}
