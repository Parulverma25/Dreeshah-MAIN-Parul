//
//  CurrentSession.swift
//  Dreesha User
//
//  Created by Apple on 25/03/21.
//

import Foundation
import UIKit


class CurrentSession {
 
    static let shared = CurrentSession()
    
    
    var isUser: Bool = false
    var isProfesstional: Bool = false
    var isPhotographer: Bool = false
    
    var isProfesstionalSignUp: Bool = false
    
    var isServiceListProfesstional: Bool = false
    
    private init () {
        print("Private")
    }
    
    
}
