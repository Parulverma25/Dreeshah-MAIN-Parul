//
//  AddImagePopUpViewController.swift
//  Dreesha User
//
//  Created by Promatics on 14/05/21.
//

import UIKit

protocol addImage {
    func getImageValues(image: UIImage, imgData: Data, imgName: String, imgDescription: String)
    func selectImage()
}

class AddImagePopUpViewController: UIViewController {
    //MARK:- IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imgDescription_TxtField: SkyFloatingLabelTextField!
    
    //MARK:- Variables
    var selectedImage : UIImage!
    var imagePicker = ImagePickerViewControler()
    var imgName: String!
    var imageData : Data!
    var isSelect : Int!
    var selectCost : String!
    var delegate: addImage?
    
    var priceArray = ["Upto 10000 AED", "Upto 50000 AED", "Upto 100000 AED", "Upto 500000 AED", "More than 500000 AED"]
   // var selectedPrice = ""
    
    //MARK:- DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedImage != nil){
            imageView.image = selectedImage
            imageLabel.text = imgName
        }else{
            imageView.image = UIImage(named: "Placehold")
        }
    }
    
    //MARK:- Disapppear
    
    override func viewWillDisappear(_ animated: Bool) {
        if isSelect == 0{
            delegate?.selectImage()
        }else if isSelect == 1{
            delegate?.getImageValues(image: imageView.image!, imgData: imageData!, imgName: imageLabel.text!, imgDescription: imgDescription_TxtField.text!)
        }
    }
    
    //MARK:- IBAction
    
    @IBAction func cancelTask(_ sender: Any) {
        isSelect = 2
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func selectImage(_ sender: Any) {
        isSelect = 0
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImage(_ sender: Any) {
        if imageView.image == nil{
            view.makeToast("Please select a image")
        }else{
            isSelect = 1
            self.dismiss(animated: true, completion: nil)
        }
    }
}
