//
//  AppUser.swift
//  Pracup
//
//  Created by promatics on 18/12/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

public class AppUser {
    
    static var shared = AppUser()
    
    var userData = [String:Any]()
    
  
    //defaultData.setValue(self.notifyDict as! [String:String], forKey: "notifyData")
    
    
    init() {
        
        if UserDefaults.standard.value(forKey: "userData") != nil {
            
            self.userData = ((NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: "userData") as! Data)) as? [String:Any])!
            
            
        }else {
            
            self.userData = [:]
        }
        
//        if UserDefaults.standard.value(forKey: "notifyData") != nil {
//            self.notifyData = UserDefaults.standard.value(forKey: "notifyData") as! [String:String]
//        }
        
    }
    
  
    
    var user_id: String {
        get {
            if userData["_id"] != nil {
                
                return String(userData["_id"] as? String ?? "")
                
            } else {
                
                return ""
            }
        }
    }
    

    var user_type: String? {
        get {
            if userData["user_type"] != nil {
                
                return userData["user_type"] as? String
                
            } else {
                
                return nil
            }
        }
    }
    
    
    var contact: String? {
        get {
            if userData["contact"] != nil {
                
                return userData["contact"] as? String
                
            } else {
                
                return nil
            }
        }
    }
    
    var status: String? {
        get {
            if userData["status"] != nil {
                
                return userData["status"] as? String
                
            } else {
                
                return nil
                
            }
        }
    }
    
    var firstName: String? {
        get {
            if userData["first_name"] != nil {
                
                return userData["first_name"] as? String
                
            } else {
                
                return nil
            }
        }
    }
    
    var lastName: String? {
        get {
            if userData["last_name"] != nil {
                
                return userData["last_name"] as? String
                
            } else {
                
                return nil
            }
        }
    }

    
    var email: String? {
        get {
            if userData["email"] != nil {
                
                return userData["email"] as? String
                
            } else {
                
                return nil
            }
        }
    }
    
    var image: String? {
        get {
            if userData["profile_image"] != nil {
                
                return userData["profile_image"] as? String
                
            } else {
                
                return nil
            }
        }
    }
    
    
    var addCount: Int? {
        get {
            if userData["address_count"] != nil {
                
                return userData["address_count"] as? Int
                
            } else {
                
                return nil
            }
        }
    }

    
    
}


