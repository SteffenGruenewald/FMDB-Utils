//
//  TSChatViewController+Keyboard.swift
//  TSWeChat
//
//  Created by Hilen on 12/18/15.
//  Copyright © 2015 Hilen. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

//http://stackoverflow.com/questions/4279730/keep-uitableview-static-when-inserting-rows-at-the-top/11602040#11602040 Keep uitableview static when inserting rows at the top



// MARK: - @extension ChattingViewController
extension ChattingViewController {
    /**
     键盘控制
     */
    func keyboardControl() {
        /**
         Keyboard notifications
         */
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: .UIKeyboardDidHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification)
    {
        self.keyboardControl(notification, isShowing: true)
    }
    
    func keyboardDidShow(_ notification: Notification)
    {
        
    }
    func keyboardWillHide(_ notification: Notification)
    {
        self.keyboardControl(notification, isShowing: false)
    }
    func keyboardDidHide(_ notification: Notification)
    {
        
    }
    
    func keyboardControl(_ notification: Notification, isShowing: Bool)
    {
        var userInfo = notification.userInfo!
        let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        let curve = (userInfo[UIKeyboardAnimationCurveUserInfoKey]! as AnyObject).uint32Value
        
        let convertedFrame = self.view.convert(keyboardRect!, from: nil)
        let heightOffset = self.view.bounds.size.height - convertedFrame.origin.y
        let options = UIViewAnimationOptions(rawValue: UInt(curve!) << 16 | UIViewAnimationOptions.beginFromCurrentState.rawValue)
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey]! as AnyObject).doubleValue
        
        tblChatList.stopScrolling()
        //self.actionBarPaddingBottomConstranit?.updateOffset(amount: -heightOffset)
        //self.actionBarPaddingBottomConstraint.constant = heightOffset
        

        
        UIView.animate(
            withDuration: duration!,
            delay: 0,
            options: options,
            animations: {
                if isShowing{
                    self.tblChatList.scrollToBottom(animated: false)
                    self.keyboardHeightConstraint = heightOffset
                    self.chatActionBarView.frame.origin.y = self.view.bounds.size.height - self.chatActionBarView.frame.size.height - heightOffset
                    //self.tblChatList.frame.size.height -=  heightOffset

                }
                else
                {

                    self.keyboardHeightConstraint = 0
                    self.chatActionBarView.frame.origin.y = self.view.bounds.size.height - self.chatActionBarView.frame.size.height
                    //self.tblChatList.frame.size.height +=  heightOffset
                }
            },
            completion: { bool in
                if isShowing{

                    self.actionBarPaddingBottomConstraint.constant = self.keyboardHeightConstraint

                }
                else
                {
                    self.actionBarPaddingBottomConstraint.constant = 0
                }

                
        })
    }
    
}
//select image source action
extension ChattingViewController {
    
    
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
    
    
    // MARK: - UIImagePickerControllerDelgeate
    // open gallery
    func openGallery() {
        
        picker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    // open camera
    func openCamera() {
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func sendImage(_ pickerImage: UIImage) {
        
       
        let imageData = UIImageJPEGRepresentation(pickerImage, 0.5)
        

    }
    
        

}






