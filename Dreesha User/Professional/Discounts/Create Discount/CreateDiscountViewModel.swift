//
//  CreateDiscountViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 15/06/21.
//

import Foundation
class CreateDiscountViewModel : BaseAPI{
//MARK:- Initilizer and Deinitilizer
override init() {
    super.init()
}
deinit {
    print("#Deinitilizer")
}
//  MARK: Variables

    var ProfessionalModel : ProductsProfessionalListing?
var isMoreData = false
    
    //MARK: Getter
    
    func getProfDta() -> ProductsProfessionalListing? {
        return ProfessionalModel
    }

    
    func hitDiscount(discount_coupon : String , discount_value : Int ,discount_type : String ,TO : String ,ProductID : String ,CollectionID : String , Requirement : String ,Value : String,date_time : String, usage_type : String,usage_value : String, X : String, Y : String,expiry_date : String, completion : @escaping(Bool,String)->()){
        let param = ["discount_coupon" : discount_coupon , "discount_value":discount_value , "discount_type":discount_type , "discount_apply": ["to" : TO , "product_id" : ProductID , "collection_id" : CollectionID ], "minimum_requirement":[ "requirement" : Requirement , "value" : Value],"date_time":date_time , "usage":["usage_type" : usage_type , "usage_value" : usage_value] , "buy_x_get_y":["x" : X , "y" : Y] , "expiry_date" : expiry_date] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.createDiscount), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            print(param)
            if response == 1{
                let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
                completion(true,(msg))
            }else{
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? "Could not connect to server"
                completion(false,(msg))
            }
        }
    }
    
func hitProfessionalsWithoutPagination( completion : @escaping(Bool , String)->()){
    super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.ProductsWithoutPagiantion), method: .post, headers: true, body: nil)) { (result, message, response) in
        Indicator.shared.hideProgressView()
        if response == 1{
            guard let data = (result as? [String : AnyObject])else {
                return
            }
                do{
                    let jsonSer = try
                        JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.ProfessionalModel = try
                        JSONDecoder().decode(ProductsProfessionalListing.self, from: jsonSer)
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
