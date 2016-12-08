//
//  UTCDateTime.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation


extension Date{



    func toMillis() -> NSNumber {
        return NSNumber(value:Int64(timeIntervalSince1970 * 1000))
    }

    static func fromMillis(millis: NSNumber?) -> Date? {
        return millis.map() { number in NSDate(timeIntervalSince1970: Double(number) / 1000) as Date}
    }

    static func currentTimeInMillis(_ date: Date) -> NSNumber {
        return date.toMillis()
    }

    static func toGlobalMillis(localMillis: NSNumber) -> NSNumber
    {

        let tz = NSTimeZone.local
        let differenceSeconds = -tz.secondsFromGMT()
        return NSNumber(value: localMillis.intValue + differenceSeconds*1000)

    }

    static func toLocalMillis(globalMillis: NSNumber) -> NSNumber{
        let tz = NSTimeZone.local
        let differenceSeconds = tz.secondsFromGMT()
        return NSNumber(value: globalMillis.intValue + differenceSeconds*1000)
    }

    static func getCurrentTimeFromGlobalMillis(millis: Int) -> Date
    {
        return Date.fromMillis(millis: Date.toLocalMillis(globalMillis: NSNumber(value: millis)))!
    }

}



func getGlobalTime() -> String
{
    return "\(Date.toGlobalMillis(localMillis: Date().toMillis()))"
}

func getTimeStringfromGMTTimeMillis(timeString: String) -> Date
{
    let timeValue = Int(timeString)
    return Date.getCurrentTimeFromGlobalMillis(millis: timeValue!)
}

