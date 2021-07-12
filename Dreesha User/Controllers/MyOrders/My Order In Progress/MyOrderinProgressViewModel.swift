//
//  MyOrdersCancellViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 08/04/21.
//

import Foundation
class MyOrdersinProgressViewModel: BaseAPI  {
    //MARK: Initlizer and Deinitlizer
override init(){
    super.init()
}
deinit {
    print("Deinitlizer")
}

//MARK:- Variables
var model = InProgressOrderListModel()
var isMoreData = false
var count = 0
//MARK:  Getter
func getinProgressOrderListData() -> InProgressOrderListModel? {
    return model
}

//MARK:- API Function
    func apiinProgressOrderList(Status : String ,Limit : String ,Offset : String ,completion : @escaping(Bool , String)->()){
    let param = ["status" : Status ,"limit" : Limit ,"offset" : Offset  ] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.InProgressOrder),method: .post, parameters : param, headers: true)) { (result, message, response) in
            
            let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
            
            Indicator.shared.hideProgressView()
            if response==1{
                
                guard let data = ((result as? [String : AnyObject])?["data"] as? [[String : AnyObject]])
                else {
                    return
                }
                self.count = (result as? [String : AnyObject])?["total_counts"] as? Int ?? 0
                do{
                    let jsonSer = try
                    JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.model += try JSONDecoder().decode(InProgressOrderListModel.self, from: jsonSer)
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
    
    func hitCancellOrder(OrderId : String , Cancel_reason : String , completion : @escaping(Bool , String)->()){
        let param = ["order_id" : OrderId ,"cancel_reason" : Cancel_reason ] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.CancelOrderItem), method: .post, parameters: param, headers: false, body: nil)) { (result, message, response) in
            if response == 1{
                let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
                completion(true,(msg))
            }else{
                
                let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
                completion(false , msg)
            }
        }
    }
    
}
