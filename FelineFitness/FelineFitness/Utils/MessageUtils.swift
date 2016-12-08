//
//  MessageUtils.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation

class MessageUtils{

    static func createMessageObject(_ message: MessageModel) -> [String : AnyObject] {
        var post : [String : AnyObject] = [:]
        post[Constants.MESSAGE_ID] = message.message_id as AnyObject?
        post[Constants.MESSAGE_TIME] = message.message_time as AnyObject?
        post[Constants.MESSAGE_TYPE] = message.message_type as AnyObject?
        post[Constants.MESSAGE_CONTENT] = message.message_content as AnyObject?
        post[Constants.MESSAGE_SENDER_ID] = message.message_senderid as AnyObject?
        post[Constants.MESSAGE_RECEIVER_ID] = message.message_receiverid as AnyObject?
        return post

    }

    static func parseMessage(snapShotItem: NSDictionary?) -> MessageModel
    {
        let message = MessageModel()
        message.message_id = (snapShotItem?[Constants.MESSAGE_ID] as! String?)!
        message.message_time = (snapShotItem?[Constants.MESSAGE_TIME] as! String?)!
        message.message_type = (snapShotItem?[Constants.MESSAGE_TYPE] as! String?)!
        message.message_content = (snapShotItem?[Constants.MESSAGE_CONTENT] as! String?)!
        message.message_senderid = (snapShotItem?[Constants.MESSAGE_SENDER_ID] as! String?)!
        message.message_receiverid = (snapShotItem?[Constants.MESSAGE_RECEIVER_ID] as! String?)!
        return message
    }

    static func createSendMessage(messageType: String, messageContent: String, roomId: String) -> MessageModel
    {
        let message = MessageModel()
        message.message_id = getMessageId(roomId: roomId)
        message.message_type = messageType
        message.message_content = messageContent
        message.message_receiverid = currentFriend.user_id
        message.message_senderid = currentUser.user_id
        message.message_time = getGlobalTime()
        return message
    }

    static func getMessageId(roomId: String) -> String{
        return roomId + "\(Date.toMillis(Date()))"
    }
}


