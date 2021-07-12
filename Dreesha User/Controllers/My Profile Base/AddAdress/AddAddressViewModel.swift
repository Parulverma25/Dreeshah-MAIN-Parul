//
//  AddAddressViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 05/04/21.
//

import Foundation
class AddAddressViewModel : BaseAPI{
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    
    deinit {
        print("#Deinitilizer")
    }

    
    //MARK:- APi Functions
    func hitaddAddress(FirstName : String , LastName : String ,AddressLine1 : String ,AddressLine2 : String ,City : String , State : String , ZipCode : String ,PhoneNum : String,landmark : String , addresstype : String , Country : String ,countryCode : String ,completion : @escaping(Bool,String)->()){
        let param = ["first_name" : FirstName , "last_name":LastName , "address_line1":AddressLine1 , "address_line2":AddressLine2 ,"city": City, "state":State , "zip_code": ZipCode , "phone_number" : PhoneNum ,"landmark" : landmark,"address_type" : addresstype, "country":Country  , "country_ph_code" : countryCode] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.addAddress), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
                completion(true,(msg))
            }else{
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? "Could not connect to server"
                completion(false,(msg))
            }
        }
    }
    
    
    func hiteditAddress(FirstName : String , LastName : String ,AddressLine1 : String ,AddressLine2 : String ,City : String , State : String , ZipCode : String ,PhoneNum : String,landmark : String , addresstype : String , Country : String ,countryCode : String ,completion : @escaping(Bool,String)->()){
        let param = ["first_name" : FirstName , "last_name":LastName , "address_line1":AddressLine1 , "address_line2":AddressLine2 ,"city": City, "state":State , "zip_code": ZipCode , "phone_number" : PhoneNum ,"landmark" : landmark,"address_type" : addresstype, "country":Country  , "country_ph_code" : countryCode] as baseParameters
        
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.editAddress), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            
          

            if response == 1{
                let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
                completion(true,(msg))
            }else{
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? "Could not connect to server"
                completion(false,(msg))
            }
        }
    }
    

    
}
