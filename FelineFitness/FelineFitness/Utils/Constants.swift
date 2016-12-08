//
//  Constants.swift
//  FelineFitness
//
//  Created by Huijing on 06/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation



class Constants {


    ///////////*********  Real time messaging  *****************///////////////




    //Room info
    static let FIR_MESSAGEROOM = "Messages"
    static let FIR_STORAGE_UPLOADDIRECTORY = "UploadFiles"

    //message item info
    static let MESSAGE_ID = "message_id"
    static let MESSAGE_SENDER_ID = "sender_id"
    static let MESSAGE_RECEIVER_ID = "receiver_id"
    static let MESSAGE_TIME = "message_time"
    static let MESSAGE_TYPE = "message_type"
    static let MESSAGE_CONTENT = "message_content"

    //Message types

    static let IS_SYSTEMMESSAGE = "0"
    static let IS_TEXTMESSAGE = "1"
    static let IS_IMAGEMESSAGE = "2"

    //system messages

    static let ISTYPING = "system_message_istyping"
    static let TYPINGFINISHED = "system_message_typingfinished"


    ///////////*********  Firebase Authentication  *****************///////////////

    //User profile image directory
    static let FIR_STORAGE_USERPROFILEDIRECTORY = "UserProfileImages"



    ///////////*********  Firebase Realtime user status management  *****************///////////////

    //Custom user Management
    static let FIR_USERINFODIRECTORY = "UserInfos"
    static let FIR_FRIENDDIRECTORY = "Friends"
    //static let FIR


    ///////////*********  Error Messages *****************///////////////



    ///////////*********  UserDefault Keywords *****************///////////////

    static let DEVICE_TOKEN = "token"
    //static let



}


//current user
var currentUser = UserModel()
//friend array
var myFriends : [FriendModel] = []
//current friend in chatting room
var currentFriend = UserModel()
//all users in server
var globalUsersArray : [UserModel] = []





