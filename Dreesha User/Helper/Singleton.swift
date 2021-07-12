//
//  Singleton.swift
//  Pracup
//
//  Created by promatics on 22/12/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

class Singleton {
    
    static let sharedInstance = Singleton()
    
    var badgeCount = 0
  
    func dateFormatChange(date : String, oldFormat : String, newFormat : String) ->  String {
        
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        dateFormatter.dateFormat = oldFormat
        
        guard let dateString = dateFormatter.date(from: date) else {
            
            return ""
            
        }
        
        dateFormatter.dateFormat = newFormat
        //dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        
        let dateStringToSet = dateFormatter.string(from: dateString)
        
        return dateStringToSet
        
    }
    
    func dateFormatChangeToUTC(date : String, oldFormat : String, newFormat : String) ->  String {
        
        let dateFormatter = DateFormatter()
        
        
        guard let dateString = dateFormatter.date(from: date) else {
            
            return ""
            
        }
        
        dateFormatter.dateFormat = newFormat
      
        
        let dateStringToSet = dateFormatter.string(from: dateString)
        
        return dateStringToSet
        
    }
    func dateFormatChangeLocal(date : String, oldFormat : String, newFormat : String) ->  String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = oldFormat
        
        guard let dateString = dateFormatter.date(from: date) else {
            
            return ""
            
        }
        
        dateFormatter.dateFormat = newFormat
        //dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        
        let dateStringToSet = dateFormatter.string(from: dateString)
        
        return dateStringToSet
        
    }
    
    
    func localToUTC(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    
    func utcToLocal(dateStr : String , newFormat : String)-> String?{
        let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
           dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
           
           if let date = dateFormatter.date(from: dateStr) {
               dateFormatter.timeZone = TimeZone.current
               dateFormatter.dateFormat = newFormat
           
               return dateFormatter.string(from: date)
           }
           return nil
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> String{
        
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        
        return "\(hours):\(minutes):\(seconds)"

    }

}
