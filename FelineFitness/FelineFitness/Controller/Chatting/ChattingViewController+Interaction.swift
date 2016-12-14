//
//  ChattingViewController+Interaction.swift
//  TSWeChat
//
//  Created by Hilen on 12/31/15.
//  Copyright © 2015 Hilen. All rights reserved.
//

import Foundation
import Photos
import MobileCoreServices


// MARK: - @protocol UIImagePickerControllerDelegate


extension ChattingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var pickerImage = UIImage()
        
        
        pickerImage = info[UIImagePickerControllerEditedImage] as! UIImage
        sendImage(pickerImage)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

// MARK: - @protocol UITextViewDelegate
extension ChattingViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {

            sendTextMessage(text: textView.text)

            textView.text = ""
            self.textViewDidChange(textView)
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if(textView.text.characters.count > 0)
        {
            if !isTyping {
                isTyping = true
                //realTimeInstance.sendTypingMessage()
            }
            writingInterval = 0
        }
        let contentHeight = textView.contentSize.height

        guard contentHeight + 21 >= kChatActionBarOriginalHeight else {
            self.actionBarHeightContraint.constant = kChatActionBarOriginalHeight
            return
        }
        NSLog("\(contentHeight)")
        if (contentHeight + 17  < kChatActionBarMaxHeight){
            self.actionBarHeightContraint.constant = contentHeight + 22
        }
        else{
            self.actionBarHeightContraint.constant = kChatActionBarMaxHeight
        }
        self.view.layoutIfNeeded()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {

        UIView.setAnimationsEnabled(false)
        let range = NSMakeRange(textView.text.characters.count - 1, 1)
        textView.scrollRangeToVisible(range)
        UIView.setAnimationsEnabled(true)
        return true
    }
}

extension ChattingViewController{

    func sendTextMessage(text: String){
        firebaseRealTimeMessageInstance.sendMessage(MessageUtils.createSendMessage(messageType: Constants.IS_TEXTMESSAGE, messageContent: text, roomId: friend.friend_roomid))
    }
}







