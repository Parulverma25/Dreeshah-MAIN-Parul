//
//  LoginViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 25/03/21.
//

import Foundation
class LoginViewModel: BaseAPI {
 
//MARK:- Initilizer and Deinitilizer
override init() {
    super.init()
}

deinit {
    print("#Deinitilizer")
}
    
//MARK:- APi Functions
func hitUserLogin(Email : String ,Password : String, UserType : String, completion : @escaping(Bool,String) -> () ) {
    
    let param = ["email":Email , "password":Password , "user_type":UserType] as baseParameters

    super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.login), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in
        if response == 1{
            completion(true,"Login Succesfull!")
            
            guard let data = result as? [String : AnyObject] else {
                return
            }
            UserDefaults.standard.set(data["token"] as? String ?? "", forKey: "token")
            print(UserDefaults.standard.value(forKey: "token") ?? "")
            UserDefaults.standard.setValue((NSKeyedArchiver.archivedData(withRootObject: data["user"] as? [String : AnyObject] ?? [:])), forKey: "userData")
            print(print(UserDefaults.standard.value(forKey: "userData")))
        } else {
            
        let msg = (((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? "Could not connect to server!")
            completion(false,msg)
        }
    }
    
 
}
}
