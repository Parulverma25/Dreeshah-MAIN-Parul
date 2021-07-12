//
//  BaseAPI.swift
//  HablaNow
//
//  Created by promatics on 6/19/20.
//  Copyright © 2020 Temp. All rights reserved.
//

import Foundation
import Alamofire
import SDWebImage

typealias BaseAPICompletion = (Any?, String? , Int) -> Swift.Void
typealias BaseAPIResult = SynchronousDataTaskResult
typealias baseParameters = [String : AnyObject]
typealias SynchronousDataTaskResult = (Any? , URLResponse? , Error?)
typealias FileData = (Data? , String? , Int) -> Void

class BaseAPI {
    
    init() {
        print(#file , "initializer")
    }
    
    deinit {
        print(#file , "destructed")
    }
    
    /**
     UNIFONIC SMS GATEWAY API
     
     - appsid = evxaORfSlxgB7t3_NbAGclushgrQPl
     - post type api with three parameters
     
     */
    
    
//    func sendMessage(withSmsData smsData: UnifonicSmsGateway , url: URLS = .smsSendGateway , completion : @escaping BaseAPICompletion ) {
//
//        guard let url = URL(string: url.getDescription()) else { return }
//
//        let param = ["AppSid": smsData.appSid ,
//                     "Recipient" : smsData.recipient ,
//                     "Body" : smsData.messageBody ] as Parameters
//
//        let dataTask = Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil)
//
//        dataTask.responseJSON { [weak self] (response) in
//
//            print(response)
//
//            self?.serializedResponse(withResponse: response, clouser: { (receivedData, message, response) in
//                completion(receivedData,message,response )
//            })
//        }
//    }
    
    
    /**
     The below function is used to download images from server and sets to user's profile image.
     */
    
    
    func downloadFile(fileUrls : URLS , completion : @escaping FileData) -> Void {
        
        let finalUrl = fileUrls.getDescription()
        guard let url = URL(string: finalUrl) else { print("Error in URl");
            print(finalUrl)
            completion(nil , Messages.errorInURL, 0)
            return
        }
        
        print(url)
        
        Alamofire.request(url).responseData { (response) in
            
            print(response)
            
            if response.response != nil {
                
                if let _data = response.data {
                    
                    switch response.response?.statusCode ?? -91 {
                        
                    case 0...100 :
                        print("* * * * * * * FAILED * * * * * * ")
                        completion(_data, response.result.description , 0)
                        
                    case 101...199 :
                        print("* * * * * * * FAILED * * * * * * ")
                        completion(_data, response.result.description, 0)
                        
                    case 200...299:
                        print("* * * * * * * SUCCESS * * * * * * ")
                        completion(_data, response.result.description ,1)
                        
                    case 300...399:
                        print("* * * * * * * FAILED * * * * * * ")
                        completion(_data, response.result.description ,2)
                        
                    default :
                        print("* * * * * * * FAILED * * * * * * ")
                        completion(_data,response.result.description, 2)
                        
                        
                    }
                    
                } else {
                    completion(nil,response.result.description, 2)
                }
            } else {
                completion(nil,response.result.description, 2)
            }
        }
    }
    
    
    /**
     
     This is for post type to upload any single file
     
     - getting data from internet
     - upload data to internet
     
     */
    
    func hitApiWithSingleFile(requests : RequestFileData , completion : @escaping BaseAPICompletion ) {
        
        var request = URLRequest(url: URL(string: requests.url)!)
        
        request.httpMethod = requests.method.rawValue
        
        request.allHTTPHeaderFields = requests.headers
        
        let parameters = requests.parameters ?? [:]
        
        if requests.parameters != nil {
            do {
                request.httpBody = try? JSONSerialization.data(withJSONObject: requests.parameters ?? [:], options: .prettyPrinted)
            }
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        dump(request)
        
        Alamofire.upload(multipartFormData: { multipart_FormData in
            
            multipart_FormData.append(requests.fileData, withName: requests.fileparam, fileName: requests.fileName, mimeType: requests.fileMimetype)
            
            for (key, value) in parameters {
                
                if let array = value as? [AnyObject] {
                    
                    for i in array {
                        multipart_FormData.append(String(describing: i).data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    
                    /*   if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                     multipart_FormData.append(jsonData, withName: key as String)
                     _}
                     _            */
                    
                }else if let _ = value as? Parameters {
                    
                    if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                        multipart_FormData.append(jsonData, withName: key as String)
                    }
                    
                } else {
                    multipart_FormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    
                }
                
            }
            
        },with: request,encodingCompletion: { encodingResult in
            
            switch encodingResult {
                
            case .success(let upload, let error, let data):
                
                upload.responseJSON { response in
                    
                    if let json = response.result.value {
                        
                        switch response.response?.statusCode ?? -91 {
                            
                        case 0...100 :
                            completion(json, response.result.description , 0)
                            
                        case 101...199 :
                            completion(json, response.result.description, 0)
                            
                        case 200...299:
                            print("* * * * * * * SUCCESS * * * * * * ")
                            completion(json, response.result.description ,1)
                            
                        case 300...399:
                            completion(json, response.result.description ,2)
                            
                        default :
                            completion(json,response.result.description, 2)
                        }
                        
                        
                    }else {
                        completion(nil,response.result.description, 2)
                        
                    }
                }
            case .failure(let encodingError):
                
                completion(["Error":encodingError] as Any,"Error", 2)
                
            }
        })
    }
    
    func hitApiWithMultipleFile(requests : RequestMultipleFileData , completion : @escaping BaseAPICompletion ) {
        
        var request = URLRequest(url: URL(string: requests.url)!)
        
        request.httpMethod = requests.method.rawValue
        
        request.allHTTPHeaderFields = requests.headers
        
        let parameters = requests.parameters ?? [:]
        
        if requests.parameters != nil {
            do {
                request.httpBody = try? JSONSerialization.data(withJSONObject: requests.parameters ?? [:], options: .prettyPrinted)
            }
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        dump(request)
        
        Alamofire.upload(multipartFormData: { multipart_FormData in
            
            for i in 0..<requests.fileData.count {
                multipart_FormData.append(requests.fileData[i], withName: requests.fileparam[i], fileName: requests.fileName[i], mimeType: requests.fileMimetype[i])
            }

            for (key, value) in parameters {
                
                if let array = value as? [AnyObject] {
                    
                    for i in array {
                        multipart_FormData.append(String(describing: i).data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    
                    /*   if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                     multipart_FormData.append(jsonData, withName: key as String)
                     _}
                     _            */
                    
                }else if let _ = value as? Parameters {
                    
                    if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                        multipart_FormData.append(jsonData, withName: key as String)
                    }
                    
                } else {
                    multipart_FormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    
                }
                
            }
            
        },with: request,encodingCompletion: { encodingResult in
            
            switch encodingResult {
                
            case .success(let upload, let error, let data):
                
                upload.responseJSON { response in
                    
                    if let json = response.result.value {
                        
                        switch response.response?.statusCode ?? -91 {
                            
                        case 0...100 :
                            completion(json, response.result.description , 0)
                            
                        case 101...199 :
                            completion(json, response.result.description, 0)
                            
                        case 200...299:
                            print("* * * * * *  SUCCESS * * * * * * ")
                            completion(json, response.result.description ,1)
                            
                        case 300...399:
                            completion(json, response.result.description ,2)
                            
                        default :
                            completion(json,response.result.description, 2)
                        }
                        
                        
                    }else {
                        completion(nil,response.result.description, 2)
                        
                    }
                }
            case .failure(let encodingError):
                
                completion(["Error":encodingError] as Any,"Error", 2)
                
            }
        })
    }
    
    /**
     This is for get , post , patch , put type apis
     - getting data from internet
     - checking status code generated by alamofire
     */
    
    func hitApi(requests : Request , completion : @escaping BaseAPICompletion ) {
        
        var request = URLRequest(url: URL(string: String(describing: requests.url))!)
        
        request.httpMethod = requests.method.rawValue
        
        request.allHTTPHeaderFields = requests.headers ?? [:]
        
        if requests.parameters != nil {
            defer{
                print("------------- PARAMETERS---------------")
            }
            print("------------- PARAMETERS---------------")
            print(requests.parameters!)
            do {
                request.httpBody = try? JSONSerialization.data(withJSONObject: requests.parameters ?? [:], options: .prettyPrinted)
            }
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        dump(request)
        
        let task =  Alamofire.request(request as URLRequestConvertible)
        
        task.responseJSON { [weak self] (response) in
            
            print(response)
            
            self?.serializedResponse(withResponse: response, clouser: { (receivedData, message, response) in
                completion(receivedData,message,response )
            })
        }
    }
    
    
    /**
     This function is used to return clouser of serialized response
     - take argument as dataresponse
     - return clouser
     */
    
    func serializedResponse(withResponse response: DataResponse<Any> , clouser: @escaping BaseAPICompletion) {
        if response.response != nil {
            
            if let json = response.result.value {
                
                switch response.response?.statusCode ?? -91 {
                    
                case 0...100 :
                    print("* * * * * * FAILED * * * * * * ")
                    clouser(json, response.result.description , 0)
                    
                case 101...199 :
                    print("* * * * * *  FAILED * * * * * * ")
                    clouser(json, response.result.description, 0)
                    
                case 200...299:
                    print("* * * * * *  SUCCESS * * * * * * ")
                    clouser(json, response.result.description ,1)
                    
                case 300...399:
                    print("* * * * * *  FAILED * * * * * * ")
                    clouser(json, response.result.description ,2)
                    
                default :
                    print("* * * * * * FAILED * * * * * * ")
                    clouser(json,((response.result.value as? [String: AnyObject])?["message"] as? String ?? "") , 2)
                    
//                    ((((((response.result.value as? [String: AnyObject])? ["errors"] as? [String: AnyObject])?["msg"] as? [[String:AnyObject]]))?.first)?["msg"] as? String ?? "")
                    
                }
                
            } else {
                print("* * * * * * * FAILED * * * * * * ")
                clouser(nil,response.result.description, 2)
                
            }
        } else {
            print("* * * * * * * FAILED * * * * * * ")
            clouser(nil,NSLocalizedString("Could not connect to the server", comment: ""), 2)
            
        }
    }
}


extension BaseAPI {
    
    public func synchronousDataTask(request : Request) -> SynchronousDataTaskResult {
        let semaphore = DispatchSemaphore(value: 0)
        
        var data: Data?
        var responses: URLResponse?
        var error: Error?
        
        let task = Alamofire.request(request.url, method: request.method, parameters: request.parameters, encoding: JSONEncoding.default, headers: request.headers)
        
        task.responseData { (response) in
            data = response.data
            error = response.error
            responses = URLResponse(url: ((response.request?.url)!), mimeType: "", expectedContentLength: 0, textEncodingName: "default")
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, responses, error)
    }
}


extension UIViewController {
    
    func downloadSetImage(withImageUrl imageUrl : URLS , andImageView imageView : UIImageView) {
        
        guard let url = URL(string: imageUrl.getDescription()) else {
            print("error in url")
            return
        }
        print("Downloading Image with \(url)")
        
        let indi = SDWebImageActivityIndicator.whiteLarge
        indi.indicatorView.tintColor = UIColor.yellow
        imageView.sd_imageIndicator = indi
        imageView.sd_imageIndicator?.indicatorView.frame = CGRect(x: imageView.bounds.midX - 25, y: imageView.bounds.midY - 25, width: 50, height: 50)
        imageView.sd_imageIndicator?.indicatorView.backgroundColor = UIColor(red:1, green:0.83, blue:0, alpha:0.5)
        imageView.sd_imageIndicator?.indicatorView.layer.cornerRadius = 5
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "dummy"))
    }
}
