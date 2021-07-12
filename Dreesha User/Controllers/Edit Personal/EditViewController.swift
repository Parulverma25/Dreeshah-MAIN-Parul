//
//  EditViewController.swift
//  Dreesha User
//
//  Created by Promatics on 10/03/21.
//

import UIKit

class EditViewController: UIViewController{
    //Mark Outlets
    @IBOutlet weak var Submmit: UIButton!
    @IBOutlet weak var editview: UIView!
    @IBOutlet weak var EditImgView: UIImageView!
    @IBOutlet weak var FnameTxtField: SkyFloatingLabelTextField!
    @IBOutlet weak var LastNameTxtFeild: SkyFloatingLabelTextField!
    @IBOutlet weak var EmailTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var PhNoTxtField: SkyFloatingLabelTextField!
    
    // MARK: Variables
    var viewModel = PersonalInfoViewModel()
    var viewModelEdit = EditPersonalInfoViewModel()
    var imagePicker = ImagePickerViewControler()
    var imageData = Data()
    var Verifycount = false
    
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        editview.layer.cornerRadius = 20
        editview.layer.masksToBounds=true

        makeRounded()
        self.hideKeyboardWhenTappedAround()
        hitApiEditUserDetails()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "My Profile")
       
        if Verifycount==true {
            
            EmailTxtFld.lineColor = UIColor.red
            EmailTxtFld.isUserInteractionEnabled = false
        }else{
            PhNoTxtField.isUserInteractionEnabled = false
        }
    }

    func makeRounded() {
        EditImgView.layer.masksToBounds = false
        EditImgView.layer.cornerRadius = EditImgView.frame.height / 2
        EditImgView.clipsToBounds = true
        Submmit.layer.cornerRadius = 17
        Submmit.layer.masksToBounds=true
    }
    
    @IBAction func SubmitAct(_ sender: Any) {
        saveDetails()
    }
    
    
    
    @IBAction func EditImage(_ sender: Any) {
        imagePicker.imagePickerDelegete = self
        imagePicker.showImagePicker(viewController: self)
    }
}




extension EditViewController : ImagePickerDelegete{
    func disFinishPicking(imgData: Data, img: UIImage) {
        EditImgView.image=img
        imageData = img.jpegData(compressionQuality: 0.6)!
    }
}


extension EditViewController{
    
    func hitApiEditUserDetails()  {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiUserDetails(user_id: AppUser().user_id){(isSuccess,message) in
        
            if isSuccess{
                
                self.FnameTxtField.text =   self.viewModel.getUserDetails()?.firstName
                self.LastNameTxtFeild.text = self.viewModel.getUserDetails()?.lastName
                self.EmailTxtFld.text=self.viewModel.getUserDetails()?.email
                self.PhNoTxtField.text=self.viewModel.getUserDetails()?.phoneNumber
                let url = URLS.profileImageUrl(self.viewModel.getUserDetails()?.profileImage ?? "").getDescription()
                self.EditImgView.sd_setImage(with: URL(string: url),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
                
                self.imageData = (self.EditImgView.image?.jpegData(compressionQuality: 0.6))!
                
            }else{
                self.view.makeToast(message , position : .center)
            }
}
    }

    func saveDetails(){
        
        viewModelEdit.apiEditInfo(ID: AppUser().user_id, first_name: FnameTxtField.text ?? "" , last_name: LastNameTxtFeild.text ?? "", email: EmailTxtFld.text ?? "", contact: PhNoTxtField.text ?? "", imageName: GenerateUniqueName(), imageData: imageData, imageMime: "image/jpeg")
        { (isSuccess , message ) in
            if isSuccess{
                UserDefaults.standard.setValue(self.viewModel.model?.profileImage ?? "", forKey: "profile_image")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            self.view.makeToast(message , position : .center)
        }
    }
}
}

