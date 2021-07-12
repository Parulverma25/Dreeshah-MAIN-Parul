//
//  MyAlbumsViewModel.swift
//  Dreesha User
//
//  Created by Promatics on 09/04/21.
//

import Foundation
class MyAlbumsViewModel: BaseAPI {
    //MARK:- Initilizer and Denitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    //MARK:- Variable
    
    var model : MyAlbumsModel?
    var isMoreData = false
    //MARK:- Getter
    func getAlbumlistData() -> MyAlbumsModel?{
        return model
    }
    
    
    //MARK:- API Function
    func apiAlbumList(Limit: String ,Offset: String ,completion : @escaping(Bool , String)->()){
        let param = ["limit_val": Limit , "offset_val" : Offset] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.AlbumListing), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
            if response == 1{
                guard  let data = result as? [String : AnyObject]? else {
                    return
                }
                do{
                    let jsonSer = try
                        JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    self.model=try
                        JSONDecoder().decode(MyAlbumsModel.self, from: jsonSer)
                    
                    for i in 0..<(self.model?.result.count ?? 0){
                        if (self.model?.result[i]?.albumImages.first!?.mediaType == "video/mp4") && ((self.model?.result[i]?.albumImages.count ?? 0) > 0){
                            let url = URLS.albumImageUrl(self.model?.result[i]?.albumImages.first??.image ?? "").getDescription()
                            self.model?.result[i]?.albumImages[0]?.thumbnail = ThumbnailGenerator.shared.generateThumbnail(path: URL(string: url)!)
                        }
                    }
                    
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
