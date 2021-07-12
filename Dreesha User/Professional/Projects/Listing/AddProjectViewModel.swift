//
//  AddProjectViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 19/04/21.
//

import Foundation
class AddProjectViewModel: BaseAPI {
    //MARK: Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    
    deinit {
        print(#file , "Deinitilizer")
    }
    
    //MARK: Variable
    var styleDataModel = ProfessionaStyleModel()
    var CategoryDataModel = ProfessionalCategoryModel()
    var BranchDataModel = ProfessionalBranchModel()
    var model = ProjectListingModel()
    var subCateModel = SubCategoryModel()
    var ProfPaginationModel = ProfWPaginationModel()
    //MARK: Getter
    
    func getProjList() -> ProjectListingModel{
        return model
    }
    
    func getProfStyle() -> ProfessionaStyleModel{
        return styleDataModel
    }
    func getProfCategory() -> ProfessionalCategoryModel{
        return CategoryDataModel
    }
    func getProfSubCategory() -> SubCategoryModel{
        return subCateModel
    }
    func getProfPagination() -> ProfWPaginationModel{
        return ProfPaginationModel
    }
    
    func getProfBranch() -> ProfessionalBranchModel{
        return BranchDataModel
    }
    //MARK:- API Functions
    
    func apigetProjects(completion : @escaping(Bool,String)->()){
     //   let param = [] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, .getProject), method: .post, parameters: nil, headers: true, body: nil)){ (result, message, response) in
            if(response == 1){
                
                guard let data = (result as? [String : AnyObject])?["data"] as? [[String : AnyObject]] else {
                    return
                }
                
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    
                    self.model = try JSONDecoder().decode(ProjectListingModel.self, from: jsonSer)
                    
                    completion(true,"")
                    
                }catch{
                    completion(false, "")
                }
                
               
            }else{
                completion(false, "")
            }
            
        }
    }
    
    func apigetStyles(completion : @escaping(Bool,String)->()){
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, .getProfStyes), method: .get, parameters: nil, headers: false, body: nil)){ (result, message, response) in
            if response == 1{
                guard  let data = (result as? [String : AnyObject])?["data"] as? [[String:AnyObject]] else {
                    return
                }
                do{
                    
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.styleDataModel = try JSONDecoder().decode(ProfessionaStyleModel.self, from: jsonSer)
//                   // for i in 0...data.count-1 {
//                    let jsonData = data as? [String:AnyObject]
//                    let jsonSer = try JSONSerialization.data(withJSONObject: jsonData!, options: .prettyPrinted)
//                        self.styleDataModel.append( try JSONDecoder().decode(ProfessionaStyleModel.self, from: jsonSer))
                    completion(true , "")
                   // }
                }catch{
                    completion(false , error.localizedDescription)
                }
            }else{
                completion(false ,  message ?? "")
            }
        }
    }
    
    func apigetCategory(completion : @escaping(Bool,String)->()){
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, .getProfCategory), method: .get, parameters: nil, headers: false, body: nil)){ (result, message, response) in
            if response == 1{
                guard  let data = (result as? [String : AnyObject])?["data"] as? [[String:AnyObject]] else {
                    return
                }
                do{
                    
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.CategoryDataModel = try JSONDecoder().decode(ProfessionalCategoryModel.self, from: jsonSer)

                    completion(true , "")
                   // }
                }catch{
                    completion(false , error.localizedDescription)
                }
            }else{
                completion(false ,  message ?? "")
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
    
    
    func apigetBranches(completion : @escaping(Bool,String)->()){
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, .getProfBranch), method: .get, parameters: nil, headers: true, body: nil)){ (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard  let data = (result as? [String : AnyObject])?["result"] as? [[String:AnyObject]] else {
                    return
                }
                do{
                    
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.BranchDataModel += try JSONDecoder().decode(ProfessionalBranchModel.self, from: jsonSer)

                    completion(true , "")
                   // }
                }catch{
                    completion(false , error.localizedDescription)
                }
            }else{
                completion(false ,  message ?? "")
            }
        }
    }
    
    
    func apigetProfessionals(completion : @escaping(Bool,String)->()){
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, .getProfWithoutPagiantion), method: .get, parameters: nil, headers: false, body: nil)){ (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard  let data = (result as? [String : AnyObject])?["result"] as? [[String:AnyObject]] else {
                    return
                }
                do{
                    
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.ProfPaginationModel += try JSONDecoder().decode(ProfWPaginationModel.self, from: jsonSer)

                    completion(true , "")
                   // }
                }catch{
                    completion(false , error.localizedDescription)
                }
            }else{
                completion(false ,  message ?? "")
            }
        }
    }
    
    
    

    func apiAddProject(project_name: String, project_address: String,ProDescription : String, project_category: [String], project_style: String, project_year: Int,project_cost: Int, project_website: String, project_keyword: [String],project_images: [Data], project_images_Name: [String], project_images_Type: [String], project_images_Param: [String], project_publish_product: Bool, project_publish_professional: Bool, project_publish_services: Bool, notify_professional_ids: [String], projectCountries : [String] , projectCities : [String] , projectCate : [String] , projectSubCate : [String] ,completion : @escaping(Bool,String)->()){
        
        let param = ["project_name": project_name,"project_description" : ProDescription, "project_address": project_address, "project_category": project_category, "project_style": project_style, "project_year": project_year, "project_cost": project_cost, "project_website": project_website, "project_keyword": project_keyword, "project_publish_product": project_publish_product, "project_publish_professional": project_publish_professional, "project_publish_services": project_publish_services,"notify_professional_ids": notify_professional_ids , "project_country" : projectCountries , "project_city" : projectCities  , "project_sub_category" : projectSubCate] as baseParameters
        print(param)
        super.hitApiWithMultipleFile(requests: RequestMultipleFileData(url: (URLS.baseUrl, .addProfproject), method: .post, parameters: param, headers: true, fileData: project_images, fileName: project_images_Name, fileMimetype: project_images_Type, fileParam: project_images_Param)){ (result, message, response) in
            print("Resp::: \(response)  Mess::: \(message)  Result:::\(result)")
            if response == 1{
                /*guard  let data = (result as? [String : AnyObject])?["data"] as? [[String:AnyObject]] else {
                    return
                }
                do{
                    
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.CategoryDataModel = try JSONDecoder().decode(ProfessionalCategoryModel.self, from: jsonSer)

                    completion(true , "")
                   // }
                }catch{
                    completion(false , error.localizedDescription)
                }*/
                completion(true, "Added Successfully")
            }else{
                completion(false ,  message ?? "")
            }
        }
    }
    
    
    
    /*func apiAddService(service_name: String, service_description: String, area_covered: [String], country: [String], service_category: [String],service_sub_category: [String], service_project: String, price: String,duration: String, service_visible_customer: String, service_visible_professional: String, images: [Data], images_Name: [String], images_Type: [String], images_Param: [String], completion : @escaping(Bool,String)->()){
        
        let param = ["service_name": service_name, "service_description": service_description, "area_covered": area_covered, "country": country, "service_category": service_category, "service_sub_category": service_sub_category, "service_project": service_project, "price": price, "duration": duration, "service_visible_customer": service_visible_customer, "service_visible_professional": service_visible_professional] as baseParameters
        print(param)
        super.hitApiWithMultipleFile(requests: RequestMultipleFileData(url: (URLS.baseUrl, .addProfService), method: .post, parameters: param, headers: true, fileData: images, fileName: images_Name, fileMimetype: images_Type, fileParam: images_Param)){ (result, message, response) in
            print("Resp::: \(response)  Mess::: \(message)  Result:::\(result)")
            if response == 1{
                
                completion(true, "Added Successfully")
            }else{
                completion(false ,  message ?? "")
            }
        }
    }*/
    
    func apiAddService(service_name: String, service_description: String, area_covered: [String], country: [String], service_category: [String],service_sub_category: [String], service_project: String, price: String,duration: String, service_visible_customer: String, service_visible_professional: String, service_image: String, related_images: String, other_images: String,tags : String,serviceBranches : String, completion : @escaping(Bool,String)->()){
        
        let param = ["service_name": service_name, "service_description": service_description, "area_covered": area_covered, "country": country, "service_category": service_category, "service_sub_category": service_sub_category, "service_project": service_project, "price": price, "duration": duration, "service_visible_customer": service_visible_customer, "service_visible_professional": service_visible_professional, "service_image": service_image, "related_images": related_images, "other_images": other_images, "tags" : tags , "service_branches" : serviceBranches] as baseParameters
        print(param)
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, .addProfService), method: .post, parameters: param, headers: true, body: nil)){ (result, message, response) in
            if(response == 1){
                
                completion(true,"Added Successfully")
               
            }else{
                completion(false, "")
            }
            
        }
    }
}
