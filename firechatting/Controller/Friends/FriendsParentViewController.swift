//
//  FriendsParentViewController.swift
//  OUT
//
//  Created by Huijing on 19/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class FriendsParentViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.


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

}

extension FriendsParentViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friends", for: indexPath)

        let index = indexPath.row
        switch index {
        case 0:
            let addedMeVC = storyboard?.instantiateViewController(withIdentifier: "AddedMeFriendsListViewController") as! AddedMeFriendsListViewController
            cell.addSubview(addedMeVC.view)
            self.addChildViewController(addedMeVC)
            break

        case 1:

            let myfriendsVC = storyboard?.instantiateViewController(withIdentifier: "MyFriendListViewController") as! MyFriendListViewController
            cell.addSubview(myfriendsVC.view)
            self.addChildViewController(myfriendsVC)
            break

        case 2:
            let addFriendsVC = storyboard?.instantiateViewController(withIdentifier: "SearchUserViewController") as! SearchUserViewController
            cell.addSubview(addFriendsVC.view)
            self.addChildViewController(addFriendsVC)
        default:
            break
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath  indexPath: NSIndexPath) -> CGSize{
        return UIScreen.main.bounds.size
    }
}
