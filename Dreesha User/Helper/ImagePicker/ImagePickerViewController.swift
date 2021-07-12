//
//  ImagePickerViewController.swift
//  Yentem
//
//  Created by Promatics on 19/09/19.
//  Copyright © 2019 promatics. All rights reserved.
//

import ObjectiveC
import Foundation
import UIKit
import TOCropViewController
import AVFoundation
import MobileCoreServices

protocol ImagePickerDelegete: class {
    
    func disFinishPicking(imgData : Data, img : UIImage)
   // func disFinishPicking(document : Data, type: String)
    
}

protocol Image_VideoPickerDelegate : class {
    func disFinishPickingforVid(imgData : Data, img : UIImage)
    func didFinishVideoPickingforvid(videoData : Data , thumbnail : UIImage)
}
//BY ME
protocol Image_DocumentPickerDelegate : class {
    func disFinishPicking(imgData : Data, img : UIImage)
    func didFinishDocumentPicking(docData : Data , docName : String)
}


protocol VideoPickerDelegate{
    func didFinishVideoPicking(videoData : Data , thumbnail : UIImage)
}

protocol DocumentPickerDelegate{
    func didFinishDocumentPicking(docData : Data , docName : String)
}

class ImagePickerViewControler : NSObject,UINavigationControllerDelegate {
    
    lazy var imagePicker = UIImagePickerController()
    
    private var imageData : Data!
    
    weak var imagePickerDelegete : ImagePickerDelegete?
    
    var videoPickerDelegate : VideoPickerDelegate?
    
    var Image_Videos_PickerDelegate : Image_VideoPickerDelegate?
    
    //BY ME
    var Image_Document_PickerDelegate : Image_DocumentPickerDelegate?
    
    var docPickerDelegete : DocumentPickerDelegate?
    
    var presentedView = UIViewController()
    
    var cropViewController = TOCropViewController()
    
    var cropStyle:TOCropViewCroppingStyle?
    
    var aspectRatioLockEnabled = false
    var aspectRatioPickerButtonHidden = true
    var cropBoxResizeEnabled = true
    
    //MARK:- Show Image Picker Options
    func showImagePicker(viewController:UIViewController){
        
        self.presentedView = viewController
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
   
        optionMenu.view.tintColor = UIColor(red: 99/255, green: 137/255, blue: 172/255, alpha: 1.0)
        
        let takePhoto_Action = UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        })
      
        let choosePhoto_Action = UIAlertAction(title: "Photo", style: .default, handler: {(alert:UIAlertAction) -> Void in
            self.photolibrary()
        })
//        let selectDocument_Action = UIAlertAction(title: "Document", style: .default) { (alert : UIAlertAction) -> Void in
//            self.doucmentlibrary()
//        }
        //Check device has a camera or not
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            
            //Captrue picture uisng camera
            optionMenu.addAction(takePhoto_Action)
            //Captrue picture uisng library
            optionMenu.addAction(choosePhoto_Action)
            

            
        }else{
            
            optionMenu.addAction(choosePhoto_Action)
//            optionMenu.addAction(selectDocument_Action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(cancelAction)
        
        viewController.present(optionMenu, animated: true, completion: nil)
        
    }
    
    func showImage_videoPicker(viewController : UIViewController){
        self.presentedView = viewController
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
   
        optionMenu.view.tintColor = UIColor(red: 99/255, green: 137/255, blue: 172/255, alpha: 1.0)
        
        let takePhoto_Action = UIAlertAction(title: "Take Photo", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        })
        
        let takeVideo_Action = UIAlertAction(title: "Take Video", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            
            self.videoCamera()
            
        })
      
        
        let choosePhoto_Action = UIAlertAction(title: "Choose Photo", style: .default, handler: {(alert:UIAlertAction) -> Void in
            self.photolibrary()
        })
        let chooseVideo_Action = UIAlertAction(title: "Choose Video", style: .default, handler: {(alert:UIAlertAction) -> Void in
            
            self.videoLibrary()
            
        })
