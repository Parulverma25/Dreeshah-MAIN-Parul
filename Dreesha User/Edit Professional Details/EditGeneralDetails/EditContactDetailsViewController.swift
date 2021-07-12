//
//  EditContactDetailsViewController.swift
//  Dreesha User
//
//  Created by Admin on 22/04/21.
//

import UIKit
import FlagPhoneNumber
class EditContactDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameInEnglish: SkyFloatingLabelTextField!
    @IBOutlet weak var nameInArabic: SkyFloatingLabelTextField!
    @IBOutlet weak var branchEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var branchWebsite: SkyFloatingLabelTextField!
    @IBOutlet weak var intagram: SkyFloatingLabelTextField!
    @IBOutlet weak var youtube: SkyFloatingLabelTextField!
    @IBOutlet weak var mobileNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var businessMobileNumbe: SkyFloatingLabelTextField!
    
    @IBOutlet weak var phoneNumberTextField: FPNTextField!
    
    @IBOutlet weak var businessPhoneNumberTF: FPNTextField!
    
    @IBOutlet weak var profileImageView: SetImage!
    @IBOutlet weak var profileImgBtn: SetButton!
    @IBOutlet weak var ProfileLogoImage: SetImage!
    var dataContact = ProfessionalSignUpdata()
    
    var viewModel = PersonalInfoViewModel()
    var viewModelS = SignupViewModel()
    var isEdit: Bool! = false
    
    var countryCode = "+1"
    var businessCountryCode = "+1"
    
    let counListing : FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    let pTf = FPNTextField()
  
    var editProfileVm = EditDetailsViewModel()
    
    var imagePicker = ImagePickerViewControler()
    var profileImageData = Data()
    var LogoImageData = Data()
    var isProfileImage = false
    var branchVM = DetailsOfBranchViewModel()

    
    var branchId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pTf.displayMode = .list
        counListing.showCountryPhoneCode = true
        
        counListing.setup(repository: pTf.countryRepository)

        
        mobileNumber.keyboardType = .phonePad
        businessMobileNumbe.keyboardType = .phonePad
        branchEmail.keyboardType = .emailAddress
        
        phoneNumberTextField.isUserInteractionEnabled = false
        phoneNumberTextField.placeholder = nil
        businessPhoneNumberTF.isUserInteractionEnabled = false
        businessPhoneNumberTF.placeholder = nil
      
        
        if isEdit{
            let url = URLS.profileImageUrl(viewModel.dataModel?.data?.profileImage ?? "").getDescription()
            profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataContact.branchProfile = viewModel.dataModel?.data?.profileImage ?? ""
            let urld = URLS.profileImageUrl(viewModel.dataModel?.data?.logoImage ?? "").getDescription()
            ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataContact.logo = viewModel.dataModel?.data?.logoImage ?? ""
            nameInEnglish.text = viewModel.dataModel?.data?.contactDetails?.coOrdinatorEng
            nameInArabic.text = viewModel.dataModel?.data?.contactDetails?.coOrdinatorArabic
            branchEmail.text = viewModel.dataModel?.data?.contactDetails?.branchEmail
            branchWebsite.text = viewModel.dataModel?.data?.contactDetails?.branchWebsite
            intagram.text = viewModel.dataModel?.data?.contactDetails?.instaAcc
            youtube.text = viewModel.dataModel?.data?.contactDetails?.youtubeChannel
            mobileNumber.text = viewModel.dataModel?.data?.contactDetails?.mobileNumber
            businessMobileNumbe.text = viewModel.dataModel?.data?.contactDetails?.businessMobileNumber
            
        }else{
            let url = URLS.profileImageUrl(branchVM.getBranchDetails()?.branchProfile ?? "").getDescription()
            profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataContact.branchProfile = branchVM.getBranchDetails()?.branchProfile ?? ""
            let urld = URLS.profileImageUrl(branchVM.getBranchDetails()?.branchLogo ?? "").getDescription()
            ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataContact.logo = branchVM.getBranchDetails()?.branchLogo ?? ""
            nameInEnglish.text = branchVM.getBranchDetails()?.contactDetails?.coOrdinatorEng
            nameInArabic.text = branchVM.getBranchDetails()?.contactDetails?.coOrdinatorArabic
            branchEmail.text = branchVM.getBranchDetails()?.contactDetails?.branchEmail
            branchWebsite.text = branchVM.getBranchDetails()?.contactDetails?.branchWebsite
            intagram.text = branchVM.getBranchDetails()?.contactDetails?.instaAcc
            youtube.text = branchVM.getBranchDetails()?.contactDetails?.youtubeChannel
            mobileNumber.text = branchVM.getBranchDetails()?.contactDetails?.mobileNumber
            businessMobileNumbe.text = branchVM.getBranchDetails()?.contactDetails?.businessMobileNumber
        }
    }


    
    override func viewWillAppear(_ animated: Bool) {

        navigationController?.navigationBar.isHidden = false

        if isEdit{
            setBackWithTitle(titleVal : "Personal Information")
        }else{
            setBackWithTitle(titleVal: "Branch Details")
        }
    }
    
    @IBAction func businessBtn(_ sender: Any) {
        
        
            if self.nameInEnglish.text == "" {
                self.view.makeToast("Please Enter Name")
            } else if self.nameInArabic.text == "" {
                self.view.makeToast("Please Enter Name in Arabic")
            }  else if !(Validation().validOnlyArabic(arabicTextField: self.nameInArabic.text ?? "")){
                self.view.makeToast("Please Enter Name in Arabic")
            }else if self.branchEmail.text == "" {
                self.view.makeToast("Please Enter Branch Email")
            } else if !(self.branchEmail.text?.isValidEmail() ?? false) {
                self.view.makeToast("Please Enter valid email")
            }  else if self.mobileNumber.text == "" {
                self.view.makeToast("Please Enter Business Mobile Number")
            } else if (mobileNumber.text!.count < 7 || mobileNumber.text!.count > 15) {
                self.view.makeToast("Business Mobile Number should be between 7-15")
            } else if self.businessMobileNumbe.text == "" {
                self.view.makeToast("Please Enter Business Landline Number")
    //            } else if self.intagram.text == "" {
    //                self.view.makeToast("Please Enter Instagram Account")
    //            } else if self.youtube.text == "" {
    //                self.view.makeToast("Please Enter Youtube Account")
            } else if (businessMobileNumbe.text!.count < 7 || businessMobileNumbe.text!.count > 15) {
                self.view.makeToast("Business Landline Number should be between 7-15")
            } else {
                
                self.dataContact.co_ordinator_eng = nameInEnglish.text
                self.dataContact.co_ordinator_arabic = nameInArabic.text
                self.dataContact.branchEmail = branchEmail.text
                self.dataContact.branchWebsite = branchWebsite.text
                self.dataContact.mobileNumber = mobileNumber.text
                self.dataContact.businessMobileNumber = businessMobileNumbe.text
                self.dataContact.instaAccount = intagram.text
                self.dataContact.youtubeAccount = youtube.text
                self.dataContact.countryCode = countryCode
                self.dataContact.BusinessCountryCode = businessCountryCode

               editContactDetails()
            }
        
    }
    
    
    @IBAction func mobilePicker(_ sender: Any) {
       
        counListing.didSelect = {[weak self] country in
            self?.phoneNumberTextField.setFlag(countryCode: country.code)
            self?.phoneNumberTextField.placeholder = nil
            self!.countryCode = country.phoneCode
        }
    
        self.openPicker()
    }
    
    @IBAction func busniessMobilePicker(_ sender: Any) {
        
        counListing.didSelect = {[weak self] country in
            self?.businessPhoneNumberTF.setFlag(countryCode: country.code)
            self?.businessPhoneNumberTF.placeholder = nil
            self!.businessCountryCode = country.phoneCode
        }
        self.openPicker()
    }
    
    @IBAction func tapProfileImgBtn(_ sender: Any) {
        self.imagePicker.imagePickerDelegete = self
        isProfileImage = true
        imagePicker.showImagePicker(viewController: self)
    }
    
    @IBAction func tapLogoImageBtn(_ sender: SetButton) {
        self.imagePicker.imagePickerDelegete = self
      
        imagePicker.showImagePicker(viewController: self)
        
    }
    
    
    
    @objc func dismissCountries() {
        counListing.dismiss(animated: true, completion: nil)
    }
    
    
    func openPicker() {
        let navController = UINavigationController(rootViewController: counListing)
        counListing.title = "Countries"
        counListing.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissCountries))

        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}


