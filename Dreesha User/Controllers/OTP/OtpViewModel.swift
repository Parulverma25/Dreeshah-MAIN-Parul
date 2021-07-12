//
//  OtpViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 07/04/21.
//

import Foundation
class OtpViewModel: BaseAPI {
   //MARK:- Initilizer and Deinitilizer
   override init() {
       super.init()
   }

   deinit {
       print("#Deinitilizer")
   }
       
   //MARK:- APi Functions
    func hitUserLogin(OTP : String ,tokenVal : String, completion : @escaping(Bool,String) -> () ) {
       
    let param = ["otp": OTP , "token" : tokenVal ] as baseParameters
    
    
    super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.OtpVerification), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
        let msg = (result as? [String : AnyObject])?["msg"] as? String ?? ""
        if response == 1{
            completion(true , msg)
        }else{
            completion(false ,msg)
        }
    }
    
}
}
