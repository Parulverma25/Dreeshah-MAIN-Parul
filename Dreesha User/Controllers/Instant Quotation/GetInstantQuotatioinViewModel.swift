//
//  GetInstantQuotatioinViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 03/05/21.

import Foundation
class GetInstantQuotatioinViewModel : BaseAPI{
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    
    deinit {
        print("#Deinitilizer")
    }

    
    //MARK:- APi Functions
    func hitaddQuotation(professional_service_id : String ,Name : String ,Email : String ,Phno : String ,QuotaionRef : String ,Date : String ,Time : String ,SalesRep : String ,ServiceName : String ,Location : String ,Quantity : String ,ExpectedDate : String ,EstimatedBudget : String ,Description : String ,country_code : String ,quotation_no : String ,subject : String ,professionalId : String ,completion : @escaping(Bool,String)->()){
        let param = ["professional_service_id" : professional_service_id , "name":Name , "email":Email , "phone_number":Phno ,"quotation_ref": QuotaionRef, "date":Date , "time": Time , "sales_representative" : SalesRep, "service_name" : ServiceName , "location" : Location , "quantity" : Quantity , "expected_date" : ExpectedDate , "estimated_budget" : EstimatedBudget , "description" : Description , "country_code" : country_code , "quotation_no" : quotation_no , "subject" : subject , "professional_id" : professionalId] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.addquotation), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
                completion(true,(msg))
            }else{
                let msg = (result as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false,(msg))
            }
        }
    }
}
