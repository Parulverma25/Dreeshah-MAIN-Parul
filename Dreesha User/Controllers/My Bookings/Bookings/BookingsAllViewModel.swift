////
////  MyWishlistViewModel.swift
////  Dreesha User
////
////  Created by Promatics on 09/04/21.
////

import Foundation
class BookingsAllViewModel : BaseAPI {
//MARK:- Initilizer and Denitilizer
override init() {
    super.init()
}
deinit {
    print("#Deinitilizer")
}
//MARK:- Variable
    var model : BookingsListingModel?
var totalcount = 0
var isMoreData = false
//MARK:- Getter
func getBookingListData() -> BookingsListingModel?{
    return model
}


//MARK:- API Function
    func apiBookingListfunc(limit : String ,offset : String ,Search : String ,Filter : String , Status : String ,completion : @escaping(Bool , String)->()){
        let param = ["limit": limit ,"offset": offset , "status" : Status ,"search" : Search ,"filter" : Filter] as baseParameters

        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.BookingsListing), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
        let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
        if response==1{
            guard let data = (result as? [String : AnyObject])
            else {
                return
            }
            do{
                let jsonSer = try
                JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.model = try JSONDecoder().decode(BookingsListingModel.self, from: jsonSer)
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
    
    func apiProfessionalBookingList(limit : String ,offset : String , Status : String ,completion : @escaping(Bool , String)->()){
        let param = ["limit": limit ,"offset": offset , "status" : Status] as baseParameters

        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.getProfessionalBookingList), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
        let msg = ((result as? [String : AnyObject])?["errors"] as? [String : AnyObject])?["msg"] as? String ?? ""
        if response==1{
            guard let data = (result as? [String : AnyObject])
            else {
                return
            }
            do{
                let jsonSer = try
                JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                self.model = try JSONDecoder().decode(BookingsListingModel.self, from: jsonSer)
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
