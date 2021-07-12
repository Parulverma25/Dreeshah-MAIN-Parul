//
//  ChangePassViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 05/04/21.
//

import Foundation
class ChangePassViewModel: BaseAPI {
    //MARK:- INitilizer and Deinitilizer
    override init() {
        super.init()
    }
    deinit {
        print("# Deinit")
    }
    
    //MARK:- VAriable
    
    //MARK:- API Functions
    
    func apiChangePassword(oldPass : String , NewPass : String , completion : @escaping(Bool , String)->()){
        
        let param = ["user_id" : AppUser().user_id , "old_password" : oldPass , "new_password" : NewPass] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.changePassword), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            let msg = (result as! [String : AnyObject])["msg"] as? String ?? ""
            let msg1 = (result as! [String : AnyObject])["message"] as? String ?? ""
            if response == 1{
                completion(true , msg)
            }else{
                completion(false ,msg)
                completion(false ,msg1)
            }
        }
        
    }
}
