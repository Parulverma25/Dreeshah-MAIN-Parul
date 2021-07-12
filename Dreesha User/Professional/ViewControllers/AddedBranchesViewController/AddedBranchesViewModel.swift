//
//  AddedBranchesViewModel.swift
//  Dreesha User
//
//  Created by promatics on 20/04/21.
//

import Foundation
class AddedBranchesViewModel: BaseAPI {
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    
    deinit {
        print(#file , "Deinitilizer")
    }
    
    //MARK:- Variables
    var model = BranchListModel()
    
    //MARK:- API CALL
    
    func apiGetBranchList(completion : @escaping(Bool,String)->()){
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getBranchList), method: .get, headers: true)) { (result, message, response) in
            
            let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
            if response == 1{
                guard let data = (result as? [String : AnyObject])?["result"] as? [[String : AnyObject]]else {
                    return
                }
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    
                    self.model = try JSONDecoder().decode(BranchListModel.self, from: jsonSer)
                    completion(true,msg)
                }catch{
                    completion(false,error.localizedDescription)
                }
            }else{
                completion(false,msg)
            }
        }
    }
}