//MARK:- Image Picker Delegate

extension EditContactDetailsViewController : ImagePickerDelegete {
    
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
extension EditContactDetailsViewController{
    func uploadProfileImage(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModelS.apiUploadProfileImage(imageData: profileImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
            if isSuccess{
                self.dataContact.branchProfile = (data as? [String : AnyObject])?["data"] as? String ?? ""
            }else{
                self.view.makeToast(message)
            }
        }
    }
        func uploadLogoImage(){
            Indicator.shared.showProgressView(self.parent?.view ?? self.view)
            viewModelS.apiUploadProfileImage(imageData: LogoImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
                if isSuccess{
                    self.dataContact.logo = (data as? [String : AnyObject])?["data"] as? String ?? ""
                }else{
                    self.view.makeToast(message)
                }
            }
    }
    
    
    func editContactDetails(){
        
     
        
        if isEdit{
            
            var certificateAndRewardArray : [[String : String]] = [[:]]

            for i in 0..<(viewModel.dataModel?.data?.certificateAwards!.count)! {

                if let iii = viewModel.dataModel?.data?.certificateAwards![i].image, let ddd = viewModel.dataModel?.data?.certificateAwards![i].date {

                    certificateAndRewardArray.insert(["image" : iii, "date" : ddd], at: i)

                }

            }
            
            editProfileVm.editProfesstionalProfile(FirstName: (viewModel.dataModel?.data?.firstName ?? ""), LastName: viewModel.dataModel?.data?.lastName ?? "", Email: viewModel.dataModel?.data?.email ?? "", branchNameEn: viewModel.dataModel?.data?.branchNameEn ?? "", branchNameAr: viewModel.dataModel?.data?.branchNameAr ?? "", branchTypeId: (viewModel.dataModel?.data?.branchTypeID ?? ""), branchCategoryId: (viewModel.dataModel?.data?.branchCategoryID ?? ""), branchBrief: viewModel.dataModel?.data?.branchBrief ?? "", certificateAward: certificateAndRewardArray, noOfBranches: String(viewModel.dataModel?.data?.noOfBranches ?? 0), profileImage: self.dataContact.branchProfile ?? "", LogoImage: self.dataContact.logo ?? "", country: self.viewModel.dataModel?.data?.professionalAddress?.country ?? "", country_ph_code: self.viewModel.dataModel?.data?.professionalAddress?.countryPhCode ?? "", phoneNumber: self.viewModel.dataModel?.data?.professionalAddress?.phoneNumber ?? "", addFirstName: self.viewModel.dataModel?.data?.professionalAddress?.addrFirstName ?? "", addLastName: self.viewModel.dataModel?.data?.professionalAddress?.addrLastName ?? "", addLine1: self.viewModel.dataModel?.data?.professionalAddress?.addressLine1 ?? "", addLine2: self.viewModel.dataModel?.data?.professionalAddress?.addressLine2 ?? "", pincode: String(self.viewModel.dataModel?.data?.professionalAddress?.pincode ?? 0), landmark: self.viewModel.dataModel?.data?.professionalAddress?.landmark ?? "", state: self.viewModel.dataModel?.data?.professionalAddress?.state ?? "", city: self.viewModel.dataModel?.data?.professionalAddress?.city ?? "", co_ordinator_eng: self.nameInEnglish.text ?? "", co_ordinator_arabic: self.nameInArabic.text ?? "", branchEmail: self.branchEmail.text ?? "", branchWebsite: self.branchWebsite.text ?? "", countryCode: self.countryCode, businessCountryCode: self.businessCountryCode, mobileNumber: self.mobileNumber.text ?? "", businessMobileNumber: self.businessMobileNumbe.text ?? "", instaAccount: self.intagram.text ?? "", youtubeAccount: self.youtube.text ?? "", branchYear: (viewModel.dataModel?.data?.businessDetails?.branchYear ?? 0), issued_in_countries: (viewModel.dataModel?.data?.businessDetails?.issuedInCountries)!, issued_in_cities: (viewModel.dataModel?.data?.businessDetails?.issuedInCities)!, branchLicence: viewModel.dataModel?.data?.businessDetails?.branchLicence ?? "", licenceNumber: viewModel.dataModel?.data?.businessDetails?.licenceNumber ?? "", no_of_emp: viewModel.dataModel?.data?.businessDetails?.noOfEmp ?? "", serviceCategories: self.viewModel.dataModel?.data?.serviceCategories.map({$0.id ?? ""}) ?? [], serviceSubCate: self.viewModel.dataModel?.data?.serviceSubcategories.map({$0.id ?? ""}) ?? [], newCategories: [[:]], serviceCountry: (viewModel.dataModel?.data?.serviceDetails?.serviceCountry)!, serviceCity: (viewModel.dataModel?.data?.serviceDetails?.serviceCity)!, serviceCost: viewModel.dataModel?.data?.serviceDetails?.serviceCost ?? "") { (isSuccess, message) in
                if isSuccess {

                    self.view.makeToast("Profile Edit Successfully")

                    self.navigationController?.popViewController(animated: true)

                } else {

                    self.view.makeToast(message)

                }
            }
        }else{
            
            var certificateAndRewardArray : [[String : String]] = [[:]]

            for i in 0..<(branchVM.getBranchDetails()?.branchCertificates!.count)! {

                if let iii = branchVM.getBranchDetails()?.branchCertificates![i].image, let ddd = branchVM.getBranchDetails()?.branchCertificates![i].date {

                    certificateAndRewardArray.insert(["image" : iii, "date" : ddd], at: i)

                }

            }
            
            editProfileVm.apiEditBranch(branchId: self.branchId, FirstName: self.branchVM.getBranchDetails()?.firstName ?? "" , LastName: self.branchVM.getBranchDetails()?.lastName ?? "", Email: self.branchVM.getBranchDetails()?.email ?? "", branchNameEn: self.branchVM.getBranchDetails()?.branchNameEn ?? "", branchNameAr: self.branchVM.getBranchDetails()?.branchNameAr ?? "", branchTypeId: branchVM.getBranchDetails()?.branchTypeID?.brandTypeID ?? "" , branchCategoryId: branchVM.getBranchDetails()?.branchCategoryID?.id ?? "", branchBrief: self.branchVM.getBranchDetails()?.branchBrief ?? "", branchProfile: self.dataContact.branchProfile ?? "", branchLogo: self.dataContact.logo ?? "", certificateAward: certificateAndRewardArray,   country: self.branchVM.getBranchDetails()?.addressDetails?.first?.country ?? "", country_ph_code: self.branchVM.getBranchDetails()?.addressDetails?.first?.countryPhCode ?? "", phoneNumber: self.branchVM.getBranchDetails()?.addressDetails?.first?.phoneNumber ?? "", addFirstName: self.branchVM.getBranchDetails()?.addressDetails?.first?.addrFirstName ?? "", addLastName: self.branchVM.getBranchDetails()?.addressDetails?.first?.addrLastName ?? "", addLine1: self.branchVM.getBranchDetails()?.addressDetails?.first?.addressLine1 ?? "", addLine2: self.branchVM.getBranchDetails()?.addressDetails?.first?.addressLine2 ?? "", pincode: String(self.branchVM.getBranchDetails()?.addressDetails?.first?.pincode ?? 0), landmark: self.branchVM.getBranchDetails()?.addressDetails?.first?.landmark ?? "", state: self.branchVM.getBranchDetails()?.addressDetails?.first?.state ?? "", city: self.branchVM.getBranchDetails()?.addressDetails?.first?.city ?? "", co_ordinator_eng: self.nameInEnglish.text ?? "", co_ordinator_arabic: self.nameInArabic.text ?? "", branchEmail: self.branchEmail.text ?? "", branchWebsite: self.branchWebsite.text ?? "", countryCode: self.countryCode, businessCountryCode: self.businessCountryCode, mobileNumber: self.mobileNumber.text ?? "", businessMobileNumber: self.businessMobileNumbe.text ?? "", instaAccount: self.intagram.text ?? "", youtubeAccount: self.youtube.text ?? "", branchYear: self.branchVM.getBranchDetails()?.businessDetails?.branchYear ?? 0, issued_in_countries: (branchVM.getBranchDetails()?.businessDetails?.issuedInCountries)!, issued_in_cities: (branchVM.getBranchDetails()?.businessDetails?.issuedInCities)!, branchLicence: (branchVM.getBranchDetails()?.businessDetails?.branchLicence ?? ""), licenceNumber: (branchVM.getBranchDetails()?.businessDetails?.licenceNumber ?? ""), no_of_emp: (branchVM.getBranchDetails()?.businessDetails?.noOfEmp ?? ""), serviceCategories: branchVM.getBranchDetails()?.serviceCategories?.map({$0.id ?? ""}) ?? [], serviceSubCate: branchVM.getBranchDetails()?.serviceSubcategories?.map({$0.id ?? ""}) ?? [], newCategories: [[:]], serviceCountry: (self.branchVM.getBranchDetails()?.serviceDetails?.serviceCountry)!, serviceCity: (self.branchVM.getBranchDetails()?.serviceDetails?.serviceCity)!, serviceCost: self.branchVM.getBranchDetails()?.serviceDetails?.serviceCost ?? "") { (isSuccess, message) in
                if isSuccess {

                    self.view.makeToast("Profile Edit Successfully")

                    self.navigationController?.popViewController(animated: true)

                } else {

                    self.view.makeToast(message)

                }
            }
        }
        
    }
}
