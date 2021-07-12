//
//  IssueQuotationModel.swift
//  Dreesha User
//
//  Created by Promatics on 21/05/21.
//

import Foundation
class IssueQuotationModel: BaseAPI {
    //MARK: Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    
    deinit {
        print(#file , "Deinitilizer")
    }

    func apiAddIssueQuotation(customer_id: String, customer_quotation_id: String, title: String, warrenty: String, offer_validity: String, price: String, quantity: String, vat: String, workflow: String,scope_of_work: String, exclusion: String, payment_terms: String, work_schedule: String, tcForDreeshah: String, tcForSeller: String, imageData: Data, imageType: String, imageName: String, imageParam: String,paymenttype: String, total_price : String,payment_installments : String,completion : @escaping(Bool,String)->()){
        
        let param = ["customer_id": customer_id, "customer_quotation_id": customer_quotation_id, "title": title, "warrenty": warrenty, "offer_validity": offer_validity, "price": price, "quantity": quantity, "vat": vat, "workflow": workflow, "scope_of_work": scope_of_work, "exclusion": exclusion, "payment_terms": payment_terms, "work_schedule": work_schedule, "dreeshah_terms": tcForDreeshah, "seller_terms": tcForSeller , "payment_type" : paymenttype ,"total_price" : total_price , "payment_installments" : payment_installments] as baseParameters
        print(param)
        if(imageName == ""){
        super.hitApi(requests: Request(url: (URLS.baseUrl, .addIssueQuotation), method: .post, parameters: param, headers: true, body: nil)){ (result, message, response) in
            if(response == 1){
                
                completion(true,"Added Successfully")
               
            }else{
                completion(false, "")
            }
            
        }
        }else{
            super.hitApiWithSingleFile(requests: RequestFileData(url: (URLS.baseUrl, .addIssueQuotation) ,method: .post, parameters: param, headers: true, fileData: imageData, fileName: imageName, fileMimetype: imageType, fileParam: imageParam)) { (result, message, response) in
                
                if response == 1{
                    completion(true , "Added Successfully")
                }else{
                    completion(false , "")
                }
            }

        }
    }
    
    
    //MARK: API EDIT Quotation
    func apiEditIssueQuotation(customer_id: String,quotation_id:String,customer_quotation_id: String, title: String, warrenty: String, offer_validity: String, price: String, quantity: String, vat: String, workflow: String,scope_of_work: String, exclusion: String, payment_terms: String, work_schedule: String, tcForDreeshah: String, tcForSeller: String, imageData: Data, imageType: String, imageName: String, imageParam: String,paymenttype: String, total_price : String,payment_installments : String,completion : @escaping(Bool,String)->()){
        let param = ["customer_id": customer_id,"quotation_id":quotation_id, "customer_quotation_id": customer_quotation_id, "title": title, "warrenty": warrenty, "offer_validity": offer_validity, "price": price, "quantity": quantity, "vat": vat, "workflow": workflow, "scope_of_work": scope_of_work, "exclusion": exclusion, "payment_terms": payment_terms, "work_schedule": work_schedule, "dreeshah_terms": tcForDreeshah, "seller_terms": tcForSeller , "payment_type" : paymenttype ,"total_price" : total_price , "payment_installments" : payment_installments] as baseParameters
        print(param)
        if(imageName == ""){
        super.hitApi(requests: Request(url: (URLS.baseUrl, .ModifyIssueQuotation), method: .post, parameters: param, headers: true, body: nil)){ (result, message, response) in
            if(response == 1){
                
                completion(true,"Modified Successfully")
               
            }else{
                completion(false, "")
            }
            
        }
        }else{
            super.hitApiWithSingleFile(requests: RequestFileData(url: (URLS.baseUrl, .addIssueQuotation) ,method: .post, parameters: param, headers: true, fileData: imageData, fileName: imageName, fileMimetype: imageType, fileParam: imageParam)) { (result, message, response) in
                
                if response == 1{
                    completion(true , "Modified Successfully")
                }else{
                    completion(false , "")
                }
            }

        }
    }
}
