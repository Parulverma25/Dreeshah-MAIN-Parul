//
//  ProductViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 01/04/21.
//

import Foundation
class ProductViewModel: BaseAPI{
    //MARK:- Initilizer and Denitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    //MARK:- Variable
    var model = ProductListModel()
    var totalcount = 0
    var isMoreData = false
    //MARK:- Getter
    func getProductListData() -> ProductListModel?{
        return model
    }
 

    
    //MARK:- API Function
    func apiProductList(limit : String ,offset : String ,completion : @escaping(Bool , String)->()){
        let param = ["limit": limit ,"offset": offset] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.productListing), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
        let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
          Indicator.shared.hideProgressView()
        if response==1{
            
            guard let data = ((result as? [String : AnyObject])?["products"] as? [[String : AnyObject]])
            else {
                return
            }
            self.totalcount = (result as? [String : AnyObject])?["total_counts"] as? Int ?? 0
            
            do{
                let jsonSer = try
                JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.model += try JSONDecoder().decode(ProductListModel.self, from: jsonSer)
                completion(true , msg )
            }catch{
                print(error)
                completion(false , error.localizedDescription)
            }
        }
       else
        {
            self.isMoreData=false
            completion(false, msg )
        }
    }
}
    
    
    func sortByProductList(limit : String , offset : String , sort : String , sortBy : String , completion : @escaping(Bool , String)->()){
        let param = ["limit" : limit , "offset" : offset , "sort" : sort , "sort_by" : sortBy] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.productListing), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
        let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
          Indicator.shared.hideProgressView()
        if response==1{
            
            guard let data = ((result as? [String : AnyObject])?["products"] as? [[String : AnyObject]])
            else {
                return
            }
            self.totalcount = (result as? [String : AnyObject])?["total_counts"] as? Int ?? 0
            
            do{
                let jsonSer = try
                JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.model += try JSONDecoder().decode(ProductListModel.self, from: jsonSer)
                completion(true , msg )
            }catch{
                print(error)
                completion(false , error.localizedDescription)
            }
        }
       else
        {
            self.isMoreData=false
            completion(false, msg )
        }
    }
}
          
    func hitAddtowishlist(Professional_id : String ,Product_id : String, completion : @escaping(Bool , String)->()){
        let param = ["professional_id" : Professional_id,"product_id" : Product_id ] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.addtowishlist), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
            if response == 1{
                
                completion(true,(msg))
            }else{
                
                completion(false , msg)
            }
        }
    }
    
    
    
    func apiProductListProfesstional(completion : @escaping(Bool , String)->()) {

        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.profrsstionalGetAllProducts), method: .get, headers: true ,body: nil)) {(result,message,response) in
            

            if response == 1 {
                guard let data = (result as? [String : AnyObject])?["products"] as? [[String:AnyObject]]
                else {
                    return completion(false,("No Data Found"))
                }
                
                self.totalcount = (result as? [String : AnyObject])?["total_counts"] as? Int ?? 0
                
                    do {
                    let jsonSer = try
                        JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.model = try
                        JSONDecoder().decode(ProductListModel.self, from: jsonSer)
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
    }
