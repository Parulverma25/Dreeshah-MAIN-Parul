//
//  DiscountsViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 16/06/21.
//

import Foundation
class DiscountsViewModel : BaseAPI {
//MARK:- Initilizer and Denitilizer
override init() {
    super.init()
}
deinit {
    print("#Deinitilizer")
}
//MARK:- Variable
    var model = DiscountsListing()
var totalcount = 0
var isMoreData = false
//MARK:- Getter
func getQuotationListData() -> DiscountsListing?{
    return model
}


//MARK:- API Function
    func apiDiscountsList(Status : String ,completion : @escaping(Bool , String)->()){
        let param = ["status" : Status] as baseParameters

        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.DiscountListings), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
        let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
          Indicator.shared.hideProgressView()
        if response==1{
            
            guard let data = ((result as? [String : AnyObject])?["discount_list"] as? [[String : AnyObject]])
            else {
                return
            }
            do{
                let jsonSer = try
                JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.model += try JSONDecoder().decode(DiscountsListing.self, from: jsonSer)
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
