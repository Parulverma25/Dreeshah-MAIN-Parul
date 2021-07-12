

import Foundation
class AlbumDetailsViewModel : BaseAPI {
    //MARK:- Initilizer and Denitilizer
    override init() {
        super.init()
    }
    deinit {
        print("#Deinitilizer")
    }
    //MARK:- Variable
    var model : AlbumDetailsModel?

    //MARK:- Getter
    func getAlbumDetailsData() -> AlbumDetailsModel?{
        return model
    }
    //MARK:- API Function
    func apiAlbumDetails(Album_id : String ,completion : @escaping(Bool , String)->()){
        let param = ["album_id": Album_id] as baseParameters
        
        super.hitApi(requests: Request(url: (URLS.baseUrl , APISuffix.AlbumDetails), method: .post, parameters: param, headers: true ,body: nil)) {(result,message,response) in
            let msg = (((result as? [String:AnyObject])?["errors"] as? [String:AnyObject])? ["msg"] as? String)
            Indicator.shared.hideProgressView()
            if response==1{
                guard let data = result as? [String : AnyObject]?
                else {
                    return
                }
                do{
                    let jsonSer = try JSONSerialization.data(withJSONObject: data ?? "", options: .prettyPrinted)
                    self.model = try JSONDecoder().decode(AlbumDetailsModel.self, from: jsonSer)
                    
                    for i in 0..<(self.model?.result.albumImages.count ?? 0){
                        if self.model?.result.albumImages[i].mediaType == "video/mp4"{
                            let url = URLS.albumImageUrl(self.model?.result.albumImages[i].image ?? "").getDescription()
                            self.model?.result.albumImages[i].thumbnail = ThumbnailGenerator.shared.generateThumbnail(path: URL(string: url)!)
                        }
                    }
                    
                    completion(true,msg ?? "")
                }catch{
                    print(error)
                    completion(false , error.localizedDescription)
                }
            }
           else
            {
                completion(false,msg ?? "")
            }
        }
    }
    
    func hiteditAlbum(AlbumID: String ,AlbumMediaID : String , imageName : String ,imageData : Data , imageMime : String , completion : @escaping(Bool , String)->()){
        let param = ["album_id": AlbumID, "album_media_id" : AlbumMediaID ] as baseParameters

        super.hitApiWithSingleFile(requests: RequestFileData(url: (URLS.baseUrl, APISuffix.EditAlbum) ,method: .post, parameters: param, headers: true, fileData: imageData, fileName: imageName, fileMimetype: imageMime, fileParam: "media")) { (result, message, response) in
            let msg = (result as? [String : AnyObject])?["message"] as? String ?? ""
            if response == 1{
                completion(true , msg)
            }else{
                completion(false , msg)
            }
        }
    }
    
    func hitDeleteAlbum(Album_id : String , Album_media_id : String , completion : @escaping(Bool , String)->()){
        let param = ["album_id" : Album_id,"album_media_id" : Album_media_id] as baseParameters
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.DeleteAlbum), method: .post, parameters: param, headers: true, body: nil)) { (result, message, response) in
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
