//
//  ProfessionalListViewModel.swift
//  Dreesha User
//
//  Created by promatics on 2/21/1400 AP.
//

import Foundation
class ProfessionalListViewModel : BaseAPI{
    
    //MARK:- Initilizer and Deinitilizer
    
    override init() {
        super.init()
    }
    
    deinit {
        print(#file , "Deinitilizer")
    }
    
    //MARK:- Variables
    var totalCount = 0
    var dataModel = ProfessionalListModel()
    
    func getprofessionalInfo() -> ProfessionalListModel?{
        return dataModel
    }
    
    //MARK:- API CAll
    
    func apiAllProfessionalList(limit : String , offset : String, Search: String , CatrgoryID : String, completion : @escaping(Bool , String)->()){
        let param = ["limit" : limit , "offset" : offset , "search" : Search , "category_id" : CatrgoryID] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.allProfessionals), method: .post, parameters: param, headers: true, body: nil)) { (result,message, response) in
            
            if response == 1{
                
                self.totalCount = (result as? [String : AnyObject])?["total_counts"] as? Int ?? 0
                
                guard let data = (result as? [String : AnyObject])?["result"] as? [[String : AnyObject]]else {
                    return
                }
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.dataModel += try JSONDecoder().decode(ProfessionalListModel.self, from: jsonSer)
                    completion(true , "")
                }catch{
                    completion(false , error.localizedDescription)
                }
                
            }else{
                
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false , msg)
            }
        }
    }
    
    func apiGetRecentlyProfessionalList(limit : String , offset : String , Search: String, completion : @escaping(Bool , String)->()){
        let param = ["limit" : limit , "offset" : offset , "search" : Search] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.recentlyProfessionals), method: .post, parameters: param, headers: true, body: nil)) { (result,message, response) in
            
            if response == 1{
                
                self.totalCount = (result as? [String : AnyObject])?["total_counts"] as? Int ?? 0
                
                guard let data = (result as? [String : AnyObject])?["result"] as? [[String : AnyObject]]else {
                    return
                }
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.dataModel += try JSONDecoder().decode(ProfessionalListModel.self, from: jsonSer)
                    completion(true , "")
                }catch{
                    completion(false , error.localizedDescription)
                }
                
            }else{
                
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false , msg)
            }
        }
    }
}
