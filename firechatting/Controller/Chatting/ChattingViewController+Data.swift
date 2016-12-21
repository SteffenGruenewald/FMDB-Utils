//
//  TSChatViewController+TestData.swift
//  TSWeChat
//
//  Created by Hilen on 3/1/16.
//  Copyright © 2016 Hilen. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

// MARK: - @extension TSChatViewController


extension ChattingViewController {
    

    
    func receivedMessage(_ notification: Notification)
    {
        for i in itemDataSource.count..<messages.count{
            addChattingList(messages[i])
        }
    }

    
    func addChattingList(_ chatting : MessageModel)
    {
        self.itemDataSource.append(chatting)
        let insertIndexPath = NSIndexPath(row: itemDataSource.count - 1, section: 0)
        tblChatList.insertRowsAtBottom(rows: [insertIndexPath])        
    }


    func readChatOnce(){
        showLoadingView()
        firebaseRealTimeMessageInstance.readChat(completion: {
            success, _ in
            self.hideLoadingView()
            if success{
                self.itemDataSource = messages
                self.tblChatList.reloadData()
                self.tblChatList.scrollBottomToLastRow()
            }

        })
    }
    

}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //NSLog("\(itemDataSource.count)")
        return itemDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        var resultcell = UITableViewCell()
        let chatItem = itemDataSource[indexPath.row]

        if chatItem.message_type == Constants.IS_TEXTMESSAGE
        {
            let time = getTimeStringfromGMTTimeMillis(timeString: chatItem.message_time)

            let timeString = time.description

            //when chatting item is character messaging
            if chatItem.message_senderid != currentUser.user_id
            {
                //Display message sent by self

                let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverChatTextCell", for: indexPath) as! ReceiverChatTextCell
                cell.imvReceiverProfile.setImageWith(storageRefString: friend.friend_user.user_imageUrl, placeholderImage: UIImage(named: "ic_user_placeholder")!)
                cell.lblChatContent.text = chatItem.message_content
                cell.lblTime.text = timeString//chatItem.message_time
                resultcell = cell as UITableViewCell
            }
            else
            {

                //Display message received from adviser
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderChatTextCell", for: indexPath) as! SenderChatTextCell
                cell.lblChatContent.text = chatItem.message_content
                cell.lblTime.text = timeString//chatItem.message_time
                cell.imvSenderImage.setImageWith(storageRefString: currentUser.user_imageUrl, placeholderImage: UIImage(named: "ic_user_placeholder")!)
                resultcell = cell as UITableViewCell
            }
        }
        else if chatItem.message_type == Constants.IS_IMAGEMESSAGE{

            //when chatting item is image

            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatImageCell", for: indexPath) as! ChatImageCell
            let imageURL = chatItem.message_content.components(separatedBy: "-")[0]
            let imageSizeString = chatItem.message_content.components(separatedBy: "-")[1]


            cell.imvPhoto.sd_setImage(with: URL(string: imageURL))
            cell.lblTime.text = chatItem.message_time

            let imageSize = getImageCellSize(sizeString: imageSizeString)
            cell.imageHeightConstraint.constant = imageSize[1]
            if (chatItem.message_senderid == currentUser.user_id)
            {
                cell.imageLeadingContraint.constant = self.view.bounds.size.width - imageSize[0] - 50
                cell.imageTrailingConstraint.constant = 50
                cell.lblTime.textAlignment = .right

            }

            else
            {
                cell.imageLeadingContraint.constant = 60
                cell.imageTrailingConstraint.constant = self.view.bounds.size.width - imageSize[0] - 60

                cell.lblTime.textAlignment = .left
            }

            resultcell = cell as UITableViewCell
        }
        return resultcell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //let chatItem = itemDataSource[indexPath.row]
        self.view.endEditing(true)

        /*if chatItem.message_type == "1"{

            //when you select image chatting item, you can show image detail
            let imageDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController

            let imageURL = chatItem.message_content!.components(separatedBy: "-")[0]
            //NSLog("\(chatItem.message_content)")



            imageDetailVC.imageurl = imageURL
            self.navigationController?.pushViewController(imageDetailVC, animated: false)



        }*/
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }


    func tableViewDidTapped() {
        self.view.endEditing(true)
    }


    func getImageCellSize(sizeString: String) -> [CGFloat]
    {
        var cellSize : [CGFloat] = []
        let size = sizeString.components(separatedBy: "X")
        let imageWidth = (CGFloat)(Float(size[0])!)
        let imageHeight = (CGFloat)(Float(size[1])!)

        let maxWidth = self.view.bounds.width - 110

        let maxHeight = self.view.bounds.height - 360

        if(imageWidth <= maxWidth && imageHeight <= maxHeight)
        {
            cellSize.append(imageWidth)
            cellSize.append(imageHeight)
        }
        else if (imageWidth > maxWidth && imageHeight < maxHeight)
        {
            cellSize.append(maxWidth)
            cellSize.append(imageHeight * maxWidth / imageWidth)
        }
        else if(imageWidth < maxWidth && imageHeight > maxHeight)
        {
            cellSize.append(imageWidth * maxHeight / imageHeight)
            cellSize.append(maxHeight)
        }
        else
        {
            let scale = max(imageWidth / maxWidth, imageHeight / maxHeight)
            cellSize.append(imageWidth / scale)
            cellSize.append(imageHeight / scale)
        }

        return cellSize
    }
    

}
