//
//  AddServiceARViewModel.swift
//  Dreesha User
//
//  Created by promatics on 4/28/21.
//

import Foundation

class AddServiceARViewModel : BaseAPI
{
    var styleModel = GetStyles()
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    //MARK:- Api
    
//  func  hitAddServiceApi(
//    serviceName : String,
//    serviceDescription : String,
//    city : [String:String],
//    country : String,
//    servicecategory : String,
//    servicesubcategory : String,
//    serviceproject : [String],
//    projectID : [String : String],
//    price : Double,
//    duration : String,
//    servicevisiblecustomer : Bool,
//    servicevisibleprofessional: Bool,
//    serviceimage : String,
//    relatedimages : [String],
//    otherimages : [String],
//    
//    completion : @escaping(Bool,String)->())
//  {
//    
//    var param = [
//        "service_name" = serviceName,
//        "service_description" = serviceDescription,
//        "area_covered" = [
//            city
//        ],
//        "country" = country,
//        "service_category" = servicecategory,
//        "service_sub_category" = servicesubcategory,
//        "service_project" = [
//            projectID
//        
//        ],
//        "price" = price,
//        "duration" = duration,
//        "service_visible_customer" = servicevisiblecustomer,
//        "service_visible_professional" = servicevisibleprofessional,
//        "service_image" = serviceimage,
//        "related_images" = relatedimages,
//        "other_images" = otherimages
//
//        
//    ] as baseParameters   
//    hitApi(requests: Request.init(url: (URLS.baseUrl, APISuffix.getUserProfileDetails), method: .post , parameters: param, headers: true, body: nil)) { (result, message, response) in
//        if response == 1{
//            completion(true,"")
//        }else{
//            completion(false,"")
//        }
//    }
//  }
    
    
//MARK:- ADD Project Api
    
    
//
//    Params:
//    project_name
//    project_address
//    project_category
//    project_style
//    project_year(number)
//    project_cost(number)
//    project_website
//    project_keyword(array)
//    project_images(array)
//    project_publish_product(true/false)
//    project_publish_professional(true/false)
//    project_publish_services(true/false)
//    notify_branch_ids(array)
    
    
    func  hitAddProjectApi(
        projectName : String,
        projectAddress : String,
        Projectcategory : String,
        projectStyle : String,
        projectYear : Int,
        projectCost : Int,
        projectWebsite : String,
        
        projectKeywords : [String],
        projectImages : [String],
        projectProfessional : Bool,
        projectProduct : Bool,
        projectServices : Bool,
        notifyBranchId: [String],
    
    
        completion : @escaping(Bool,String)->())
      {
    
        
      var  param = [
        "project_name" : projectName,
        "project_address" : projectAddress,
        "project_category" : Projectcategory,
        "project_style" : projectStyle,
        "project_year" : projectYear,
        "project_cost" : projectCost,
        "project_website" : projectWebsite,
        "project_keyword" : projectKeywords,
       
        "project_images" : projectImages,
        "project_publish_product" : projectProduct,
        "project_publish_professional" : projectProfessional,
        "project_publish_services" : projectServices,
        "notify_branch_ids" : notifyBranchId
        
            
    
    
        ] as baseParameters
        hitApi(requests: Request.init(url: (URLS.baseUrl, APISuffix.addProfproject), method: .post , parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                completion(true,"")
            }else{
                completion(false,"")
            }
        }
      }
    //MARK:- add Styles
    
    func hitStylesApi(completion : @escaping(Bool , String)->())
    {
        hitApi(requests: Request.init(url: (URLS.baseUrl, APISuffix.getStyles), method: .get, headers: false)) { (result, message, response) in
            if response == 1 {
            guard let data = result as? [String : AnyObject] else {
                return
            }
            
                do{
                   
                    let jsonSer = try
                        JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                   
                    self.styleModel = try JSONDecoder().decode(GetStyles.self, from: jsonSer)
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

  //  https://developers.promaticstechnologies.com:3001/getStyleListing
}
