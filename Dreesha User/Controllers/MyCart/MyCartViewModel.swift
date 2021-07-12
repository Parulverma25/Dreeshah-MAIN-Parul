//
//  MyCartViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 16/04/21.
//

import Foundation
class MyCartViewModel : BaseAPI {
//MARK:- Initilizer and Denitilizer
override init() {
    super.init()
}
deinit {
    print("#Deinitilizer")
}
//MARK:- Variable

    var model = MyCartModel()
    var AddressModel : DefaultaddressModel?
var Tax_Percentage = 0
var Shipping_Charge = 0
var isMoreData = false
var UserID = ""
//MARK:- Getter
func getMyCartListData() -> MyCartModel?{
    return model
}
    func getDefaultAddressDara() -> DefaultaddressModel?{
        return AddressModel
    }

//MARK:- API Function
    func apiCartList(completion : @escaping(Bool , String)->()){
        
    super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.cartListing), method: .post, headers: true ,body: nil)) {(result,message,response) in
    let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
      Indicator.shared.hideProgressView()
    if response==1{
        
        guard let data = ((result as? [String : AnyObject])?["data"] as? [[String : AnyObject]])
        else {
            return
        }
        self.UserID = ((result as? [String : AnyObject])?["userDetails"] as? [String : AnyObject])?["_id"] as? String ?? ""
        
        
        do{
            self.model = []              //MARK: NEW THING HERE <-------------------
            let jsonSer = try
            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            self.model += try JSONDecoder().decode(MyCartModel.self, from: jsonSer)
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

    func hitAddtowishlistCart(Professional_id : String ,Product_id : String, completion : @escaping(Bool , String)->()){
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
    
    func hitRemoveFromCart(Professional_id : String ,Product_id : String, Cart_id : String,Quantity : String, completion : @escaping(Bool , String)->()){
        let param = ["professional_id" : Professional_id,"product_id" : Product_id, "cart_id" : Cart_id, "quantity" : Quantity ] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.RemovefromCart), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in
            let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
            if response == 1{
                
                completion(true,(msg))
            }else{
                
                completion(false , msg)
            }
        }
    }
    
    func hitCheckOut(User_id : String ,Amount : Int ,OrderItems : [[String:Any]] , FirstName:String , LastName : String , AddressLine1 : String , AddressLine2 : String , City : String , State : String , ZipCode : String , PhoneNo : String , Landmark : String , address_type : String , country_ph_code : String , country : String ,completion : @escaping(Bool , String)->()){
        let param = ["user_id" : User_id , "amount" : Amount ,"order_items": OrderItems, "address": ["first_name" : FirstName ,"last_name" : LastName ,"address_line1" : AddressLine1 ,"address_line2" : AddressLine2 ,"city" : City ,"state" : State ,"zip_code" : ZipCode ,"phone_number" : PhoneNo ,"landmark" : Landmark ,"address_type" : address_type ,"country" : country ,"country_ph_code" :  country_ph_code ]] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.Checkout), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
            if response == 1{
                
                completion(true,(msg))
            }else{
                
                completion(false , msg)
            }
        }
    }
    
    
    func hitGetDefaultAddress(completion : @escaping(Bool , String)->()){
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getdefaultAddress), method: .post, headers: true, body: nil)) { (result, message, response) in
            let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
            
            if response==1{
                guard let data = result as? [String : AnyObject]
                
                else {
                    return
                }
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.AddressModel = try JSONDecoder().decode(DefaultaddressModel.self, from: jsonSer)
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
    
    
    
}
