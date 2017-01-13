//
//  OuttickerViewController.swift
//  OUT
//
//  Created by MidnightSun on 1/9/17.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit
import MobileCoreServices
import Photos
import AssetsLibrary
import AVKit
import AVFoundation

class OuttickerViewController: BaseViewController {

    
    @IBOutlet weak var videoOutticker: UIView!
    @IBOutlet weak var imvOutticker: UIImageView!
    var outtickerImage : UIImage!
    
    var imagePicker : UIImagePickerController!
    

    @IBOutlet weak var mediaView: MediaView!
    
    //////
    @IBOutlet weak var recordVideoButton: UIButton!
    
    let maximumSecondsLengthRecordVideo = 16.0
    
    var urlString : String!
    


    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
       //            imvOutticker.setImageWith(storageRefString: currentUser.user_imageUrl, placeholderImage: #imageLiteral(resourceName: "ic_user_placeholder"))
        
 //   downloadingVideo(userid: currentUser.user_id, profileImage: outtickerImage)
       
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        urlString = currentFriend.user_outFileName
        setMediaView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        mediaView.removeSubViewsAndLayers()
    }
    
// outticker Image Button Tapped
    
    @IBAction func outtickerImageTapped(_ sender: UIButton) {
        
        selectImageSource()
    }
    
// outticker Video Button Tapped
    
    @IBAction func outtickerVideoTapped(_ sender: UIButton) {
 
        selectVideoSource()
    }
    
    func setMediaView()
    {
        mediaView.setMedia(urlstring: urlString)
    }
    
    func saveOuttickerImage(userid: String, profileImage: UIImage?){
        
        if(userid.characters.count > 0 && profileImage != nil)
        {
            FirebaseStorageUtils.uploadImage(toURL: Constants.FIR_STORAGE_IMAGEUPLOADDIRECTORY,userid: userid, image: profileImage!, completion: {
                imageURL, success in
                if success{
                    
                }
                else{
                    
                }
            })
        }
    }
    
    func saveOuttickerVideo(userid: String, url:URL?){

        showLoadingView()
        
        if(userid.characters.count > 0 && url != nil)
        {
            FirebaseStorageUtils.uploadVideo(toURL: Constants.FIR_STORAGE_IMAGEUPLOADDIRECTORY, userid: userid, url: url!, completion: {
                vidoeURL, success in
                self.hideLoadingView()
                if success{
                    currentUser.user_outFileName = vidoeURL
                    firebaseUserAuthInstance.registerUserInfo(user: currentUser)
                    self.showToastWithDuration(string: "File Uploaded successfully", duration: 3.0)
                }
                else{
                    self.showToastWithDuration(string: "File Upload Failed", duration: 3.0)
                }
            })
        }
    }
    
    
 /*   @IBAction func videoPlayBtnTapped(_ sender: UIButton) {
        
        
    }*/
 }


extension OuttickerViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String : Any]) {
    
        if(self.videoOutticker.layer.sublayers != nil){
            for layer in self.videoOutticker.layer.sublayers!{
                layer.removeFromSuperlayer()
            }
        }
        if (info[UIImagePickerControllerMediaType] as! String) == "\(kUTTypeMovie)" {
            let url = info[UIImagePickerControllerMediaURL] as! URL
            
            NSLog(url.debugDescription)
          //  mediaView.localUrl = url
          //  mediaView.setVideoPlayer()
            playVideo(url: url)
            saveOuttickerVideo(userid: currentUser.user_id, url: url)
            
           
        }else{
            outtickerImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            imvOutticker.image = outtickerImage
            saveOuttickerImage(userid: currentUser.user_id, profileImage: outtickerImage)
            
        }
   
        
        picker.dismiss(animated: true, completion: nil)
        imagePicker = nil
        
    }
    
    func playVideo(url: URL){
     
        let player = AVPlayer(url:url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.videoOutticker.bounds
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.videoOutticker.layer.addSublayer(playerLayer)
        
        let imvVideoPlayBtn = UIImageView()
        imvVideoPlayBtn.isHidden = false
        imvVideoPlayBtn.frame.size.width = videoOutticker.frame.size.width*0.3
        imvVideoPlayBtn.frame.size.height = videoOutticker.frame.height * 0.3
        imvVideoPlayBtn.frame.origin.x = videoOutticker.frame.size.width*0.5 - imvVideoPlayBtn.frame.size.width*0.5
        imvVideoPlayBtn.frame.origin.y = videoOutticker.frame.size.height*0.5 - imvVideoPlayBtn.frame.size.height*0.5
        imvVideoPlayBtn.image = UIImage(named: "ic_roundplay")
        videoOutticker.addSubview(imvVideoPlayBtn)
      
        player.play()
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelgeate
    // open gallery
    func openGallery() {
        imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    // open camera
    func openCamera() {
        imagePicker = UIImagePickerController()
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
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
    
    func selectVideoSource()
        
    {
        imagePicker = UIImagePickerController()
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.cameraCaptureMode = .video
            imagePicker.videoMaximumDuration = maximumSecondsLengthRecordVideo
            imagePicker.modalPresentationStyle = .fullScreen
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        
  
        } else {
            
            _ = UIAlertController(title: "Camera inaccessable", message: "Application cannot access the camera.", preferredStyle: .actionSheet)
        }

    }


}

extension OuttickerViewController: MediaViewDelegate{
    func mediaViewDidTapped(_ mediaView: MediaView){
        
    }
}
