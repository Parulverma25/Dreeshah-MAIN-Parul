//
//  MyOrdersCancellViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 08/04/21.
//

import Foundation
class MyOrdersDelieveredViewModel: BaseAPI  {
    //MARK: Initlizer and Deinitlizer
override init(){
    super.init()
}
deinit {
    print("Deinitlizer")
}

//MARK:- Variables
var model : DelieveredOrderListModel?
var isMoreData = false

//MARK:  Getter
func getDelieveredOrderListData() -> DelieveredOrderListModel? {
    return model
}

//MARK:- API Function
func apiCancellOrderList(completion : @escaping(Bool , String)->()){
    
    super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.cancelOrderList), method: .get, headers: true)) { (result, message, response) in
        Indicator.shared.hideProgressView()
        
        if response == 1{
            guard  let data = (result as? [String : AnyObject])?["result"] as? [String : AnyObject] else {
                return
            }
            do{
                let jsonSer = try
                    JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.model=try
                    JSONDecoder().decode(DelieveredOrderListModel.self, from: jsonSer)
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
}
