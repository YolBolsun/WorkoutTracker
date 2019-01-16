//
//  Utility.swift
//  WorkoutTracker
//
//  Created by Jonathan Clinton on 2/11/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import UIKit

class Utility
{
    static var dateFormatter = DateFormatter()
    static func getDate(date : String) -> Date?
    {
        if(date=="")
        {
            return nil
        }
        self.dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.date(from: date)
    }
    static func getDateString(date : Date) -> String?
    {
        self.dateFormatter.dateFormat = "MM-dd-yyyy"
        let dateString =  dateFormatter.string(from:date)
        if(dateString == "")
        {
            return nil
        }
        return dateString
    }
    static func raiseAlert(title:String, message:String, sender: UIViewController)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        sender.present(alert, animated: true, completion: nil)
    }
}
