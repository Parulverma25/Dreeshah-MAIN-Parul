//
//  CollectionProductsViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 18/06/21.
//
import Foundation
class CollectionProductsViewModel: BaseAPI{
    //MARK:- Initilizer and Denitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    //MARK:- Variable
    var model = ClctnProductModel()
    var totalcount = 0
    var isMoreData = false
    //MARK:- Getter
    func getCollectionData() -> ClctnProductModel?{
        return model
    }
 

    
    //MARK:- API Function
    func apiCollectionList(limit : String ,offset : String ,collection_id : String,completion : @escaping(Bool , String)->()){
        let param = ["limit": limit ,"offset": offset , "collection_id" : collection_id] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.CollectionProducts), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
        let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
          Indicator.shared.hideProgressView()
        if response==1{
            
            guard let data = ((result as? [String : AnyObject])?["data"] as? [[String : AnyObject]])
            else {
                return
            }
            self.totalcount = (result as? [String : AnyObject])?["count"] as? Int ?? 0
            
            do{
                let jsonSer = try
                JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.model += try JSONDecoder().decode(ClctnProductModel.self, from: jsonSer)
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
    
    func hitRemoveProduct(_id : String , completion : @escaping(Bool , String)->()){
        let param = ["_id" : _id] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.removeProductfromCollection), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
            if response == 1{
                
                completion(true,(msg))
            }else{
                
                completion(false , msg)
            }
        }
    }
    
    
    
    
}
