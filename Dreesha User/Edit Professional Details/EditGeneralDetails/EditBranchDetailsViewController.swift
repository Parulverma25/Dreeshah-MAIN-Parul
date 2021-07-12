//
//  EditBranchDetailsViewController.swift
//  Dreesha User
//
//  Created by promatics on 23/04/21.
//

import UIKit

class EditBranchDetailsViewController: UIViewController {
    
    @IBOutlet weak var addBranchView: SkyFloatingLabelTextField!
    @IBOutlet weak var profileImageView: SetImage!
    @IBOutlet weak var profileImgBtn: SetButton!
    @IBOutlet weak var ProfileLogoImage: SetImage!
    var viewModel = SignupViewModel()
    var dataBranch = ProfessionalSignUpdata()
    
    var viewModelP = PersonalInfoViewModel()
    
    var imagePicker = ImagePickerViewControler()
    var isProfileImage = false
    var islogoImage = false
    var profileImageData = Data()
    var LogoImageData = Data()
    var editProfileVm = EditDetailsViewModel()
    
    var isEdit: Bool! = false
   
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        addBranchView.keyboardType = .phonePad
        
        if isEdit {
            
            let url = URLS.profileImageUrl(viewModelP.dataModel?.data?.profileImage ?? "").getDescription()
            profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "Placeholding"))
            self.dataBranch.branchProfile = viewModelP.dataModel?.data?.profileImage ?? ""
            let urld = URLS.profileImageUrl(viewModelP.dataModel?.data?.logoImage ?? "").getDescription()
            ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "Placeholding"))
            self.dataBranch.logo = viewModelP.dataModel?.data?.logoImage ?? ""
            
            
            if (viewModelP.dataModel?.data?.noOfBranches) == nil{
                print(viewModelP.dataModel?.data?.noOfBranches ?? "")
            }else{
            addBranchView.text = String((viewModelP.dataModel?.data?.noOfBranches)!)
            }
        }
    }
 

    
    override func viewWillAppear(_ animated: Bool) {

        setBackWithTitle(titleVal : "Personal Information")
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        
            if self.addBranchView.text == "" {
                self.view.makeToast("Please Enter Branch")
            } else {
                self.dataBranch.noOfBranches = addBranchView.text
                dump(self.dataBranch)
               editBranchDetails()
            }
        
    }
    
    @IBAction func tapProfileImgBtn(_ sender: Any) {
        self.imagePicker.imagePickerDelegete = self
        isProfileImage = true
        imagePicker.showImagePicker(viewController: self)
    }
    @IBAction func tapLogoImageBtn(_ sender: SetButton) {
        isProfileImage = false
        self.imagePicker.imagePickerDelegete = self
        
        imagePicker.showImagePicker(viewController: self)
    }
    
}


//MARK:- Image Picker Delegate

extension EditBranchDetailsViewController : ImagePickerDelegete {
    
    func disFinishPicking(imgData: Data, img: UIImage) {
        
        if isProfileImage{
            profileImageData = img.jpegData(compressionQuality: 0.6)!
            self.profileImageView.image = img
            uploadProfileImage()
        }else {
            LogoImageData = img.jpegData(compressionQuality: 0.6)!
            self.ProfileLogoImage.image = img
            uploadLogoImage()
        }

    }
   
}

//MARK:- API CALL

extension EditBranchDetailsViewController{
    
