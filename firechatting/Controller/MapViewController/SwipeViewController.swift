//
//  SwipeViewController.swift
//  OUT
//
//  Created by Huijing on 08/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit
import CarbonKit

class SwipeViewController: UIViewController, CarbonTabSwipeNavigationDelegate {

    
    let items = ["1", "2", "3"]
    var carbonTabSwipeNavigation = CarbonTabSwipeNavigation()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items:items, delegate : self)
        
        //        carbonTabSwipeNavigation.insertIntoRootViewController(self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: self.view)
        carbonTabSwipeNavigation.setTabBarHeight(0)
        //self.tabBarController?.tabBar.isHidden = true
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
    //Mark: - CarbonTabSwipeNavigation Delegate
    // required
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController{
        switch index {
            
        case 0:
            return (self.storyboard?.instantiateViewController(withIdentifier: "MapViewController"))!
        case 1:
            return (self.storyboard?.instantiateViewController(withIdentifier: "OuttickerViewController"))!
        default:
            return (self.storyboard?.instantiateViewController(withIdentifier: "ChattingViewController"))!
        }
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, willMoveAt index: UInt){
        
        switch index {
       
        case 0:
        self.tabBarController?.tabBar.isHidden = false
        case 1:
        self.tabBarController?.tabBar.isHidden = true
        default:
        self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    
}
