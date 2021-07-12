//
//  OrderTrackingViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 08/04/21.
//

import Foundation
class OrderDetailsViewModel : BaseAPI {
    //MARK:- Initilizer and Denitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    //MARK:- Variable
    var model : MyOrdersDetailModel?

    //MARK:- Getter
    func getOrderDetailsData() -> MyOrdersDetailModel?{
        return model
    }
    
    
    //MARK:- API Function
    func apiOrdersDetails(Order_id : String ,completion : @escaping(Bool , String)->()){
        let param = ["order_item_id": Order_id] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.OrdersDetail), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
            Indicator.shared.hideProgressView()
            if response==1{
                guard let data = (result as? [String : AnyObject])
                else {
                    return
                }
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.model = try JSONDecoder().decode(MyOrdersDetailModel.self, from: jsonSer)
                        completion(true,(message ?? ""))
                }catch{
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }
           else
            {
                completion(false,(message ?? ""))
            }
        }
    }
    
}
