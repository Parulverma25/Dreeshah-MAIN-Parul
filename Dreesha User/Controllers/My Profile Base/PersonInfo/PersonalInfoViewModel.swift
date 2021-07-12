////
////  PersonalInfoViewModel.swift
////  Dreesha User
////
////  Created by Promatics on 02/04/21.
////

import Foundation
class PersonalInfoViewModel: BaseAPI {
    override init() {
        super.init()
    }

    deinit {
        print("#Deinitilizer")
    }

    //MARK:- Variable
    var model : GetUserDetailsModel?
    
    var dataModel : ProfessionalUserDetailModel?
    
    //MARK:- Getter
    func getUserDetails() -> GetUserDetailsModel?{
        return model
    }
    
    //MARK:- API Function
    func apiUserDetails(user_id : String , completion : @escaping(Bool ,  String)->()){
        let param = ["id" : user_id] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getUserDetail), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            
            Indicator.shared.hideProgressView()
            
            if response == 1{
                guard  let data = (result as? [String : AnyObject])?["data"] as? [String:AnyObject] else {
                    return
                }
                do{
                    
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.model  = try JSONDecoder().decode(GetUserDetailsModel.self, from: jsonSer)
                    completion(true , "")
                }catch{
                    completion(false , error.localizedDescription)
                }
            }else{
                completion(false ,  message ?? "")
            }
        }
    }
    
    
    func apiUserDetailsProfessional(user_id : String , completion : @escaping(Bool ,  String)->()) {
        
        let param = ["user_id" : user_id] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getUserDetail), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            
            Indicator.shared.hideProgressView()
            
            if response == 1 {
                guard  let data = result as? [String : AnyObject] else {
                    return
                }
                do {
                    
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.dataModel  = try JSONDecoder().decode(ProfessionalUserDetailModel.self, from: jsonSer)
                    print(self.dataModel as Any)
                    completion(true , "")
                }catch{
                    completion(false , error.localizedDescription)
                }
            } else {
                completion(false ,  message ?? "")
            }
        }
    }
    
    
    func editProfesstionalProfile(FirstName : String ,

                                   LastName : String ,

                                   UserType : String ,

                                   Email : String ,

                                   Password : String,

                                   branchNameEn : String,

                                   branchNameAr : String,

                                   branchTypeId : String,

                                   branchCategoryId : String,

                                   branchBrief : String,

                                   certificateAward : [[String : String]],

                                   noOfBranches : String,

                                   profileImage : String,

                                   

                                   country : String,
                                   country_ph_code : String,
                                   phoneNumber : String,
                                   addFirstName : String,
                                   addLastName : String ,
                                   addLine1 : String,
                                   addLine2 : String,
                                   pincode : String,
                                   landmark : String,
                                   state : String,
                                   city : String,
                                   
                                   
                                   co_ordinator_eng : String,

                                   co_ordinator_arabic : String,

                                   branchEmail : String,

                                   branchWebsite : String,

                                   countryCode : String,

                                   businessCountryCode : String,

                                   mobileNumber : String,

                                   businessMobileNumber : String,

                                   instaAccount : String,

                                   youtubeAccount : String,

                                   

                                   branchYear : Int,

                                   issued_in_countries : [String],

                                   issued_in_cities : [String],

                                   branchLicence : String,

                                   licenceNumber : String,

                                   no_of_emp : String,

                                   

                                   serviceCategories : [String],
                                   serviceSubCate : [String],
                                   newCategories : [[String : String]],
                                   serviceCountry : [String],
                                   serviceCity : [String],
                                   serviceCost : String,

                                   

                                   completion : @escaping(Bool,String)->()) {

            

            

            let param = ["first_name" : FirstName ,

                         "last_name" : LastName ,

                         "user_type" : UserType ,

                         "email" : Email ,

                         "password" : Password ,

                         "branch_name_en" : branchNameEn ,

                         "branch_name_ar" : branchNameAr ,

                         "branch_type_id" : branchTypeId ,

                         "branch_category_id" : branchCategoryId ,

                         "branch_brief" : branchBrief ,

                         "certificate_awards" : certificateAward ,

                         "no_of_branches" : noOfBranches ,

                         "profile_image" : profileImage,

                         

                         "country" : country,
                         "state" : state,
                         "phone_number" : phoneNumber,
                         "country_ph_code":country_ph_code,
                         "address_line_1" : addLine1,
                         "address_line_2" : addLine2,
                         "addr_first_name" : addFirstName,
                         "addr_last_name" : addLastName,
                         "city" : city,
                         "pincode" : pincode,
                         "landmark" : landmark,

                         

                         "contact_details" : ["co_ordinator_eng" : co_ordinator_eng ,

                                              "co_ordinator_arabic" : co_ordinator_arabic ,

                                              "branch_email" : branchEmail ,

                                              "branch_website" : branchWebsite ,

                                              "country_code" : countryCode,

                                              "business_country_code" : businessCountryCode,

                                              "mobile_number" : mobileNumber ,

                                              "business_mobile_number" : businessMobileNumber ,

                                              "insta_acc" : instaAccount ,

                                              "youtube_channel" : youtubeAccount] ,

                         

                         "business_details" : ["branch_year" : branchYear ,

                                               "issued_in_countries" : issued_in_countries ,

                                               "issued_in_cities" : issued_in_cities ,

                                               "branch_licence" : branchLicence ,

                                               "licence_number" : licenceNumber ,

                                               "no_of_emp" : no_of_emp] ,

                         

                         "service_categories" : serviceCategories,

                         "service_subcategories" : serviceSubCate,

                         "new_categories" : newCategories,
                         
                         
                         "service_details" : [
                                              "service_country" : serviceCountry ,
                                              "service_city" : serviceCity ,
                                              "service_cost" : serviceCost]] as baseParameters

            

            super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.editProfesstionalProfile), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in

                Indicator.shared.hideProgressView()

                if response == 1{

                    completion(true,"")

                }else{

                    completion(false,"")

                }

            }

        }
}
