//
//  ProjectListingViewModel.swift
//  Dreesha User
//
//  Created by promatics on 26/04/21.
//

import Foundation
class ProjectListingViewModel : BaseAPI{
    //MARK:- Initilizer and Deinitilizer
    
    override init() {
        super.init()
    }
    
    deinit {
        print(#file , "Deinitilizer")
    }
    
    //MARK:- Variables
    var model = ProjectListingModel()
    
    
    //MARK:- API CALL
    
    func apiGetProjectList(limit : String , offset : String , completion : @escaping(Bool , String)->()){
        let param = ["offset" : offset , "limit" : limit] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getPaginatedProjects), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                
                guard let data = (result as? [String : AnyObject])?["data"] as? [[String : AnyObject]]else {
                    return
                }
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.model = try JSONDecoder().decode(ProjectListingModel.self, from: jsonSer)
                    completion(true , message ?? "")
                }catch{
                    completion(false,error.localizedDescription)
                }
                
            }else{
                
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? "Could not connect to server"
                
                completion(false , msg)
            }
        }
    }
}