//        let selectDocument_Action = UIAlertAction(title: "Document", style: .default) { (alert : UIAlertAction) -> Void in
//            self.doucmentlibrary()
//        }
        //Check device has a camera or not
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            
            //Captrue picture uisng camera
            optionMenu.addAction(takePhoto_Action)
            optionMenu.addAction(takeVideo_Action)
            //Captrue picture uisng library
            optionMenu.addAction(choosePhoto_Action)
            optionMenu.addAction(chooseVideo_Action)
            

            
        }else{
            
            optionMenu.addAction(choosePhoto_Action)
            optionMenu.addAction(chooseVideo_Action)
//            optionMenu.addAction(selectDocument_Action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(cancelAction)
        
        viewController.present(optionMenu, animated: true, completion: nil)
        
    }
    
    func showImage_DocumentPicker(viewController : UIViewController){
        self.presentedView = viewController
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
   
        optionMenu.view.tintColor = UIColor(red: 99/255, green: 137/255, blue: 172/255, alpha: 1.0)
        
        let takePhoto_Action = UIAlertAction(title: "Take Photo", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        })
        
       
        
      
        
        let choosePhoto_Action = UIAlertAction(title: "Choose Photo", style: .default, handler: {(alert:UIAlertAction) -> Void in
            self.photolibrary()
        })
        let selectDocument_Action = UIAlertAction(title: "Document", style: .default) { (alert : UIAlertAction) -> Void in
            self.doucmentlibrary()
        }
