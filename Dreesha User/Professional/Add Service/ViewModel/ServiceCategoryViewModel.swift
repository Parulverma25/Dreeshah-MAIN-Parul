//
//  ServiceCategoryViewModel.swift
//  Dreesha User
//
//  Created by promatics on 4/29/21.
//

import Foundation

class ServiceCategoryViewModel:BaseAPI
{
    override init() {
        
    }
    deinit {
        print("Deinit")
    }
    
    var model = PopUpServiceCategory()
    
    
    func hitGetServiceCategory(completion : @escaping(Bool , String)->())
    {
        hitApi(requests: Request.init(url: (URLS.baseUrl, APISuffix.getServiceCategory), method: .get, headers: false)) { (result, message, response) in
            Indicator.shared.hideProgressView()
           
            if response == 1 {
                guard let data = result as? [String : AnyObject] else {
                    return
                }
                
                    do{
                       
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                       
                        self.model = try JSONDecoder().decode(PopUpServiceCategory.self, from: jsonSer)
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
