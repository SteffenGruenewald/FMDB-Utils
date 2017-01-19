//
//  HomeContentViewController.swift
//  OUT
//
//  Created by Huijing on 17/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class HomeContentViewController: BaseViewController {

    @IBOutlet weak var tblPager: UITableView!
    @IBOutlet weak var motherView: UIView!
    let screenSize = UIScreen.main.bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSubViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func selectVC(index : Int){
        if index == 0{
            tblPager.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
        }
        else{
            tblPager.setContentOffset(CGPoint(x: 0, y: screenSize.height) , animated: true)
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

    func addSubViewControllers(){

        motherView.frame.size = CGSize(width: screenSize.width,height: screenSize.height * 2)
        let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController")
        mapVC?.view.frame = CGRect(origin: CGPoint(x:0, y:0), size: screenSize)
        motherView.addSubview((mapVC?.view)!)
        self.addChildViewController(mapVC!)
        let friendsVC = self.storyboard?.instantiateViewController(withIdentifier: "FriendsParentViewController")
        friendsVC?.view.frame = CGRect(origin: CGPoint(x:0, y:screenSize.height), size: screenSize)
        motherView.addSubview((friendsVC?.view)!)
        self.addChildViewController(friendsVC!)
    }


}
