//
//  ProductDetailARViewModel.swift
//  Dreesha User
//
//  Created by promatics on 4/23/21.
//

import Foundation
class ProductDetailARViewModel : BaseAPI {
    
    override init() {
        super.init()
    }
    
    deinit {
        print("#Deinitilizer")
    }
    
    
    var model: NewProductDetails?
   // var categoryModel: BranchCategoryModel?
    
    func hitApiProductDetails(productID : String, completion : @escaping(Bool , String)->()){
        let param = ["product_id": productID] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getProductDetails), method: .post, parameters: param, headers: true, body: nil)) { [self] (result, message, response) in
            Indicator.shared.hideProgressView()
            print(param)
            if response == 1 {
                guard let data = result as? [String : AnyObject] else {
                    return
                }
                
                    do{
                       
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.model = try
                            JSONDecoder().decode(NewProductDetails.self, from: jsonSer)
                        completion(true,(message ?? ""))
                        print("CHECKTHISOUT+++++++++>>>>>\((model!.details)! as Any)")
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
