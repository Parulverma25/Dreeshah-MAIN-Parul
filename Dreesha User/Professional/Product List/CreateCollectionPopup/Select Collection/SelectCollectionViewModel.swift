//
//  SelectCollectionViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 17/06/21.
//

import Foundation
class SelectCollectionViewModel:BaseAPI{
    //MARK:- Initilizer and Denitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    
    //  MARK: Variables
   
    var CollIDModel : CollectionListing?
    //MARK: Getter
    
    func getCollIDs() -> CollectionListing? {
        return CollIDModel
    }
    
//MARK:- API Function
    func hitAddCollection(CollectionID : String ,Product_id : String, completion : @escaping(Bool , String)->()){
        let param = ["collection_id" : CollectionID ,"product_id" : Product_id ] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.AddProducttoCollection), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                let msg = (result as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(true,(msg))
            }else{
                
                let msg = (result as? [String : AnyObject])? ["msg"] as? String ?? ""
                completion(false , msg)
            }
        }
    }
    
    func hitCollectionIDs( completion : @escaping(Bool , String)->()){
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.CollectionsListing), method: .post, headers: true, body: nil)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                    do{
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.CollIDModel = try
                            JSONDecoder().decode(CollectionListing.self, from: jsonSer)
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
