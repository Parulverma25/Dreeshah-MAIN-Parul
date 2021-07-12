////
////  QuotationViewModel.swift
////  Dreesha User
////
////  Created by Promatics on 09/04/21.
////

import Foundation
class QuotationViewModel : BaseAPI {
//MARK:- Initilizer and Denitilizer
override init() {
    super.init()
}
deinit {
    print("#Deinitilizer")
}
//MARK:- Variable
    var model = QuotationsListingModel()
var totalcount = 0
var isMoreData = false
//MARK:- Getter
func getQuotationListData() -> QuotationsListingModel?{
    return model
}


//MARK:- API Function
    func apiQuotationListfunc(limit : String ,offset : String , Status : String , Search: String , Filter : String ,completion : @escaping(Bool , String)->()){
        let param = ["limit": limit ,"offset": offset , "status" : Status , "search" : Search , "filter" : Filter ] as baseParameters

        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.QuotationsRequestsListing), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
        let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
          Indicator.shared.hideProgressView()
        if response==1{
            
            guard let data = ((result as? [String : AnyObject])?["result"] as? [[String : AnyObject]])
            else {
                return
            }
            do{
                self.model = []              //MARK: NEW THING HERE <-------------------
                let jsonSer = try
                JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.model += try JSONDecoder().decode(QuotationsListingModel.self, from: jsonSer)
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
