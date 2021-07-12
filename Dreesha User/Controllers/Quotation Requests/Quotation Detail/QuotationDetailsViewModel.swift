////
////  QuotationViewModel.swift
////  Dreesha User
////
////  Created by Promatics on 09/04/21.
////

import Foundation
class QuotationDetailsViewModel : BaseAPI {
//MARK:- Initilizer and Denitilizer
override init() {
    super.init()
}
deinit {
    print("#Deinitilizer")
}
//MARK:- Variable
    var model : QuotationDetailsModel?
    var issueModel: IssuedQuotationDetailModel?
var totalcount = 0
var isMoreData = false
//MARK:- Getter
func getQuotationDetailData() -> QuotationDetailsModel??{
    return model
}
    
    func getissueQuotationModel() -> IssuedQuotationDetailModel??{
        return issueModel
    }


//MARK:- API Function
    func apiQuotationDetailfunc(quotationID : String ,completion : @escaping(Bool , String)->()){
        let param = ["quotation_id" : quotationID , "user_type" : AppUser.shared.user_type] as baseParameters

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
    
    //MARK: VIEW Quotation Details
    func apiIssueQuotationDetailfunc(quotationID : String ,completion : @escaping(Bool , String)->()){
        let param = ["quotation_id" : quotationID , "user_type" : AppUser.shared.user_type] as baseParameters

        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.IssueQuotationDetails), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
        let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
          Indicator.shared.hideProgressView()
        if response==1{
            
            guard let data = (result as? [String : AnyObject])?["data"] as? [String:AnyObject]
            else {
                return
            }
            do{
                let jsonSer = try
                JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.issueModel = try JSONDecoder().decode(IssuedQuotationDetailModel?.self, from: jsonSer)
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
