//
//  ViewController.swift
//  FelineFitness
//
//  Created by Huijing on 06/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit
import Toast_Swift




class BaseViewController: UIViewController {

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    func showToastWithDuration(string: String!, duration: Double) {
        self.view.makeToast(string, duration: duration, position: .bottom)
    }

    func showLoadingView()
    {
        self.view.isUserInteractionEnabled = false
        self.view.makeToastActivity(.center)
    }

    func hideLoadingView()
    {
        self.view.isUserInteractionEnabled = true
        self.view.hideToastActivity()
    }

    func showLoadingViewWithTitle(title: String)
    {
        // display toast with an activity spinner

    }


    func gotoSwipeViewScene()
    {
        let swipeViewCon = self.storyboard?.instantiateViewController(withIdentifier: "SwipeViewController")
     
        self.navigationController?.pushViewController(swipeViewCon!, animated:true)
    }

    func gotoStartScene()
    {
        let mainNavVC = self.storyboard?.instantiateViewController(withIdentifier: "StartNavBar")
        self.present(mainNavVC!, animated: true, completion: nil)
    }

}

