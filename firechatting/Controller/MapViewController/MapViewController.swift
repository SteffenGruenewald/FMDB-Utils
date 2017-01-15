//
//  MapViewController.swift
//  OUT
//
//  Created by Huijing on 29/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import UIKit
import MapKit
import FirebaseStorageUI


class MapViewController: BaseViewController, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var txtmessageContentView: UITextView!
    @IBOutlet weak var imvFriend: UIImageView!
    @IBOutlet weak var lblName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

               // Do any additional setup after loading the view
        //mapView.delegate = self
        mapView.showsBuildings = true
        mapView.showsUserLocation = true

        lblName.text = currentUser.user_firstName + " " + currentUser.user_lastName
        imvFriend.setImageWith(storageRefString: currentUser.user_imageUrl, placeholderImage: UIImage(named:"icon_user_placeholder")!)

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
       
    }


    override func viewWillAppear(_ animated: Bool) {
        arrangeFriends()
    }


    func arrangeFriends() {
        var index = 0
        mapView.removeAnnotations(mapView.annotations)
        for friend in myFriends{
            index += 1
            let info = StarbuckAnnotation(coordinate: CLLocationCoordinate2D(latitude: friend.friend_user.user_latitude, longitude: friend.friend_user.user_longitude))
            info.friend = friend
            info.title = friend.friend_user.user_firstName + " " + friend.friend_user.user_lastName
            info.subtitle = friend.friend_user.user_currentLocationName
            mapView.addAnnotation(info)
        }

        setRegionForLocation(location : CLLocationCoordinate2D(latitude: currentUser.user_latitude, longitude: currentUser.user_longitude), spanRadius : 1609.00*(UserDefaults.standard.value(forKey: "distance") as! Double), animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func setRegionForLocation(
        location:CLLocationCoordinate2D,
        spanRadius:Double,
        animated:Bool)
    {
        let span = 2.0 * spanRadius
        let region = MKCoordinateRegionMakeWithDistance(location, span, span)
        mapView.setRegion(region, animated: animated)
    }


    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }

        let imageView = UIImageView()
        let customAnnotation = annotation as! StarbuckAnnotation

        imageView.setImageWith(storageRefString: customAnnotation.friend.friend_user.user_imageUrl, placeholderImage: UIImage(named:"ic_user_placeholder")!)
        let image = CommonUtils.resizeImage(image: imageView.image!, targetSize: CGSize(width: 30, height: 30))

        annotationView?.layer.cornerRadius = 15
        annotationView?.layer.masksToBounds = true
        /*annotationView?.layer.borderWidth = 1.5
        annotationView?.layer.borderColor = UIColor.white.cgColor*/
        annotationView?.image = image
        return annotationView

    }


    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        let starbucksAnnotation = view.annotation as! StarbuckAnnotation
        currentFriend = starbucksAnnotation.friend.friend_user
        currentRoomid = starbucksAnnotation.friend.friend_roomid

        lblName.text = currentFriend.user_firstName + " " + currentFriend.user_lastName
        imvFriend.setImageWith(storageRefString: currentFriend.user_imageUrl, placeholderImage: UIImage(named:"icon_user_placeholder")!)
        txtmessageContentView.text = currentFriend.user_mapMessage


        let label = UILabel()
        label.text = currentFriend.user_currentLocationName + " (\(CommonUtils.getTimeString(from: (getGlobalTime() - currentFriend.user_locationChangedTime)/1000)))"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        NSLog(currentFriend.user_currentLocationName)
        label.frame = CGRect(x: 15 - label.intrinsicContentSize.width/2, y: -15, width: label.intrinsicContentSize.width, height: label.intrinsicContentSize.height)

        view.layer.masksToBounds = false
        view.addSubview(label)

    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }

            view.layer.masksToBounds = true
        }
    }


    func keyboardWillShow(_ notification: Notification)
    {
        self.keyboardControl(notification, isShowing: true)
    }

    func keyboardWillHide(_ notification: Notification)
    {
        self.keyboardControl(notification, isShowing: false)
    }

    func keyboardControl(_ notification: Notification, isShowing: Bool)
    {
        var userInfo = notification.userInfo!
        let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        let curve = (userInfo[UIKeyboardAnimationCurveUserInfoKey]! as AnyObject).uint32Value

        /*let convertedFrame = self.view.convert(keyboardRect!, from: nil)
        let heightOffset = self.view.bounds.size.height - convertedFrame.origin.y*/
        let options = UIViewAnimationOptions(rawValue: UInt(curve!) << 16 | UIViewAnimationOptions.beginFromCurrentState.rawValue)
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey]! as AnyObject).doubleValue


        UIView.animate(
            withDuration: duration!,
            delay: 0,
            options: options,
            animations: {
                if(isShowing){
                    self.view.frame.origin.y = -(keyboardRect?.height)! + 49
                }
                else{
                    self.view.frame.origin.y = 0
                }

        },
            completion: { bool in

        })
    }

    @IBAction func settingBtnTapped(_ sender: Any) {
        let settingViewCon = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController")
        
        self.navigationController?.pushViewController(settingViewCon!, animated:true)
    }

    @IBAction func gotoSearchUserTapped(_ sender: Any) {
        let searchUserViewCon = self.storyboard?.instantiateViewController(withIdentifier: "SearchUserViewController")
        
        self.navigationController?.pushViewController(searchUserViewCon!, animated:true)
    }
   
    @IBAction func gotoFriendBtnTapped(_ sender: Any) {
        let myFriendViewCon = self.storyboard?.instantiateViewController(withIdentifier: "MyFriendListViewController")
        
        self.navigationController?.pushViewController(myFriendViewCon!, animated:true)
    }
}