//        let selectDocument_Action = UIAlertAction(title: "Document", style: .default) { (alert : UIAlertAction) -> Void in
//            self.doucmentlibrary()
//        }
        //Check device has a camera or not
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            
            //Captrue picture uisng camera
            optionMenu.addAction(takePhoto_Action)
            //Captrue picture uisng library
            optionMenu.addAction(choosePhoto_Action)
            optionMenu.addAction(selectDocument_Action)
            

            
        }else{
            
            optionMenu.addAction(choosePhoto_Action)
            optionMenu.addAction(selectDocument_Action)
//            optionMenu.addAction(selectDocument_Action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(cancelAction)
        
        viewController.present(optionMenu, animated: true, completion: nil)
        
    }
    
    
    
    
    func showVideoPicker(viewController : UIViewController){
        
        self.presentedView = viewController
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.view.tintColor = UIColor(red: 99/255, green: 137/255, blue: 172/255, alpha: 1.0)
        
        let takePhoto_Action = UIAlertAction(title: "Take Video", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            
            self.videoCamera()
            
        })
        
        //Picture coose from library
        let choosePhoto_Action = UIAlertAction(title: "Choose Video", style: .default, handler: {(alert:UIAlertAction) -> Void in
            
            self.videoLibrary()
            
        })
        
        //Check device has a camera or not
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            //Captrue picture uisng camera
            optionMenu.addAction(takePhoto_Action)
            //Captrue picture uisng library
            optionMenu.addAction(choosePhoto_Action)
            
        }else{
            optionMenu.addAction(choosePhoto_Action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(cancelAction)
        viewController.present(optionMenu, animated: true, completion: nil)
    }
    
    func showImageDocumentPicker(viewController:UIViewController){

        self.presentedView = viewController

        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        optionMenu.view.tintColor = UIColor(red: 99/255, green: 137/255, blue: 172/255, alpha: 1.0)
       
        let choosePhoto_Action = UIAlertAction(title: "Photo", style: .default, handler: {(alert:UIAlertAction) -> Void in
            self.photolibrary()
        })

        let selectDocument_Action = UIAlertAction(title: "Document", style: .default) { (alert : UIAlertAction) -> Void in
            self.doucmentlibrary()
        }
        optionMenu.addAction(selectDocument_Action)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(cancelAction)

        viewController.present(optionMenu, animated: true, completion: nil)
    }
    
    func camera(){
        
        self.imagePicker.sourceType = .camera
        self.imagePicker.delegate = self
        self.presentedView.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func videoCamera(){
        self.imagePicker.sourceType = .camera
        self.imagePicker.delegate = self
        self.imagePicker.mediaTypes = ["public.movie"]
        self.imagePicker.videoQuality = .type640x480
        self.imagePicker.showsCameraControls = true
        self.presentedView.present(imagePicker, animated: true, completion: nil)
    }
    
    func photolibrary(){
        
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.mediaTypes = ["public.image"]
        self.imagePicker.videoQuality = .typeLow
        self.imagePicker.delegate = self
        self.presentedView.present(imagePicker, animated: true, completion: nil)
        
    }

   func doucmentlibrary(){

        let types: [String] = [kUTTypePDF as String]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.presentedView.present(documentPicker, animated: true, completion: nil)

    }
    
    func videoLibrary(){
        self.imagePicker.sourceType = .savedPhotosAlbum
        self.imagePicker.delegate = self
        self.imagePicker.mediaTypes = [kUTTypeMovie as String]

        self.presentedView.present(imagePicker, animated: true, completion: nil)
    }
    
}

//MARK:- Image Picker Controller

extension ImagePickerViewControler : UIImagePickerControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.presentedView.dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- Image Cropper

extension ImagePickerViewControler : TOCropViewControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                  
            let fileName = url.lastPathComponent
                  let fileType = url.pathExtension
                   
                   print(fileName, "imageView Naaam")
           // Singleton.shared.fileName = fileName
        
        
        }
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            
            if mediaType  == "public.image" {
                print("Image Selected")
                let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                
                self.cropViewController.customAspectRatio = CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height)
                
                self.cropStyle = TOCropViewCroppingStyle.default
                
                self.cropViewController = TOCropViewController(croppingStyle: self.cropStyle!, image: selectedImage)
                
                self.cropViewController.toolbar.clampButtonHidden = false
                
                cropViewController.toolbar.rotateClockwiseButtonHidden = false
                
                cropViewController.cropView.setAspectRatio(CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height), animated: true)
                
                cropViewController.cropView.aspectRatioLockEnabled = false
                
                cropViewController.toolbar.rotateButton.isHidden = false
                
                cropViewController.toolbar.resetButton.isHidden = false
                
                cropViewController.delegate = self
                
                cropViewController.cropView.cropBoxResizeEnabled = self.cropBoxResizeEnabled
                cropViewController.cropView.aspectRatioLockEnabled = self.aspectRatioLockEnabled
                cropViewController.aspectRatioPickerButtonHidden = self.aspectRatioPickerButtonHidden
                
                self.presentedView.dismiss(animated: true, completion: {
                    self.presentedView.present(self.cropViewController, animated: true, completion: nil)
                })
            }else if mediaType == "public.movie"{
                var videoURL: NSURL?
                videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL
                if let videoData =  NSData(contentsOf: videoURL! as URL){
                    guard let thumbnail = ThumbnailGenerator.shared.generateThumbnail(path: videoURL! as URL) else { return }
                
                    
                    self.Image_Videos_PickerDelegate?.didFinishVideoPickingforvid(videoData: videoData as Data, thumbnail: thumbnail)
                    self.videoPickerDelegate?.didFinishVideoPicking(videoData: videoData as Data , thumbnail: thumbnail)
                }
                else{
                    
                }
                self.presentedView.dismiss(animated: true, completion: nil)
            }else {
                let type = info[UIImagePickerController.InfoKey.mediaType]
                print(type!)
            }
            
            
        }
        
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        
        self.presentedView.dismiss(animated: true, completion: nil)
        
         self.imageData = (image.jpegData(compressionQuality: 0.2))
        
         
        self.Image_Videos_PickerDelegate?.disFinishPickingforVid(imgData: self.imageData, img: image)
        self.Image_Document_PickerDelegate?.disFinishPicking(imgData: self.imageData, img: image)
        
        self.imagePickerDelegete?.disFinishPicking(imgData: self.imageData, img: image)
        
    }
}

// MARK:- Document Picker
extension ImagePickerViewControler: UIDocumentMenuDelegate, UIDocumentPickerDelegate {

    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {

    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)

        guard let fileURL = urls.first else { return }
        var uploadedData = Data()
        print("import result : \(fileURL)")

        let name = fileURL.lastPathComponent
        let fileName = name.replacingOccurrences(of: ".pdf", with: "")

        do {
            try uploadedData = Data(contentsOf: fileURL)
            let fileExtension = fileURL.pathExtension
            print(fileExtension)

            if(fileExtension == "pdf"){
                self.docPickerDelegete?.didFinishDocumentPicking(docData: uploadedData, docName: name)
                self.Image_Document_PickerDelegate?.didFinishDocumentPicking(docData: uploadedData, docName: name)
            }else{
               // self.presentedView.show("File type is not allowed", sender: <#Any?#>)
            }
        } catch  {
            print("not picked")
        }
        
    }
}

 
