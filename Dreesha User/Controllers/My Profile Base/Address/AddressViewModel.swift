//
//  AddressViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 06/04/21.
//

import Foundation
class AddressViewModel: BaseAPI {
    //MARK: Initlizer and Deinitlizer
    override init(){
        super.init()
    }
    deinit {
        print("Deinitlizer")
    }
    
   //MARK:- Variables
    var model : AddressListingModel?
    var isMoreData = false
    
    //MARK:  Getter
    func getAddressListData() -> AddressListingModel? {
        return model
    }
    
    //MARK:- API Function
    func apiAddressList(completion : @escaping(Bool , String)->()){
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.AddressListing), method: .get, headers: true)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            
            if response == 1{
                guard  let data = (result as? [String : AnyObject])?["data"] as? [String : AnyObject] else {
                    return
                }
                do{
                    let jsonSer = try
                        JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.model=try
                        JSONDecoder().decode(AddressListingModel.self, from: jsonSer)
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
    
    
    func hitDeleteAddress(addressId : String , completion : @escaping(Bool , String)->()){
        let param = ["address_id" : addressId] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.deleteAddress), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
                completion(true,(msg))
            }else{
                
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false , msg)
            }
        }
    }
    
    func hitDefaultAddress(addressId : String , DefaultAddress : String , completion : @escaping(Bool , String)->()){
        let param = ["address_id" : addressId ,"is_default" : DefaultAddress] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.defaultAddress), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
                completion(true,(msg))
            }else{
                
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false , msg)
            }
        }
    }
    
    
}
