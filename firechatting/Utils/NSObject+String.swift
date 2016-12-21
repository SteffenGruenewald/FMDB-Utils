//
//  NSObject+String.swift
//  Marketmaker
//
//  Created by Big shark on 30/10/2016.
//  Copyright © 2016 Big shark. All rights reserved.
//


import Foundation
import UIKit

extension NSObject {
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
    
   
    class var identifierOfClass: String {
        return String(format: "%@_identifier", self.nameOfClass)
    }
}


