//
//  ProfessionalDetailsViewModel.swift
//  Dreesha User
//
//  Created by promatics on 2/31/1400 AP.
//

import Foundation
class ProfessionalDetailsViewModel: BaseAPI {
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    
    deinit {
        print(#file , "Deinitilizer")
    }
    
    var model = ProfessionalProjectsModel()
    
    //MARK:- API Call
    
    func apiGetProfProjects(professionalID : String ,limit : String,offset : String, completion : @escaping(Bool , String)->()){
        
        let param = ["professional_id" : professionalID , "limit" : limit , "offset" : offset] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getProfProjects), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                guard let data = (result as? [String : AnyObject])?["data"] as? [[String : AnyObject]] else {
                    return
                }
                do{
                    
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.model += try JSONDecoder().decode(ProfessionalProjectsModel.self, from: jsonSer)
                    completion(true , "")
                    
                }catch{
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }else{
                completion(false , "")
            }
        }
    }
}
