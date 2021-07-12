//
//  SignupViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 24/03/21.
////

import Foundation
class SignupViewModel: BaseAPI {
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    //MARK:- Variable
    var isMoreData = false
    var countryModel : GetCountryModel?
    var cityModel: GetCityModel?
    var imageData: GetImageData?
    
    var serviceModel = ServiceCategoryListModel()
    var subCateModel = SubCategoryModel()
    var projectBySubCat = ProjectBySubCategoryModel()
    //MARK:- APi Functions
    func hitUserSignup(FirstName : String , LastName : String ,UserType : String ,Country : String , State : String ,city : String,Email : String ,Password : String, Phoneno : String, completion : @escaping(Bool,String)->()){
        let param = ["first_name" : FirstName , "last_name":LastName , "user_type":UserType , "country":Country , "state":State , "city" : city ,"email":Email , "password":Password , "phone_number":Phoneno , ] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.userSignUp), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in
            if response == 1{
                guard let data = result as? [String : AnyObject] else {
                    return
                }
                UserDefaults.standard.set(data["token"] as? String ?? "", forKey: "token")
                print(UserDefaults.standard.value(forKey: "token") ?? "")
                completion(true,("Signup Successfully!"))
            }else{
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false,(msg))
            }
        }
    }
    func hitUserCountry(completion : @escaping(Bool , String)->()){
        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.hitCountry), method: .get, headers: false)) {(result,message,response) in
            Indicator.shared.hideProgressView()
            if response==1{
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                do{
                    let jsonSer = try
                        JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.countryModel = try
                        JSONDecoder().decode(GetCountryModel.self, from: jsonSer)
                    completion(true,(message ?? ""))
                }catch{
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }
           else
            {
                self.isMoreData=false
                completion(false,(message ?? ""))
            }
        }
    }
    
    
    func hitProfessionalSignup(FirstName : String ,
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
    
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.professtionalSignUp), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in
            if response == 1{
                completion(true,"")
            }else{
                completion(false,"")
            }
        }
    }
    
    func apiAddBranch(FirstName : String ,
                      LastName : String ,
                      UserType : String ,
                      Email : String ,
                      Password : String,
                      branchNameEn : String,
                      branchNameAr : String,
                      branchTypeId : String,
                      branchCategoryId : String,
                      branchBrief : String,
                      branchProfile : String,
                      certificateAward : [[String : String]],
                      
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
                     "branch_profile" : branchProfile,
                     "certificate_awards" : certificateAward ,
                     
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
        
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.addBranch), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                completion(true,"")
            }else{
                completion(false,"")
            }
        }
    }
    
    func editProfesstionalProfile(pincode: String, completion : @escaping (Bool,String) -> ()) {
        let param = ["pincode": pincode] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.editProfesstionalProfile), method: .post, parameters: param,headers: false)) { (res, mess, resp) in
            print(resp)
        }
    }
    
    
    func apiUploadProfileImage(imageData : Data , imageName : String , imageMime : String , completion : @escaping(Bool , String , Any)->()){
        super.hitApiWithSingleFile(requests: RequestFileData(url: (URLS.baseUrl, APISuffix.uploadProfile), method: .post, headers: true, fileData: imageData, fileName: imageName, fileMimetype: imageMime, fileParam: "image")) { (result, message, response) in
            Indicator.shared.hideProgressView()
            print(result as Any)
            if response == 1{
                completion(true,"",result as Any)
            }else{
                completion(false,"",result as Any)
            }
        }
    }
    
    func apiUploadLogoImage(imageData : Data , imageName : String , imageMime : String , completion : @escaping(Bool , String , Any)->()){
        super.hitApiWithSingleFile(requests: RequestFileData(url: (URLS.baseUrl, APISuffix.uploadProfile), method: .post, headers: true, fileData: imageData, fileName: imageName, fileMimetype: imageMime, fileParam: "image")) { (result, message, response) in
            Indicator.shared.hideProgressView()
            print(result as Any)
            if response == 1{
                completion(true,"",result as Any)
            }else{
                completion(false,"",result as Any)
            }
        }
    }
    
    
    func hitUploadImageService(imageData : Data , imageName : String , imageMime : String , completion : @escaping(Bool , String)->()) {
        
        let param = ["destination" : "ProfessionalServices"] as baseParameters
        
        super.hitApiWithSingleFile(requests: RequestFileData(url: (URLS.baseUrl, APISuffix.uploadImage), method: .post, parameters: param, headers: false, fileData: imageData, fileName: imageName, fileMimetype: imageMime, fileParam: "image")) { (result, message, response) in
            Indicator.shared.hideProgressView()
            print("Image redev k\(result as Any)")
            if response == 1 {
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                do {
                    let jsonSer = try
                        JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.imageData = try
                        JSONDecoder().decode(GetImageData.self, from: jsonSer)
                    completion(true,(message ?? ""))
                } catch {
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }
           else {
                self.isMoreData = false
                completion(false,(message ?? ""))
            }
        }
    }
    
    func hitUploadImageAddProduct(imageData : Data , imageName : String , imageMime : String , completion : @escaping(Bool , String)->()) {
        let param = ["destination" : "SellerProductImages"] as baseParameters
        super.hitApiWithSingleFile(requests: RequestFileData(url: (URLS.baseUrl, APISuffix.uploadImage), method: .post, parameters: param, headers: false, fileData: imageData, fileName: imageName, fileMimetype: imageMime, fileParam: "image")) { (result, message, response) in
            Indicator.shared.hideProgressView()
            print("Image redev k\(result as Any)")
            if response == 1 {
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                do {
                    let jsonSer = try
                        JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.imageData = try
                        JSONDecoder().decode(GetImageData.self, from: jsonSer)
                    completion(true,(message ?? ""))
                } catch {
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }
           else {
                self.isMoreData = false
                completion(false,(message ?? ""))
            }
        }
    }
    
    func hitUploadImageAddProductArray(imageData : [Data] , imageName : [String] , imageMime : [String] ,imageParam:[String], completion : @escaping(Bool , String)->()) {
        let param = ["destination" : "SellerProductImages"] as baseParameters
        super.hitApiWithMultipleFile(requests: RequestMultipleFileData(url: (URLS.baseUrl , APISuffix.uploadImage), method: .post,parameters: param, headers: false, fileData: imageData, fileName: imageName, fileMimetype: imageMime, fileParam: imageParam)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1 {
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                do {
                    let jsonSer = try
                        JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.imageData = try
                        JSONDecoder().decode(GetImageData.self, from: jsonSer)
                    completion(true,(message ?? ""))
                } catch {
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }
           else {
                self.isMoreData = false
                completion(false,(message ?? ""))
            }
        }
    }
    
    
    
    
    func hitUploadImage(imageData : Data , imageName : String , imageMime : String , completion : @escaping(Bool , String)->()) {
        
        let param = ["destination" : "professionalData"] as baseParameters
        
        super.hitApiWithSingleFile(requests: RequestFileData(url: (URLS.baseUrl, APISuffix.uploadImage), method: .post, parameters: param, headers: false, fileData: imageData, fileName: imageName, fileMimetype: imageMime, fileParam: "image")) { (result, message, response) in
            Indicator.shared.hideProgressView()
            print("Image redev k\(result as Any)")
            if response == 1 {
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                do {
                    let jsonSer = try
                        JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.imageData = try
                        JSONDecoder().decode(GetImageData.self, from: jsonSer)
                    completion(true,(message ?? ""))
                } catch {
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }
           else {
                self.isMoreData = false
                completion(false,(message ?? ""))
            }
        }
    }
    
    func hitUserSingleCity(CountryCode:String, completion : @escaping(Bool , String)->()){
        let param = ["countryCode": CountryCode] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.hitCity), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                    do{
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.cityModel = try
                            JSONDecoder().decode(GetCityModel.self, from: jsonSer)
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
    
    func hitUserCity(CountryCode:[String], completion : @escaping(Bool , String)->()){
        let param = ["country_code": CountryCode] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getAllCities), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                    do{
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.cityModel = try
                            JSONDecoder().decode(GetCityModel.self, from: jsonSer)
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

    func hitServiceList(search : String,completion : @escaping(Bool , String)->()){
        
        let param = ["search" : search] as baseParameters
        
        
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.searchInServiceCategory), method: .post, parameters: param, headers: false, body: nil)) {(result,message,response) in
            Indicator.shared.hideProgressView()
            print(result as Any)
            print(message as Any)
            print(response)
            if response == 1 {
                guard let data = (result as? [String : AnyObject])?["list"] as? [[String : AnyObject]]else {
                    return
                }
                do {
                    let jsonSer = try
                        JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.serviceModel = try
                        JSONDecoder().decode(ServiceCategoryListModel.self, from: jsonSer)
                    completion(true,(message ?? ""))
                } catch {
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }
           else {
                self.isMoreData=false
                completion(false,(message ?? ""))
            }
        }
    }
    
    func apiGetSubCategory(categoryId : String , completion : @escaping(Bool , String)->()){
        let param = ["category_id" : categoryId] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getSubCateById), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard let data = (result as? [String : AnyObject])?["sub_categories"] as? [[String : AnyObject]] else {
                    return
                }
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.subCateModel += try JSONDecoder().decode(SubCategoryModel.self, from: jsonSer)
                    completion(true , "")
                }catch{
                    completion(false , "")
                }
            }else{
                completion(false , "")
            }
        }
    }
    
    func apiGetProjectsBySubCategory(subCategoryId : [String] , completion : @escaping(Bool , String)->()){
        let param = ["sub_category_id" : subCategoryId] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.getProjBySubId), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard let data = (result as? [String : AnyObject])?["result"] as? [[String : AnyObject]] else {
                    return
                }
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.projectBySubCat += try JSONDecoder().decode(ProjectBySubCategoryModel.self, from: jsonSer)
                    completion(true , "")
                }catch{
                    completion(false , "")
                }
            }else{
                completion(false , "")
            }
        }
    }
    
    func apiCheckExist(email : String , contact : String , completion : @escaping(Bool , String)->()){

        let param = ["email" : email , "phone_number" : contact] as baseParameters

        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.checkexist), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in

            if response == 1{

                completion(true , "")
            }else{
                let msg = (( result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false , msg)
            }
        }
    }
    
  
    
    
    
}
