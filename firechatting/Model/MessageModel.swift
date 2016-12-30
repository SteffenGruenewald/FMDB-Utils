//
//  MessageModel.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation

class MessageModel{

    var message_id = ""
    var message_senderid = ""
    var message_receiverid = ""
    var message_time : Int64 = 0
    var message_content = ""
    var message_type = 0
    var message_date = ""
    var message_read = true
    var message_loaded = true

    static let localTableName = Constants.FIR_MESSAGEROOM
    static let localTablePrimaryKey = Constants.MESSAGE_ID
    static let localTableObject = [Constants.MESSAGE_ID: "VARCHAR(255)",
                            Constants.MESSAGE_SENDER_ID: "VARCHAR(255)",
                            Constants.MESSAGE_RECEIVER_ID: "VARCHAR(255)",
                            Constants.MESSAGE_TIME: "BIGINT",
                            Constants.MESSAGE_TYPE: "INT",
                            Constants.MESSAGE_CONTENT: "VARCHAR(255)",
                            Constants.MESSAGE_READ: "TINYINT",
                            Constants.MESSAGE_LOADED: "TINYINT"]
}
