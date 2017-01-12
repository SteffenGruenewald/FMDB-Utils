//
//  MediaView.swift
//  OUT
//
//  Created by MidnightSun on 1/12/17.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Toast_Swift


public protocol MediaViewDelegate {
    func mediaViewDidTapped(_ mediaView: MediaView)
}

public class MediaView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    static let MEDIA_TYPE_UNKNOWN   = 0
    static let MEDIA_TYPE_VIDEO     = 1
    static let MEDIA_TYPE_IMAGE     = 2
    
    static let imageExtensionArray = ["png","jpg", "jpeg"]
    static let videoExtensionArray = ["mp4", "mov", "avi"]
    
    var urlString = "";
    var delegate : MediaViewDelegate!
    
    var player: AVPlayer!
    
    var localUrl : URL!
    
    
    
    func removeSubViewsAndLayers()
    {
    
        for subView in subviews{
            subView.removeFromSuperview()
        }
        
        if (self.layer.sublayers != nil){
            for subLayer in self.layer.sublayers!{
                subLayer.removeFromSuperlayer()
            }
        }
    }
    
    func setMedia(urlstring: String){
        
        removeSubViewsAndLayers()
        
        
        switch urlstring.getMediaType() {
        case MediaView.MEDIA_TYPE_IMAGE:
            setImage(urlstring)
            
            break
        case MediaView.MEDIA_TYPE_VIDEO:
            setVideo(urlstring)
            
            break
        default:
            break
        }
        
        
        
       
    }

    
    func setImage(_ urlstring: String)
    {
        self.makeToastActivity(.center)
        
        let imageView = UIImageView()
        imageView.frame.size = self.bounds.size
        imageView.setImageWith(storageRefString: urlstring, placeholderImage: UIImage(named:"icon_user_placeholder")!)
        self.addSubview(imageView)
        
        self.hideToastActivity()
    }
    
    func setVideo(_ urlstring: String)
    {
        
        var pathItems = urlstring.components(separatedBy: "/")
        let from = pathItems[pathItems.count - 2]
        let filename = pathItems[pathItems.count - 1]
        
       self.makeToastActivity(.center)
        
        FirebaseStorageUtils.downloadFile(from: from, filename: filename, completion: {
            url, success in
            if success{
                self.hideToastActivity()
                self.localUrl = url
                self.setVideoPlayer()
   
            }
        })
        
    }
    
    func setVideoPlayer(){
        
        removeSubViewsAndLayers()
        
        self.player = AVPlayer(url:localUrl)
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.bounds
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.layer.addSublayer(playerLayer)
        let button = UIButton()
        button.frame = self.frame
        button.addTarget(self, action: #selector(self.screenTapped), for: .touchUpInside)
        //button.backgroundColor = UIColor.red
        self.addSubview(button)
    }
    
    func playVideo()
    {
        if(player.currentItem?.currentTime().value == player.currentItem?.duration.value){
            setVideoPlayer()
        }
        player.play()
        
    }
   
    
    func pauseVideo(){
        player.pause()
        /*let imageview = self.viewWithTag(tag + 2) as! UIImageView
        imageview.isHidden = false*/
    }
    
    func screenTapped(){
        NSLog("\(player.rate) - \(player.currentItem?.currentTime().value)")
        if player.rate != 0 && player.error == nil{
            pauseVideo()
        }
        else{
            playVideo()
        }
        //delegate.mediaViewDidTapped(self)
    }

}

extension String{
    func isImageURL() -> Bool{
        
        for item in MediaView.imageExtensionArray{
            if self.lowercased().hasSuffix(item)
            {
                return true
            }
        }
        return false
        
    }
    
    func isVideoURL() -> Bool{
        
        for item in MediaView.videoExtensionArray{
            if self.lowercased().hasSuffix(item)
            {
                return true
            }
        }
        return false
        
    }
    
    func getMediaType() -> Int{
        if(isImageURL()){
            return MediaView.MEDIA_TYPE_IMAGE
        }
        else if(isVideoURL()){
            return MediaView.MEDIA_TYPE_VIDEO
        }
        
        return MediaView.MEDIA_TYPE_UNKNOWN
    }
}
