//
//  CommonUtils.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


class CommonUtils: AnyObject{

    static func isValideEmail(_ email: String) -> Bool {

        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }


    //static func s
    static func getSortedUserArrayByName(users: [UserModel]) -> [UserModel]{
        let sortedArray = users.sorted {
            $0.user_name < $1.user_name
        }
        return sortedArray
    }


    //static get sorted friend array
    static func getSortedFriendArrayByTimes(friends: [FriendModel]) -> [FriendModel]{
        let sortedArray = friends.sorted {
            $0.friend_lastmessagetime > $1.friend_lastmessagetime
        }
        return sortedArray
    }


    //this function uses in making object from model
    //Every model has table object and it is using for local and firebase communication
    /*

    static func saveDataToLocal (srcImageData: Data, filePath: String, fileName: String, resize: Bool) -> String {

        let outputFileName = fileName


        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        var documentDirectory: NSString! = paths[0] as NSString!

        // current document directory
        fileManager.changeCurrentDirectoryPath(documentDirectory as String)

        do {
            try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }

        documentDirectory = documentDirectory.appendingPathComponent(filePath) as NSString!
        let savedFilePath = documentDirectory.appendingPathComponent(outputFileName)

        // if the file exists already, delete and write, else if create filePath
        if (fileManager.fileExists(atPath: savedFilePath)) {
            do {
                try fileManager.removeItem(atPath: savedFilePath)
            }
            catch let error as NSError {
                print("Ooops! Something went wrong: \(error)")
            }
        } else {
            fileManager.createFile(atPath: savedFilePath, contents: nil, attributes: nil)
            (srcImageData as NSData).write(toFile: savedFilePath, atomically: true)
        }

        return savedFilePath
    }*/

}



