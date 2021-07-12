//
//  HomeViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 09/04/21.
//

import Foundation
class HomeViewModel:BaseAPI{
    //MARK:- Initilizer and Denitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    //MARK:- Variable
    var model : ProductListModel?
    var Servicemodel = GetAllServicesModel()
    var totalcount = 0
    var isMoreData = false
    //MARK:- Getter
    func getProductListData() -> ProductListModel?{
        return model
    }
    func getServiceListData() -> GetAllServicesModel?{
        return Servicemodel
    }
    
    
    //MARK:- API Function
    func apiProductList(limit : String ,offset : String ,completion : @escaping(Bool , String)->()){
        let param = ["limit": limit ,"offset": offset] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.productListing), method: .post, parameters: param, headers: false ,body: nil)) {(result,message,response) in
            if response==1{
                guard let data = result as? [String : AnyObject]
                else {
                    return
                }
                self.totalcount = (result as? [String : AnyObject])?["total_counts"] as? Int ?? 0
                do{
                    let jsonSer = try  JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.model = try JSONDecoder().decode(ProductListModel.self, from: jsonSer)
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
            }
           else
            {
                self.isMoreData=false
                completion(false,(message ?? ""))
            }
        }
    }
          
    func hitAddtowishlist(User_id : String ,Professional_id : String ,Product_id : String, completion : @escaping(Bool , String)->()){
        let param = ["user_id" : User_id,"professional_id" : Professional_id,"product_id" : Product_id ] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.addtowishlist), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in
            if response == 1{
                let msg = (result as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(true,(msg))
            }else{
                
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false , msg)
            }
        }
    }
    
    //MARK:- API Function
    func apiServiceList(limit : String ,offset : String ,completion : @escaping(Bool , String)->()){
        let param = ["limit": limit ,"offset": offset] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.serviceListing), method: .post, parameters: param, headers: false ,body: nil)) {(result,message,response) in
            if response == 1 {
                guard let data = (result as? [String : AnyObject])?["result"] as? [[String : AnyObject]]
                else {
                    return
                }
                self.totalcount = (result as? [String : AnyObject])?["total_counts"] as? Int ?? 0
                do{
                    
                    let jsonSer = try  JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    
                    let newData = try JSONDecoder().decode(GetAllServicesModel.self, from: jsonSer)
                    
                    if newData.count > 0{
                        self.Servicemodel += newData
                        self.isMoreData=true
                    }else{
                        self.isMoreData=false
                    }
                    completion(true,(message ?? ""))
                }catch{
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }
           else
            {
                self.isMoreData=false
                completion(false,(message ?? ""))
            }
        }
    }
    
    
}
