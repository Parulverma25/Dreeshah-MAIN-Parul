//
//  DetailsOfBranchViewModel.swift
//  Dreesha User
//
//  Created by promatics on 21/04/21.
//

import Foundation
class DetailsOfBranchViewModel: BaseAPI {
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    
    deinit {
        print(#file , "Deinitilizer")
    }
    
    //MARK:- Variables
    var model : ParticularBranchDetailsModel?
    
    //MARK:- Getter Functions
    
    func getBranchDetails() -> ParticularBranchDetailsModel?{
        return model
        
    }
    
    
    //MARK:- Api functions
    
    func apiBranchDetails(BranchId : String , completion : @escaping(Bool,String)->()){
        
        let param = ["branch_id" : BranchId] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getBranchDetails), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
             
            if response == 1{
                
                guard let data = (result as? [String : AnyObject])?["result"] as? [String : AnyObject] else {
                    return
                }
                
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.model = try JSONDecoder().decode(ParticularBranchDetailsModel.self, from: jsonSer)
                    completion(true,"")
                }catch{
                    completion(false,error.localizedDescription)
                }
                
            }else{
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? "Could not connect to server"
                
                completion(false,msg)
            }
        }
        
    }
}
