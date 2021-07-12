//
//  ProductListViewModel.swift
//  Dreesha User
//
//  Created by promatics on 4/22/21.
//

import Foundation

class ProductListViewModel: BaseAPI {
    
    override init() {
        super.init()
    }
    
    deinit {
        print("#Deinitilizer")
    }
    
    var modelSort : ProductListModel?
    var isMoreData = false
    var model: GetAllProducts?
    var model2 : ServiceListAR?
    var totalcount = 0
   // var categoryModel: BranchCategoryModel?
    func getProductListData() -> GetAllProducts?{
        return model
    }
    
    func hitApiProductList(valLimit : Int,valOffset : Int, completion : @escaping(Bool , String)->()){
        let param = ["limit_val": valLimit,"offset_val" : valOffset] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getAllProducts), method: .post, parameters: param, headers: true, body: nil)) { [self] (result, message, response) in
            Indicator.shared.hideProgressView()
            print(param)
            if response == 1 {
                guard let data = result as? [String : AnyObject] else {
                    return
                }
                
                    do{
                       
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.model = try
                            JSONDecoder().decode(GetAllProducts.self, from: jsonSer)
                        completion(true,(message ?? ""))
                        print("CHECKTHISOUT+++++++++>>>>>\((model!.data)! as Any)")
                    }catch{
                        print(error)
                        completion(false , error.localizedDescription)
                    }
            }else{
                completion(false , "")
            }
        }
    }
    func hitApiServiceList(valLimit : Int,valOffset : Int, completion : @escaping(Bool , String)->()){
        let param = ["limit": valLimit,"offset" : valOffset] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getServiceList), method: .post, parameters: param, headers: true, body: nil)) { [self] (result, message, response) in
            Indicator.shared.hideProgressView()
            print(param)
            if response == 1 {
                print("SERvice Result:  \(result)")
                guard let data = result as? [String : AnyObject] else {
                    return
                }
                
                    do{
                       
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.model2 = try
                            JSONDecoder().decode(ServiceListAR.self, from: jsonSer)
                        completion(true,(message ?? ""))
                        print("CHECKTHISOUT+++++++++>>>>>\((model2!.data)! as Any)")
                    }catch{
                        print(error)
                        completion(false , error.localizedDescription)
                    }
            }else{
                completion(false , "")
            }
        }
    }
    
    func sortByProductListProf(limit : String , offset : String , sort : String , sortBy : String , completion : @escaping(Bool , String)->()){
        let param = ["limit" : limit , "offset" : offset , "sort" : sort , "sort_by" : sortBy] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.sortByProducts), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                guard let data = result as? [String : AnyObject]
                else {
                    return
                }
                self.totalcount = (result as? [String : AnyObject])?["total_counts"] as? Int ?? 0
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.modelSort = try  JSONDecoder().decode(ProductListModel.self, from: jsonSer)
//                    if newData.count > 0{
//                        self.model += newData
//                        self.isMoreData=true
//                    }else{
//                        self.isMoreData=false
//                    }
                    completion(true,(message ?? ""))
                }catch{
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }else{
                self.isMoreData=false
                completion(false,(message ?? ""))
            }
        }
    }
    
    
    
}
