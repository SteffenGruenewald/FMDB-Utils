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



    ///////////*********  Firebase Storage  *****************///////////////

    static let FIR_STORAGE_BASE_URL = "gs://felinefitness-c8a97.appspot.com"

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

    static let USER_ID = "user_id"
    static let USER_EMAIL = "user_email"
    static let USER_NAME = "user_name"
    static let USER_IMAGEURL = "user_name"
    static let USER_PASSWORD = "user_password"
    static let USER_DEVICES = "user_devices"
    static let USER_DEVICE_STATUS = "user_device_status"
    static let USER_STATUS = "user_status"


    //user status values

    static let USER_ONLINE = 1
    static let USER_OFFLINE = 0
    static let USER_BUSY = 3

    //user device status values

    static let USER_DEVICE_ONLINE = 1
    static let USER_DEVICE_OFFLINE = 0
    static let USER_DEVICE_BACKGROUND = 2
    static let USER_DEVICE_BUSY = 3

    ///////////*********  Error Messages *****************///////////////



    ///////////*********  UserDefault Keywords *****************///////////////

    static let DEVICE_TOKEN = "token"
    //static let



    //////////***********  Error Alert Messages ***************////////

    static let ERROR_EMPTY_EMAIL = "Please input email address"
    static let ERROR_INVALID_EMAIL = "Please input valid email address"
    static let ERROR_EMPTY_PASSWORD = "Please input password"
    static let ERROR_CONFIRM_PASSWORD = "Password does not match"
    static let ERROR_EMPTY_USERNAME = "Please input username"
    static let ERROR_NO_PROFILEIMAGE = "Please select profile iamge"


    static let ERROR_REGISTRATION_FAIL = "User registration failed"
    static let ERROR_REGISTRATION_ALREADY_EXISTS = "The email address is already registered"

    static let SUCCESS_PROCESS = "success"

    static let ERROR_FAIL_PROFILEIMAGE = "Profile image upload failed."


    /////////************  Local Image URL ***********//////////
    static let LOCAL_PROFILEIMAGEDIRECTORY = "ProfileImage"
    static let LOCAL_UPLOADIMAGEDIRECTORY = "Upload"







}


//current user
var currentUser = UserModel()
//friend array
var myFriends : [FriendModel] = []
//current friend in chatting room
var currentFriend = UserModel()
//all users in server
var globalUsersArray : [UserModel] = []





