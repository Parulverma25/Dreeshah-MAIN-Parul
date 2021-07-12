//
//  AddAppointmentViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 28/04/21.
//

import Foundation
class AddAppontmentViewModel : BaseAPI{
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    
    deinit {
        print("#Deinitilizer")
    }

    
    //MARK:- APi Functions
    func hitaddAppointment(Name : String , RequestID : String ,ServiceID : String ,Subject : String ,Location : String , ReqDtl : String , Time : String ,Date : String, professionalId : String ,completion : @escaping(Bool,String)->()){
        let param = ["name" : Name , "request_id":RequestID , "service_id":ServiceID , "subject":Subject ,"location": Location, "request_details":ReqDtl , "time": Time , "date" : Date  ,"professional_id" : professionalId] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.addAppointment), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
                completion(true,(msg))
            }else{
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false,(msg))
            }
        }
    }
}
