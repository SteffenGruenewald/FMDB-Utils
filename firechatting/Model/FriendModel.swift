//
//  FriendModel.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation


class FriendModel{

    var friend_user = UserModel()
    var friend_roomid = ""
    var friend_lastmessage = ""
    var friend_lastmessagetime : Int64 = 0
    var friend_status = 0
    var friend_unreadmessagecount = 0
    var friend_longitude = 0.0
    var friend_latitude = 0.0

    static let localTableName = Constants.FIR_FRIENDDIRECTORY
    static let localTablePrimaryKey = Constants.FRIEND_ID
    static var localTableObject = [Constants.FRIEND_ID: "VARCHAR(255)",
                            Constants.FRIEND_ROOMID: "VARCHAR(255)",
                            Constants.FRIEND_LASTMESSAGE: "VARCHAR(255)",
                            Constants.FRIEND_LASTMESSAGETIME: "BIGINT",
                            Constants.FRIEND_STATUS: "INT",
                            Constants.FRIEND_UNREADMESSAGECOUNT: "INT"]

    func getInfoObject() -> [String: AnyObject]{
        var post: [String: AnyObject] = [:]
        post[Constants.FRIEND_ID] = friend_user.user_id as AnyObject?
        post[Constants.FRIEND_ROOMID] = friend_roomid as AnyObject?
        post[Constants.FRIEND_LASTMESSAGE] = friend_lastmessage as AnyObject?
        post[Constants.FRIEND_STATUS] = friend_status as AnyObject?
        post[Constants.FRIEND_UNREADMESSAGECOUNT] = friend_lastmessagetime as AnyObject?
        post[Constants.FRIEND_LASTMESSAGETIME] = friend_lastmessagetime as AnyObject?
        post[Constants.FRIEND_UNREADMESSAGECOUNT] = friend_unreadmessagecount as AnyObject?
        return post
    }

    func initClass(object: [String: AnyObject])
    {
        friend_user = FirebaseUserAuthentication.getUserFromUserid((object[Constants.FRIEND_ID] as! String?)!)!
        friend_roomid = (object[Constants.FRIEND_ROOMID] as! String?)!
        friend_lastmessage = (object[Constants.FRIEND_LASTMESSAGE] as! String?)!
        friend_lastmessagetime = (object[Constants.FRIEND_LASTMESSAGETIME] as! Int64?)!
        friend_status = (object[Constants.FRIEND_STATUS] as! Int?)!
        friend_unreadmessagecount = (object[Constants.FRIEND_UNREADMESSAGECOUNT] as! Int?)!

    }

}
