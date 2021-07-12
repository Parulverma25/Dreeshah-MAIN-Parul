//
//  TermsViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 10/04/21.
//
import Foundation
class TermsViewModel: BaseAPI {
    //MARK:- Initilizer and Deinitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    //MARK:- Variable
    var terms_ConModel : TermsandConditionModel?

    //MARK:- Getter
    func getTermsValData() -> TermsandConditionModel? {
        return terms_ConModel
    }

    
    func apiTerms_Conditions(Status : String , completion : @escaping(Bool , String)->()){

        let param = ["status" : Status] as baseParameters

        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.termsandConditions), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in
            let msg = (result as? [String:AnyObject])? ["msg"] as? String ?? ""
            Indicator.shared.hideProgressView()
            if response == 1{
              
                guard let data = (result as? [String : AnyObject])else {
                    return
                }
                    do{
                        let jsonSer = try   JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        self.terms_ConModel = try JSONDecoder().decode(TermsandConditionModel.self, from: jsonSer)
                        completion(true, msg )
                    }catch{
                        print(error)
                        completion(false , error.localizedDescription)
                    }
            }else{
                completion(false , msg )
            }
        }
    }
}
