//
//  ProductsDetailViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 08/04/21.
//

import Foundation
class ProductsDetailViewModel : BaseAPI {
    //MARK:- Initilizer and Denitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    //MARK:- Variable
    var model : ProductsDetailModel?

    //MARK:- Getter
    func getProductDetailsData() -> ProductsDetailModel?{
        return model
    }
    
    
    //MARK:- API Function
    func apiProductDetails(Product_id : String ,completion : @escaping(Bool , String)->()){
        let param = ["product_id": Product_id] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.ProductDetails), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
            Indicator.shared.hideProgressView()
            if response==1{
                guard let data = result as? [String : AnyObject]
                else {
                    return
                }
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.model = try JSONDecoder().decode(ProductsDetailModel.self, from: jsonSer)
                        completion(true,(message ?? ""))
                }catch{
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }
           else
            {
                completion(false,(message ?? ""))
            }
        }
    }
    
    func hitAddtoCart(User_id : String ,Professional_id : String ,Product_id : String ,Quantity_Id : Int , ColorName : String , color_code  : String , size_unit  : String ,size : Int, completion : @escaping(Bool , String)->()){
        let param = ["user_id" : User_id,"professional_id" : Professional_id,"product_id" : Product_id,"quantity" : Quantity_Id , "color_name" : ColorName , "color_code" : color_code,"size" : size,"size_unit" : size_unit    ] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.addtocart), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in
            print(param)
            if response == 1{
                let msg = (result as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(true,(msg))
            }else{
                
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false , msg)
            }
        }
    }
    
    func hitAddtoCartAgain(User_id : String , completion : @escaping(Bool , String)->()){
        let param = ["order_id" : User_id] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.addtocartAgain), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            print(param)
            if response == 1{
                let msg = (result as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(true,(msg))
            }else{
                
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false , msg)
            }
        }
    }
    
    
    
}
