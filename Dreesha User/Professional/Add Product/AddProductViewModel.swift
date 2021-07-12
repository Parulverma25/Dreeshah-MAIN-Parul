//
//  AddProductViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 25/05/21.
//

import Foundation
class AddProductViewModel : BaseAPI{
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    //  MARK: Variables
   
    var SubModel : ServiceSubCategoriesModel?
    var CatModel : ProductCategoriesModel?
    var TypeModel : ProductTypeModel?
    var vendorModel : VendorModel?
    var inventModel : InventoryModel?
    var LocationModel : ProductLocationModel?
    var CollectModel : CollectionModel?
    //MARK: Getter
    
    func getSubDta() -> ServiceSubCategoriesModel? {
        return SubModel
    }
    func getCatData() -> ProductCategoriesModel? {
        return CatModel
    }
    func getTypeData() -> ProductTypeModel? {
        return TypeModel
    }
    func getVendorData() -> VendorModel? {
        return vendorModel
    }
    func getinventortData() -> InventoryModel? {
        return inventModel
    }
    func getlocation() -> ProductLocationModel? {
        return LocationModel
    }
    func getcollection() -> CollectionModel? {
        return CollectModel
    }
    

//MARK:- APi Functions

    func hitaddProductArrayImg(category_id: String, sub_category_id: String,product_title: String,product_description: String,product_media: String,shipping: String,variant: String,product_type:String,visible_to_professinal: String,visible_to_customer: String, charge_tax: String, collection: String,vendor: String,tags: String, price:Int ,comprice:Int ,costperitem:Int ,margin:Int ,profit:Int ,inventory:String,sku:String,barcode:String,weight:String,region:String,code:String,unit:String,quantity:String,available_color:String,available_size:String, imageParam : [String], imageName : [String] ,imageData : [Data] , imageMime : [String] ,   completion : @escaping(Bool,String)->()){
    
        let param = ["category_id": category_id, "sub_category_id": sub_category_id, "product_title": product_title, "product_description": product_description, "product_media": product_media, "shipping": shipping, "variant": variant, "visible_to_professinal": visible_to_professinal, "visible_to_customer": visible_to_customer, "charge_tax": charge_tax, "tags": tags , "pricing" : ["price": price, "comprice":comprice,"costPerItem":costperitem,"margin":margin,"profit":  profit] , "inventory" : ["inventory":inventory,"sku":sku,"barcode":barcode] ,"quantity" : quantity , "weight_details":["weight":weight,"unit":unit] , "customs_information":["region":region,"code":code], "available_color": available_color , "available_size":available_size , "product_details":["product_type":product_type ,"vendor":vendor,"collection":collection ] ] as baseParameters
        print(param)
        
        super.hitApiWithMultipleFile(requests: RequestMultipleFileData(url: (URLS.baseUrl, APISuffix.add_product), method: .post, parameters: param, headers: true, fileData: imageData, fileName: imageName, fileMimetype: imageMime, fileParam: imageParam)) { (result, message, response) in
            
                  Indicator.shared.hideProgressView()
                  if response == 1{
                      let msg = (result as? [String : AnyObject])? ["message"] as? String ?? ""
                      completion(true , msg)
                  }else{
                      let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                      completion(false , msg)
                  }
              }
          }
    
    func apigetLocation(completion : @escaping(Bool,String)->()){
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, .getProfBranch), method: .get, parameters: nil, headers: true, body: nil)){ (result, message, response) in
            if response == 1{
                guard  let data = (result as? [String : AnyObject])else {
                    return
                }
                do{
                    
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.LocationModel = try JSONDecoder().decode(ProductLocationModel.self, from: jsonSer)

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
    
    
    
    
    func hitProductSubCategories( completion : @escaping(Bool , String)->()){
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.serviceSubCategories), method: .get, headers: false, body: nil)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                    do{
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.SubModel = try
                            JSONDecoder().decode(ServiceSubCategoriesModel.self, from: jsonSer)
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
    
    func hitProductCategories( completion : @escaping(Bool , String)->()){
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.ProductCategories), method: .get, headers: false, body: nil)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                    do{
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.CatModel = try
                            JSONDecoder().decode(ProductCategoriesModel.self, from: jsonSer)
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
    
    func hitInventory( completion : @escaping(Bool , String)->()){
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.inventory), method: .get, headers: false, body: nil)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                    do{
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.inventModel = try
                            JSONDecoder().decode(InventoryModel.self, from: jsonSer)
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
    
    
    
    func hitProducttype( completion : @escaping(Bool , String)->()){
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.producttype), method: .get, headers: false, body: nil)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                    do{
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.TypeModel = try
                            JSONDecoder().decode(ProductTypeModel.self, from: jsonSer)
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
    
    func hitCollection( completion : @escaping(Bool , String)->()){
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.collection), method: .get, headers: true, body: nil)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                    do{
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.CollectModel = try
                            JSONDecoder().decode(CollectionModel.self, from: jsonSer)
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
    
    
    func hitVendor( ProductTypeID: String, completion : @escaping(Bool , String)->()){
        let param = ["product_type_id" : ProductTypeID ] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.add_vendor), method: .post,parameters: param, headers: false, body: nil)) { (result, message, response) in
            Indicator.shared.hideProgressView()
            if response == 1{
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                    do{
                        let jsonSer = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.vendorModel = try
                            JSONDecoder().decode(VendorModel.self, from: jsonSer)
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
}
