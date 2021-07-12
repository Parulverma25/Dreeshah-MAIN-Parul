////
////  QuotationViewModel.swift
////  Dreesha User
////
////  Created by Promatics on 09/04/21.
////

import Foundation
class QuotationProfessionalViewModel : BaseAPI {
//MARK:- Initilizer and Denitilizer
override init() {
    super.init()
}
deinit {
    print("#Deinitilizer")
}
//MARK:- Variable
    var model = ProffQuoutationListingModel()
var totalcount = 0
var isMoreData = false
//MARK:- Getter
func getQuotationListData() -> ProffQuoutationListingModel?{
    return model
}


//MARK:- API Function
    func apiQuotationListfunc(limit : String ,offset : String , Status : String ,searchKey : String , filter : String,completion : @escaping(Bool , String)->()){
        let param = ["limit": limit ,"offset": offset , "status" : Status , "search" : searchKey , "filter" : filter] as baseParameters

        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.profesionalquotationsRequestsListing), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
        let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
          Indicator.shared.hideProgressView()
        if response==1{
            
            guard let data = ((result as? [String : AnyObject])?["result"] as? [[String : AnyObject]])
            else {
                return
            }
            do{
                let jsonSer = try
                JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.model += try JSONDecoder().decode(ProffQuoutationListingModel.self, from: jsonSer)
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
    
    func acceptRejectQuotationRqst(quotation_Id : String , status : String , rejectReason : String , completion : @escaping(Bool , String)->()){
        
        let param = ["status" : status , "quotation_id" : quotation_Id , "reject_reason" : rejectReason] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.quotationRqstAction), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                completion(true , "")
            }else{
                completion(false , "")
            }
        }
    }
}
