//
//  SignUpViewController.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet weak var imvProfile: UIImageView!

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!

    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!


    
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

    }


}
