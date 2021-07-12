//
//  AddAlbumViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 12/04/21.
//
import Foundation
class AddAlbumViewModel : BaseAPI{
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    //  MARK: Variables
    var model :  AddAlbumModel?
    var SubModel : ServiceSubCategoriesModel?
    //MARK: Getter
    func getAddAlbum() -> AddAlbumModel? {
        return model
    }
    func getSubDta() -> ServiceSubCategoriesModel? {
        return SubModel
    }
    
    //MARK:- APi Functions
    func hitaddAlbum( subCat : String , imageParam : [String],AlbumName : String , imageName : [String] ,imageData : [Data] , imageMime : [String] , completion : @escaping(Bool , String)->()){
        let param = ["sub_category_id": subCat , "album_name": AlbumName] as baseParameters
        
        print(param)
        
        super.hitApiWithMultipleFile(requests: RequestMultipleFileData(url: (URLS.baseUrl, APISuffix.AddAlbumsListing), method: .post, parameters: param, headers: true, fileData: imageData, fileName: imageName, fileMimetype: imageMime, fileParam: imageParam)) { (result, message, response) in
      
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
   
    func hitserviceSubCategories( completion : @escaping(Bool , String)->()){
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
    }
