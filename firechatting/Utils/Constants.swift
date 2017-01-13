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

    static let DB_NAME = "chatting.db"



    //message item info
    static let MESSAGE_ID = "message_id"
    static let MESSAGE_SENDER_ID = "sender_id"
    static let MESSAGE_RECEIVER_ID = "receiver_id"
    static let MESSAGE_TIME = "message_time"
    static let MESSAGE_TYPE = "message_type"
    static let MESSAGE_CONTENT = "message_content"
    static let MESSAGE_READ = "message_read"
    static let MESSAGE_LOADED = "message_loaded"

    //Message types

    static let IS_SYSTEMMESSAGE = 0
    static let IS_TEXTMESSAGE = 1
    static let IS_IMAGEMESSAGE = 2

    //system messages

    static let ISTYPING = "system_message_istyping"
    static let TYPINGFINISHED = "system_message_typingfinished"



    ///////////*********  Firebase Storage  *****************///////////////

    static var FIR_STORAGE_BASE_URL: String!


    //User profile image directory
    static let FIR_STORAGE_USERPROFILEDIRECTORY = FIR_STORAGE_BASE_URL + "/UserProfileImages"
    //UploadFiles Directory
    static let FIR_STORAGE_IMAGEUPLOADDIRECTORY = FIR_STORAGE_BASE_URL + "/UploadFiles"



    ///////////*********  Firebase Realtime user status management  *****************///////////////

    //Custom user Management Directory
    static let FIR_USERINFODIRECTORY = "UserInfos"

    static let FIR_MYINFODIRECTORY = "Me"//My info directory
    static let FIR_FRIENDDIRECTORY = "Friends"//friend info directory
    //user info keywords

    //saving on firebase

    static let USER_ID = "user_id"
    static let USER_EMAIL = "user_email"
    static let USER_NAME = "user_name"
    static let USER_IMAGEURL = "user_imageURL"
    static let USER_PASSWORD = "user_password"
    static let USER_DEVICES = "user_devices"
    static let USER_DEVICE_STATUS = "user_device_status"
    static let USER_STATUS = "user_status"
    static let USER_FIRST_NAME = "user_firstname"
    static let USER_LAST_NAME = "user_lastname"
    static let USER_PHONE_NUMBER = "user_phonenumber"
    static let USER_LONGITUDE = "user_longitude"
    static let USER_LATITUDE = "user_latitude"
    static let USER_PASSCODE = "user_passcode"
    static let USER_CURRENTLOCATIONNAME = "user_locationname"
    static let USER_LOCATIONCHANGEDTIME = "user_lacationchangedtime"
    static let USER_MAPMESSAGE = "user_mapmessage"
    static let USER_OUTSTATUS = "user_outstatus"
    static let USER_OUTFILENAME = "user_outFileName"



    //friend info keywords

    static let FRIEND_ID = "friend_id"
    static let FRIEND_LASTMESSAGE = "friend_lastmessage"
    static let FRIEND_LASTMESSAGETIME = "friend_lastmessagetime"
    static let FRIEND_ROOMID = "friend_roomid"
    static let FRIEND_STATUS = "friend_status"
    static let FRIEND_UNREADMESSAGECOUNT = "friend_unreadmessagecount"
    static let FRIEND_LONGITUDE = "friend_longitude"
    static let FRIEND_LATITUDE = "friend_latitude"

    //friend status values

    static let FRIEND_PENDING = 3       //pending status : you've requested, but not
    static let FRIEND_FRIEND = 0
    static let FRIEND_UNFRIEND = 10
    static let FRIEND_BLOCKED = 8

    //user status values

    static let USER_ONLINE = 0
    static let USER_OFFLINE = 3
    static let USER_BUSY = 2

    static let USER_DEVICE_ONLINE = 0
    static let USER_DEVICE_BACKGROUND = 1
    static let USER_DEVICE_OFFLINE = 3

    ///////////*********  Error Messages *****************///////////////



    ///////////*********  UserDefault Keywords *****************///////////////

    static let DEVICE_TOKEN = "token"
    //static let



    //////////***********  Error Alert Messages ***************////////

    static let ERROR_EMPTY_EMAIL = "Please input email address"
    static let ERROR_INVALID_EMAIL = "Please input valid email address"
    static let ERROR_EMPTY_PASSWORD = "Please input password"
    static let ERROR_INVALID_PASSWORD = "Password need to have more than 6 characters"

    static let ERROR_WITH_PASSCODE = "Corrct passcode required. Please insert passcode or check it."
    static let ERROR_CONFIRM_PASSWORD = "Password does not match"
    static let ERROR_EMPTY_USERNAME = "Please input username"
    static let ERROR_NO_PROFILEIMAGE = "Please select profile iamge"
    static let ERROR_EMPTY_FIRSTNAME = "Please input your first name"
    static let ERROR_EMPTY_LASTNAME = "Please input your last name"


    static let ERROR_REGISTRATION_FAIL = "User registration failed"
    static let ERROR_REGISTRATION_ALREADY_EXISTS = "The email address is already registered"

    static let SUCCESS_PROCESS = "success"

    static let ERROR_FAIL_PROFILEIMAGE = "Profile image upload failed."

    static let ERROR_FAIL_REMOVEFROMCONTACTS = "Failed in remove from contacts"


    static let ERROR_FAIL_FRIENDREQUEST = "Failed in request friend"


    /////////************  Local Image URL ***********//////////
    static let LOCAL_PROFILEIMAGEDIRECTORY = "ProfileImage"
    static let LOCAL_UPLOADIMAGEDIRECTORY = "Upload"


    /////////************   Chatting view controller status ***********/////
    static let STATUS_RECEIEVEDMESSAGE = "message_received"

}


//current user
var currentUser = UserModel()
//friend array
var myFriends : [FriendModel] = []
//current friend in chatting room
var currentFriend = UserModel()
//all users in server
var globalUsersArray : [UserModel] = []
//current roomid
var currentRoomid = ""





