//
//  FirebaseRealTimeMessage.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation
import Firebase
//import FirebaseMessaging
import FirebaseDatabase

class FirebaseRealTimeMessage{

    var ref: FIRDatabaseReference!
    // var refUser: FIRDatabaseReference!

    static var lastReadMessageid = ""
    var lastReadMessageNumber = 0

    var lastMessageTime = 0

    func createCurrentReference(_ roomid: String)
    {
        messages = [];
        lastReadMessageNumber = 0
        lastMessageTime = 0
        ref = FIRDatabase.database().reference(withPath: Constants.FIR_MESSAGEROOM).child(roomid)
        ref.observe(FIRDataEventType.value, with: {
            (snapshot) in

            if snapshot.value == nil {
                return
            }
            self.parseReceivedMessage(snapshot)

        })
    }


    func parseReceivedMessage(_ snapshot: FIRDataSnapshot! )
    {
        if(snapshot != nil){
            let childref = snapshot.children.allObjects as? [FIRDataSnapshot]

            NSLog("\(snapshot.value)")
            if((childref?.count)! > 0){

                NSLog("current number - %d , maxnumber - %d", self.lastReadMessageNumber, childref?.count ?? 0)

                for i in 0..<(childref?.count)!
                {
                    self.lastReadMessageNumber += 1
                    let postDict = childref?[i].value as? NSDictionary

                    if (postDict != nil){
                        NSLog("\(postDict)")
                        let message = MessageUtils.parseMessage(snapShotItem: postDict)
                        messageProcess(message: message)
                    }
                }
                
                
            }
        }
    }


    func messageProcess(message: MessageModel)
    {
        switch message.message_type {
        case Constants.IS_SYSTEMMESSAGE:

            break
        case Constants.IS_TEXTMESSAGE:
            if(Int(message.message_time)! > lastMessageTime){
                messages.append(message)
                lastMessageTime = Int(message.message_time)!
                 NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.STATUS_RECEIEVEDMESSAGE), object: nil)
            }
            break
        case Constants.IS_IMAGEMESSAGE:
            if(Int(message.message_time)! > lastMessageTime){
                messages.append(message)
                lastMessageTime = Int(message.message_time)!

                NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.STATUS_RECEIEVEDMESSAGE), object: nil)
            }
            break
        default:
            break
        }
    }

    func readChatOnce(completion: @escaping (Bool) -> ()){

        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
        }) {
            (error) in
            print(error.localizedDescription)
        }

    }

    func sendMessage(_ message: MessageModel){
        let post = MessageUtils.createMessageObject(message)
        ref.child(message.message_id).setValue(post)
    }

}

var firebaseRealTimeMessageInstance = FirebaseRealTimeMessage()
var messages : [MessageModel] = [];
