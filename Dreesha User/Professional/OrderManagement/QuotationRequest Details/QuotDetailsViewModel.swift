//
//  QuotDetailsViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 05/05/21.
//

import Foundation

class QuotDetailsViewModel : BaseAPI {
//MARK:- Initilizer and Denitilizer
override init() {
    super.init()
}
deinit {
    print("#Deinitilizer")
}
//MARK:- Variable
    var model : QuotationDetailsModel?
var totalcount = 0
var isMoreData = false
//MARK:- Getter
func getQuotationDetailData() -> QuotationDetailsModel??{
    return model
}


//MARK:- API Function
    func apiQuotationDetailfunc(quotationID : String ,completion : @escaping(Bool , String)->()){
        let param = ["quotation_id" : quotationID] as baseParameters

        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.QuotationDetails), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
        let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
          Indicator.shared.hideProgressView()
        if response==1{
            
            guard let data = (result as? [String : AnyObject])
            else {
                return
            }
            do{
                let jsonSer = try
                JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.model = try JSONDecoder().decode(QuotationDetailsModel?.self, from: jsonSer)
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
