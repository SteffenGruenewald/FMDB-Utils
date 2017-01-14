//
//  UserEntityt.swift
//  FelineFitness
//
//  Created by Huijing on 06/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation


class UserModel{

    var user_id = ""
    var user_password = ""
    var user_name = ""
    var user_firstName = ""
    var user_lastName = ""
    var user_phonenumber : Int64 = 0
    var user_securitycode : Int64 = 0
    var user_emailAddress = ""
    var user_status = 0
    var user_imageUrl = ""
    var user_devices : [String] = []
    var user_ismyfriend = false
    var user_longitude = 0.0
    var user_latitude = 0.0
    var user_currentLocationName = ""
    var user_locationChangedTime: Int64 = 0
    var user_mapMessage = ""
    var user_outStatus = true
    var user_outFileName = ""


    static let localTableName = Constants.FIR_USERINFODIRECTORY
    static let localTablePrimaryKey = Constants.USER_ID
    static let localTableObject = [Constants.USER_ID: "TEXT",
                                   Constants.USER_NAME: "TEXT",
                                   Constants.USER_FIRST_NAME: "TEXT",
                                   Constants.USER_LAST_NAME: "TEXT",
                                   Constants.USER_PHONE_NUMBER: "BIGINT",
                                   Constants.USER_EMAIL: "TEXT",
                                   Constants.USER_STATUS: "INT",
                                   Constants.USER_IMAGEURL: "TEXT",
                                   Constants.USER_LONGITUDE: "DOUBLE",
                                   Constants.USER_LATITUDE: "DOUBLE",
                                   Constants.USER_CURRENTLOCATIONNAME: "TEXT",
                                   Constants.USER_LOCATIONCHANGEDTIME: "BIGINT",
                                   Constants.USER_MAPMESSAGE: "TEXT",
                                   Constants.USER_OUTSTATUS: "TINYINT",
                                   Constants.USER_OUTFILENAME: "TEXT"
    ]

    func getInfoObject() -> [String: AnyObject]
    {
        var post : [String: AnyObject] = [:]
        post[Constants.USER_ID] = user_id as AnyObject?
        post[Constants.USER_NAME] = user_name as AnyObject?
        post[Constants.USER_FIRST_NAME] = user_firstName as AnyObject?
        post[Constants.USER_LAST_NAME] = user_lastName as AnyObject?
        post[Constants.USER_PHONE_NUMBER] = user_phonenumber as AnyObject?
        post[Constants.USER_EMAIL] = user_emailAddress as AnyObject?
        post[Constants.USER_STATUS] = user_status as AnyObject?
        post[Constants.USER_IMAGEURL] = user_imageUrl as AnyObject?
        post[Constants.USER_LONGITUDE] = user_longitude as AnyObject?
        post[Constants.USER_LATITUDE] = user_latitude as AnyObject?
        post[Constants.USER_MAPMESSAGE] = user_mapMessage as AnyObject?
        post[Constants.USER_OUTSTATUS] = user_outStatus as AnyObject?
        post[Constants.USER_OUTFILENAME] = user_outFileName as AnyObject?
        return post
    }

    func initClass(object: [String: AnyObject]){
        //NSLog("\(object)")
        
        if(object[Constants.USER_ID] != nil){
        user_id = object[Constants.USER_ID] as! String
        }
        if(object[Constants.USER_NAME] != nil){
        user_name = object[Constants.USER_NAME] as! String
        }
        if(object[Constants.USER_FIRST_NAME] != nil){
        user_firstName = object[Constants.USER_FIRST_NAME] as! String
        }
        if(object[Constants.USER_LAST_NAME] != nil){
        user_lastName = object[Constants.USER_LAST_NAME] as! String
        }
        if(object[Constants.USER_PHONE_NUMBER] != nil){
        user_phonenumber = object[Constants.USER_PHONE_NUMBER] as! Int64
        }
        if(object[Constants.USER_EMAIL] != nil){
        user_emailAddress = object[Constants.USER_EMAIL] as! String
        }
        if(object[Constants.USER_STATUS] != nil){
        user_status = object[Constants.USER_STATUS] as! Int
        }
        if(object[Constants.USER_IMAGEURL] != nil){
        user_imageUrl = object[Constants.USER_IMAGEURL] as! String
        }
        if(object[Constants.USER_LONGITUDE] != nil){
        user_longitude = object[Constants.USER_LONGITUDE] as! Double
        }
        if(object[Constants.USER_LATITUDE] != nil){
        user_latitude = object[Constants.USER_LATITUDE] as! Double
        }
        if(object[Constants.USER_MAPMESSAGE] != nil){
            user_mapMessage = object[Constants.USER_MAPMESSAGE] as! String
        }
        if(object[Constants.USER_LOCATIONCHANGEDTIME] != nil){
            user_currentLocationName = object[Constants.USER_CURRENTLOCATIONNAME] as! String
            user_locationChangedTime = object[Constants.USER_LOCATIONCHANGEDTIME] as! Int64
        }
        if(object[Constants.USER_MAPMESSAGE] != nil)
        {
            user_mapMessage = object[Constants.USER_MAPMESSAGE] as! String
        }
        if (object[Constants.USER_OUTSTATUS] != nil){
            user_outStatus = object[Constants.USER_OUTSTATUS] as! Bool
        }
        if(object[Constants.USER_OUTFILENAME] != nil){
            user_outFileName = object[Constants.USER_OUTFILENAME] as! String
        }
    }

}

