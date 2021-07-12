//
//  CreatenewCollectionViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 17/06/21.
//
import Foundation
class CreatenewCollectionViewModel:BaseAPI{
    //MARK:- Initilizer and Denitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
//MARK:- API Function
    func hitAddCollection(name : String ,Product_id : String, completion : @escaping(Bool , String)->()){
        let param = ["collection_name" : name ,"product_id" : Product_id ] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.AddProducttoCollection), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
                completion(true,(msg))
            }else{
                
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["message"] as? String ?? ""
                completion(false , msg)
            }
        }
    }
}
