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
    static var lastReadMessageNumber = 0

    func createCurrentReference(_ roomid: String)
    {
        ref = FIRDatabase.database().reference(withPath: Constants.FIR_MESSAGEROOM).child(roomid)
        ref.observe(FIRDataEventType.value, with: {
            (snapshot) in

            if snapshot.value == nil {
                return
            }
            self.parseReceivedMessage(snapshot)

        })


        let notificationCenter = NotificationCenter.default
        //notificationCenter.addObserver(self, selector: #selector(sendCloseChatting(_:)), name: NSNotification.Name(rawValue: "CloseChatting"), object: nil)

    }


    func parseReceivedMessage(_ snapshot: FIRDataSnapshot! )
    {
        if(snapshot != nil){
            let childref = snapshot.children.allObjects as? [FIRDataSnapshot]
            if((childref?.count)! > 0){

                NSLog("current number - %d , maxnumber - %d", FirebaseRealTimeMessage.lastReadMessageNumber, childref?.count ?? 0)

                for i in (FirebaseRealTimeMessage.lastReadMessageNumber)..<(childref?.count)!
                {
                    FirebaseRealTimeMessage.lastReadMessageNumber += 1
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

            break
        case Constants.IS_IMAGEMESSAGE:

            break
        default:
            break
        }
    }

}

var firebaseRealTimeMessageInstance = FirebaseRealTimeMessage()
