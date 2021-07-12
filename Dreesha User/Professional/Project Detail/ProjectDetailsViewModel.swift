//
//  ProjectDetailsViewModel.swift
//  Dreesha User
//
//  Created by promatics on 26/04/21.
//

import Foundation
class ProjectDetailsViewModel: BaseAPI {
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    
    deinit {
        print(#file, "Deinitilizer")
    }
    
    //MARK:- Variable
    
    var model : ProjectDetailModel?
    
    //MARK:- Getter
    
    func getProjectDetail() -> ProjectDetailModel?{
        return model
    }
    
    
    //MARK:- API CALL
    
    func apiProjectDetails(projectId : String , completion : @escaping(Bool , String)->()){
        
        let param = ["project_id" : projectId] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getProjectDetail), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
           
            if response == 1{
                guard let data = (result as? [String : AnyObject])?["result"] as? [String : AnyObject] else {
                    return
                }
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.model = try JSONDecoder().decode(ProjectDetailModel.self, from: jsonSer)
                    completion(true,"")
                }catch{
                    completion(false,error.localizedDescription)
                }
            }else{
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false,msg)
            }
        }
    }
}
