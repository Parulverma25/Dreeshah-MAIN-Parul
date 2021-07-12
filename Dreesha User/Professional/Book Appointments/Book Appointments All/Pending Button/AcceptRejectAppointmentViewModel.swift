//
//  AcceptRejectAppointmentViewModel.swift
//  Dreesha User
//
//  Created by promatics on 2/18/1400 AP.
//

import Foundation
class AcceptRejectAppointmentViewModel: BaseAPI{
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    
    deinit {
        print(#file , "Deinitilizer")
    }
    
    //MARK:- API CAll
    func apiAcceptRejectAppointment(status : String , booking_id : String , completion : @escaping(Bool , String)->()){
        
        let param = ["status" : status , "booking_id" : booking_id] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.acceptRejectAppointment), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                completion(true , "")
            }else{
                completion(false , "Something went wrong!!")
            }
        }
        
    }
}
