//
//  StaffListViewModel.swift
//  Dreesha User
//
//  Created by promatics on 28/04/21.
//

import Foundation
class StaffListViewModel: BaseAPI {
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    
    deinit {
        print(#file,"Deinitilizer")
    }
    
    //MARK:- Variables
    var model = StaffListModel()
    var previledgeModel = PreviledegeListModel()
    
    //MARK:- Getter Func
    func getStaffDetails() -> StaffListModel?{
        return model
    }
    
    func getPreviledgeList() -> PreviledegeListModel?{
        return previledgeModel
    }
    
    //MARK:- API CALL
    
    func apiPrevilegeList(completion : @escaping(Bool , String)->()){
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getPrevilaegeList), method: .get, headers: true)) { (result, message, response) in
            if response == 1{
                
                guard let data = (result as? [String : AnyObject])?["result"] as? [[String : AnyObject]] else {
                    return
                }
                do{
                    
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    
                    self.previledgeModel = try JSONDecoder().decode(PreviledegeListModel.self, from: jsonSer)
                    completion(true , "")
                    
                }catch{
                    completion(false , error.localizedDescription)
                }
            }else{
                completion(false,"")
            }
        }
    }
    
    func apiGetStaffList(limit : String , offset : String , completion : @escaping(Bool , String)->()){
        let param = ["limit_val" : limit , "offset_val" : offset] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getStaffList), method: .post, parameters: param, headers: true, body: nil)) { (result , message , response) in
           // print("RESULT: \(result!)  RESPONSE:\(response)")
            if response == 1{
                
                guard let data = (result as? [String : AnyObject])?["result"] as? [[String : AnyObject]] else {
                    return
                }
                
                do{
                    
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    
                    self.model += try JSONDecoder().decode(StaffListModel.self, from: jsonSer)
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
    
    
    func apiAddPreledge(staffId : String , privilege : [[String : Any]] , completion : @escaping(Bool , String)->()){
        
        let param = ["staff_id" : staffId , "privilege" : privilege] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.addPreviledge), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                completion(true , "")
            }else{
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                
                completion(false , msg)
            }
        }
    }
    
    
}

