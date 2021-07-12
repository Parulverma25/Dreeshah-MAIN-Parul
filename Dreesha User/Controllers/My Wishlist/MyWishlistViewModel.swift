////
////  MyWishlistViewModel.swift
////  Dreesha User
////
////  Created by Promatics on 09/04/21.
////

import Foundation
class MyWishlistViewModel : BaseAPI {
//MARK:- Initilizer and Denitilizer
override init() {
    super.init()
}
deinit {
    print("#Deinitilizer")
}
//MARK:- Variable
    var model : MyWishListModel?
var totalcount = 0
var isMoreData = false
//MARK:- Getter
func getWishlistListData() -> MyWishListModel?{
    return model
}


//MARK:- API Function
func apiWishList(UserId : String ,completion : @escaping(Bool , String)->()){
    let param = ["user_id": UserId] as baseParameters

    super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.WishlistListing), method: .post, parameters: param, headers: false ,body: nil)) {(result,message,response) in
        let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
        if response==1{
            guard let data = (result as? [String : AnyObject])
            else {
                return
            }
            do{
                let jsonSer = try
                JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.model = try JSONDecoder().decode(MyWishListModel.self, from: jsonSer)
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
