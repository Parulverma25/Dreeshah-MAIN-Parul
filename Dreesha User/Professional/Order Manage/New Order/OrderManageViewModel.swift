//
//  OrderManageViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 05/06/21.
//

import Foundation

class OrderManageViewModel : BaseAPI {
//MARK:- Initilizer and Denitilizer
override init() {
    super.init()
}
deinit {
    print("#Deinitilizer")
}
//MARK:- Variable
    var model = OrderManagementProfModel()
var totalcount = 0
var isMoreData = false
//MARK:- Getter
func getOrderManageData() -> OrderManagementProfModel?{
    return model
}


//MARK:- API Function
    func apiOrderList(Status : String ,Limit : String ,Offset : String ,completion : @escaping(Bool , String)->()){
        let param = ["status" : Status ,"limit" : Limit ,"offset" : Offset  ] as baseParameters

        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.orderManageList), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
        let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
          Indicator.shared.hideProgressView()
        if response==1{
            
            guard let data = (result as? [String : AnyObject])? ["data"] as? [[String:AnyObject]]
            else {
                return
            }
            do{
                let jsonSer = try
                JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.model += try JSONDecoder().decode(OrderManagementProfModel.self, from: jsonSer)
                completion(true , msg )
            }catch{
                print(error)
                completion(false , error.localizedDescription)
            }
        }
       else
        {
            self.isMoreData=false
            completion(false, msg )
        }
    }
}
}
