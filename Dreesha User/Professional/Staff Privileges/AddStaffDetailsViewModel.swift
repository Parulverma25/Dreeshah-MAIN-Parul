//
//  AddStaffDetailsViewModel.swift
//  Dreesha User
//
//  Created by promatics on 29/04/21.
//

import Foundation
class AddStaffDetailsViewModel: BaseAPI {
    //MARK:- Initilizer and Deinitilizer
    
    override init() {
        super.init()
    }
    
    deinit {
        print(#file , "Deinitilizer")
    }
    
    //MARK:- Variables
    
    var designationModel = DesignationListModel()
    
    //MARK:- API Functions
 
    func apiGetDesignationList(completion : @escaping(Bool , String)->()){
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getDesignationList), method: .get, headers: false)) { (result, message, response) in
            if response == 1{
                guard let data = (result as? [String : AnyObject])?["designations"] as? [[String : AnyObject]]else {
                    return
                }
                
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let jsonDecoded = try JSONDecoder().decode(DesignationListModel.self, from: jsonSer)
                    self.designationModel = jsonDecoded
                    completion(true , "")
                }catch{
                    completion(false,error.localizedDescription)
                }
            }else{
                completion(false , "")
            }
        }
    }
    
    
    func apiAddStaff(BranchId : String , Name : String , Email : String , CountryCode : String , PhoneNumber : String ,designation : String,completion : @escaping(Bool , String)->()){
        
        let param = ["branch_id" : BranchId , "full_name" : Name , "email" : Email , "country_code" : CountryCode , "phone_number" : PhoneNumber , "designation" : designation] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.addStaff), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                completion(true , "")
            }else{
                completion(false , "")
            }
        }
    }
    
    func apiEditStaff(BranchId : String , Name : String , Email : String , CountryCode : String , PhoneNumber : String , StaffId : String ,designation : String ,completion : @escaping(Bool , String)->()){
        
        let param = ["branch_id" : BranchId , "full_name" : Name , "email" : Email , "country_code" : CountryCode , "phone_number" : PhoneNumber , "staff_id": StaffId ,"designation" : designation] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.editStaff), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                completion(true , "")
            }else{
                completion(false , "")
            }
        }
    }
}
