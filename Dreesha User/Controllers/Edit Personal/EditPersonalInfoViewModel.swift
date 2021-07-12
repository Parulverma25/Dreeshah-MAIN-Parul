//
//  EditPersonalInfoViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 02/04/21.
//

import Foundation
class EditPersonalInfoViewModel: BaseAPI{
    //MARK:- INitilizer and Deinitilizer
    override init() {
        super.init()
    }
    deinit {
        print("# Deinit")
    }
    //  MARK: Variables
    var model :  EditPersonalInfoModel?
    //MARK: Getter
    func getEditUserInfo() -> EditPersonalInfoModel? {
        return model
    }
    
    
//MARK: API Functions
func apiEditInfo(ID : String , first_name : String , last_name : String , email : String , contact : String , imageName : String ,imageData : Data , imageMime : String , completion : @escaping(Bool , String)->()){
    let param = ["id" : AppUser().user_id ,"first_name" : first_name , "last_name" : last_name , "email" : email , "phone_number" : contact] as baseParameters
    
    super.hitApiWithSingleFile(requests: RequestFileData(url: (URLS.baseUrl, APISuffix.updateUserProfile), method: .post, parameters: param, headers: true, fileData: imageData, fileName: imageName, fileMimetype: imageMime, fileParam: "profile_image")) { (result, message, response) in
        let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
        if response == 1{
            
            
            guard let data = result as? [String : AnyObject] else {
                return
            }
            UserDefaults.standard.setValue((NSKeyedArchiver.archivedData(withRootObject: data["profile_image"] as? [String : AnyObject] ?? [:])), forKey: "profile_image")
            print(print(UserDefaults.standard.value(forKey: "profile_image")))
            
            
            completion(true , msg)
        }else{
            completion(false , msg)
        }
    }
}
}
