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

    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width:size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x:0, y: 0, width : newSize.width, height : newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    static func getTimeString(from timeStamp: Int64) -> String{
        if (timeStamp < 60){
            return "less than a minute"
        }
        else if(timeStamp < 3600)
        {
            let value = Int(timeStamp/60)

            if value > 1 {
                return "\(value) minutes ago"
            }
            else {
                return "a minute ago"
            }
        }
        else if(timeStamp < 86400)
        {
            let value = Int(timeStamp/3600)

            if value > 1 {
                return "\(value) hours ago"
            }
            else {
                return "an hour ago"
            }
        }
        else if(timeStamp < 604800)
        {
            let value = Int(timeStamp/86400)

            if value > 1 {
                return "\(value) days ago"
            }
            else {
                return "a day ago"
            }
        }
        else if(timeStamp < 2592000){
            let value = Int(timeStamp/604800)

            if value > 1 {
                return "\(value) weeks ago"
            }
            else {
                return "a week ago"
            }
        }
        else{
            let value = Int(timeStamp/2592000)
            if value > 1 {
                return "\(value) months ago"
            }
            else {
                return "a month ago"
            }
        }
    }

    
}



