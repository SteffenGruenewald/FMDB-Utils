//
//  ImageDetailViewController.swift
//  Marketmaker
//
//  Created by Huijing on 12/11/2016.
//  Copyright © 2016 Big shark. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    
    var imageurl = ""
    @IBOutlet weak var imvDetailImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imvDetailImage.sd_setImage(with: URL(string: imageurl))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