    func uploadProfileImage(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiUploadProfileImage(imageData: profileImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
            if isSuccess{
                self.dataBranch.branchProfile = (data as? [String : AnyObject])?["data"] as? String ?? ""
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    func uploadLogoImage(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiUploadLogoImage(imageData: LogoImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
            if isSuccess{
                self.dataBranch.logo = (data as? [String : AnyObject])?["data"] as? String ?? ""
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    
    func editBranchDetails(){
        
    
            
            var certificateAndRewardArray : [[String : String]] = [[:]]

            for i in 0..<(viewModelP.dataModel?.data?.certificateAwards!.count)! {

                if let iii = viewModelP.dataModel?.data?.certificateAwards![i].image, let ddd = viewModelP.dataModel?.data?.certificateAwards![i].date {

                    certificateAndRewardArray.insert(["image" : iii, "date" : ddd], at: i)

                }

            }
        
        editProfileVm.editProfesstionalProfile(FirstName: (viewModelP.dataModel?.data?.firstName ?? ""), LastName: viewModelP.dataModel?.data?.lastName ?? "", Email: viewModelP.dataModel?.data?.email ?? "", branchNameEn: viewModelP.dataModel?.data?.branchNameEn ?? "", branchNameAr: viewModelP.dataModel?.data?.branchNameAr ?? "", branchTypeId: (viewModelP.dataModel?.data?.branchTypeID ?? ""), branchCategoryId: (viewModelP.dataModel?.data?.branchCategoryID ?? ""), branchBrief: viewModelP.dataModel?.data?.branchBrief ?? "", certificateAward: certificateAndRewardArray, noOfBranches: dataBranch.noOfBranches ?? "", profileImage: self.dataBranch.branchProfile ?? "", LogoImage: self.dataBranch.logo ?? "", country: self.viewModelP.dataModel?.data?.professionalAddress?.country ?? "", country_ph_code: self.viewModelP.dataModel?.data?.professionalAddress?.countryPhCode ?? "", phoneNumber: self.viewModelP.dataModel?.data?.professionalAddress?.phoneNumber ?? "", addFirstName: self.viewModelP.dataModel?.data?.professionalAddress?.addrFirstName ?? "", addLastName: self.viewModelP.dataModel?.data?.professionalAddress?.addrLastName ?? "", addLine1: self.viewModelP.dataModel?.data?.professionalAddress?.addressLine1 ?? "", addLine2: self.viewModelP.dataModel?.data?.professionalAddress?.addressLine2 ?? "", pincode: String(self.viewModelP.dataModel?.data?.professionalAddress?.pincode ?? 0), landmark: self.viewModelP.dataModel?.data?.professionalAddress?.landmark ?? "", state: self.viewModelP.dataModel?.data?.professionalAddress?.state ?? "", city: self.viewModelP.dataModel?.data?.professionalAddress?.city ?? "", co_ordinator_eng: viewModelP.dataModel?.data?.contactDetails?.coOrdinatorEng ?? "", co_ordinator_arabic: viewModelP.dataModel?.data?.contactDetails?.coOrdinatorArabic ?? "", branchEmail: viewModelP.dataModel?.data?.contactDetails?.branchEmail ?? "", branchWebsite: viewModelP.dataModel?.data?.contactDetails?.branchWebsite ?? "", countryCode: viewModelP.dataModel?.data?.contactDetails?.countryCode ?? "", businessCountryCode: viewModelP.dataModel?.data?.contactDetails?.businessCountryCode ?? "", mobileNumber: viewModelP.dataModel?.data?.contactDetails?.mobileNumber ?? "", businessMobileNumber: viewModelP.dataModel?.data?.contactDetails?.businessMobileNumber ?? "", instaAccount: viewModelP.dataModel?.data?.contactDetails?.instaAcc ?? "", youtubeAccount: viewModelP.dataModel?.data?.contactDetails?.youtubeChannel ?? "", branchYear: (viewModelP.dataModel?.data?.businessDetails?.branchYear ?? 0), issued_in_countries: (viewModelP.dataModel?.data?.businessDetails?.issuedInCountries)!, issued_in_cities: (viewModelP.dataModel?.data?.businessDetails?.issuedInCities)!, branchLicence: viewModelP.dataModel?.data?.businessDetails?.branchLicence ?? "", licenceNumber: viewModelP.dataModel?.data?.businessDetails?.licenceNumber ?? "", no_of_emp: viewModelP.dataModel?.data?.businessDetails?.noOfEmp ?? "", serviceCategories: self.viewModelP.dataModel?.data?.serviceCategories.map({$0.id ?? ""}) ?? [], serviceSubCate: self.viewModelP.dataModel?.data?.serviceSubcategories.map({$0.id ?? ""}) ?? [], newCategories: [[:]], serviceCountry: (viewModelP.dataModel?.data?.serviceDetails?.serviceCountry)!, serviceCity: (viewModelP.dataModel?.data?.serviceDetails?.serviceCity)!, serviceCost: viewModelP.dataModel?.data?.serviceDetails?.serviceCost ?? "") { (isSuccess, message) in
            if isSuccess {

                self.view.makeToast("Profile Edit Successfully")

                self.navigationController?.popViewController(animated: true)

            } else {

                self.view.makeToast(message)

            }
        }
            
         
        }
}
