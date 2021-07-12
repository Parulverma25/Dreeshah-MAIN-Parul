//
//  BranchTypeAndCategoryViewModel.swift
//  Dreesha User
//
//  Created by Apple on 07/04/21.
//

import Foundation


class BranchTypeAndCategoryViewModel: BaseAPI {
    
    override init() {
        super.init()
    }
    
    deinit {
        print("#Deinitilizer")
    }
    
    
    var typeModelData: BranchTypeModel?
    var categoryModel: BranchCategoryModel?
    
    
    
    
    func hitBranchType(completion : @escaping(Bool , String)->() ) {
        
        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.branchTypes), method: .get, headers: false)) {(result,message,response) in
            Indicator.shared.hideProgressView()
            print(result as Any)
            print(message as Any)
            print(response)
            if response == 1 {
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                do {
                    let jsonSer = try
                        JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.typeModelData = try
                        JSONDecoder().decode(BranchTypeModel.self, from: jsonSer)
                    completion(true,(message ?? ""))
                } catch {
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }
           else {
                completion(false,(message ?? ""))
            }
        }
    }
    
    
    func hitBranchCategory(typeId:String, completion : @escaping(Bool , String)->()){
        let param = ["brand_type_id": typeId] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.branchCategories), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1 {
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                    do{
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.categoryModel = try
                            JSONDecoder().decode(BranchCategoryModel.self, from: jsonSer)
                        completion(true,(message ?? ""))
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
