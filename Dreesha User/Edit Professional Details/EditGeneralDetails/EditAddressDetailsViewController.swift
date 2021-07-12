//
//  EditAddressDetailsViewController.swift
//  Dreesha User
//
//  Created by promatics on 22/04/21.
//

import UIKit
import CountryPickerView
class EditAddressDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var pincodeView: SkyFloatingLabelTextField!
    @IBOutlet weak var addressLine1: SkyFloatingLabelTextField!
    @IBOutlet weak var addressLine2: SkyFloatingLabelTextField!
    @IBOutlet weak var landmarkView: SkyFloatingLabelTextField!
    @IBOutlet weak var cityView: SkyFloatingLabelTextField!
    @IBOutlet weak var stateView: SkyFloatingLabelTextField!
    @IBOutlet weak var profileImageView: SetImage!
    @IBOutlet weak var profileImgBtn: SetButton!
    @IBOutlet weak var ProfileLogoImage: SetImage!
    @IBOutlet weak var addressFirstName: SkyFloatingLabelTextField!
    @IBOutlet weak var addressLastName: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneNumberTextfld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var phoneCode: CountryPickerView!
   
    var dataAddress = ProfessionalSignUpdata()
    var viewModelA = SignupViewModel()
    var editProfileVm = EditDetailsViewModel()
    
    var viewModel = PersonalInfoViewModel()
    var isEdit: Bool! = false
    var imagePicker = ImagePickerViewControler()
    var profileImageData = Data()
    var LogoImageData = Data()
    var isProfileImage = false
    var isLogoImage = false
    var branchVM = DetailsOfBranchViewModel()

    
    var branchId = ""
    
    
    let countryPickerView = CountryPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataAddress.certificateAward)
        
    
        
        if isEdit {
            
            let url = URLS.profileImageUrl(viewModel.dataModel?.data?.profileImage ?? "").getDescription()
            profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataAddress.branchProfile = viewModel.dataModel?.data?.profileImage ?? ""
            let urld = URLS.profileImageUrl(viewModel.dataModel?.data?.logoImage ?? "").getDescription()
            ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataAddress.logo = viewModel.dataModel?.data?.logoImage ?? ""
            self.pincodeView.text = String(self.viewModel.dataModel?.data?.professionalAddress?.pincode ?? 0)
            
            self.addressLine1.text = self.viewModel.dataModel?.data?.professionalAddress?.addressLine1 ?? ""
            self.addressLine2.text = self.viewModel.dataModel?.data?.professionalAddress?.addressLine2 ?? ""
            
            self.addressFirstName.text = self.viewModel.dataModel?.data?.professionalAddress?.addrFirstName ?? ""
            
            self.addressLastName.text = self.viewModel.dataModel?.data?.professionalAddress?.addrLastName ?? ""
            
            self.countryNameLbl.text = self.viewModel.dataModel?.data?.professionalAddress?.country ?? ""
            
            self.phoneCode.setCountryByPhoneCode(self.viewModel.dataModel?.data?.professionalAddress?.countryPhCode ?? "")
            
            self.phoneNumberTextfld.text = self.viewModel.dataModel?.data?.professionalAddress?.phoneNumber ?? ""

            
//            self.add.text = self.viewModel.dataModel?.data?.professionalAddress?.houseNo
//            self.areaView.text = self.viewModel.dataModel?.data?.professionalAddress?.area
            self.landmarkView.text = self.viewModel.dataModel?.data?.professionalAddress?.landmark
            self.cityView.text = self.viewModel.dataModel?.data?.professionalAddress?.city
            self.stateView.text = self.viewModel.dataModel?.data?.professionalAddress?.state
        }else{
            let url = URLS.profileImageUrl(branchVM.getBranchDetails()?.branchProfile ?? "").getDescription()
            profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataAddress.branchProfile = branchVM.getBranchDetails()?.branchProfile ?? ""
            let urld = URLS.profileImageUrl(branchVM.getBranchDetails()?.branchLogo ?? "").getDescription()
            ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataAddress.logo = branchVM.getBranchDetails()?.branchLogo ?? ""
            self.pincodeView.text = String(self.branchVM.getBranchDetails()?.addressDetails?.first?.pincode ?? 0)
            
            self.addressLine1.text = self.branchVM.getBranchDetails()?.addressDetails?.first?.addressLine1 ?? ""
            self.addressLine2.text = self.branchVM.getBranchDetails()?.addressDetails?.first?.addressLine2 ?? ""
            
            self.addressFirstName.text = self.branchVM.getBranchDetails()?.addressDetails?.first?.addrFirstName ?? ""
            
            self.addressLastName.text = self.branchVM.getBranchDetails()?.addressDetails?.first?.addrLastName ?? ""
            
            self.countryNameLbl.text = self.branchVM.getBranchDetails()?.addressDetails?.first?.country ?? ""
            
            self.phoneCode.setCountryByPhoneCode(self.branchVM.getBranchDetails()?.addressDetails?.first?.countryPhCode ?? "")
            
            
//            self.houseView.text = self.branchVM.getBranchDetails()?.addressDetails?.first?.houseNo
//            self.areaView.text = self.branchVM.getBranchDetails()?.addressDetails?.first?.area
            self.landmarkView.text = self.branchVM.getBranchDetails()?.addressDetails?.first?.landmark ?? ""
            self.cityView.text = self.branchVM.getBranchDetails()?.addressDetails?.first?.city ?? ""
            self.stateView.text = self.branchVM.getBranchDetails()?.addressDetails?.first?.state ?? ""
        }


    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isEdit{
            setBackWithTitle(titleVal : "Personal Information")
        }else{
            setBackWithTitle(titleVal: "Branch Details")
        }
    }
   
    @IBAction func tapProfileImgBtn(_ sender: Any) {
        self.imagePicker.imagePickerDelegete = self
        isProfileImage = true
        imagePicker.showImagePicker(viewController: self)
    }
    
    @IBAction func tapLogoImageBtn(_ sender: SetButton) {
        self.imagePicker.imagePickerDelegete = self
        isLogoImage = true
        imagePicker.showImagePicker(viewController: self)
    }
    
    
    @IBAction func tapShowCountry(_ sender: Any) {
        countryPickerView.delegate = self
        countryPickerView.showCountriesList(from: self)
    }
    
    
    @IBAction func contactBtn(_ sender: Any) {
    
            if self.countryNameLbl.text == "" {
                self.view.makeToast("Please Select Country")
          } else if self.stateView.text == "" {
                self.view.makeToast("Please Enter State")
            }  else if self.phoneNumberTextfld.text == "" {
                self.view.makeToast("Please Enter Contact number")
            }  else if self.addressFirstName.text == "" {
                self.view.makeToast("Please Enter First Name")
            }  else if self.addressLastName.text == "" {
                self.view.makeToast("Please Enter Last Name")
            }  else if self.addressLine1.text == "" {
                self.view.makeToast("Please Enter Address Line 1")
            }   else if self.addressLine2.text == "" {
                self.view.makeToast("Please Enter Address Line 2")
            }  else if self.cityView.text == "" {
                self.view.makeToast("Please Enter City")
            }  else {
                self.dataAddress.phoneCode = self.phoneCode.selectedCountry.phoneCode
                self.dataAddress.country = self.countryNameLbl.text ?? ""
                self.dataAddress.pincode = pincodeView.text ?? ""
                self.dataAddress.state = stateView.text ?? ""
                self.dataAddress.addFirstName = addressFirstName.text ?? ""
                self.dataAddress.addLastName = addressLastName.text ?? ""
                self.dataAddress.city = cityView.text ?? ""
                self.dataAddress.addressLine1 = addressLine1.text ?? ""
                self.dataAddress.addressLine2 = addressLine2.text ?? ""
                self.dataAddress.landmark = landmarkView.text ?? ""
                
                editAddressDetails()
            }
       
    }
}

//MARK:- Image Picker Delegate

extension EditAddressDetailsViewController : ImagePickerDelegete {
    
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
extension EditAddressDetailsViewController{
    func uploadProfileImage(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModelA.apiUploadProfileImage(imageData: profileImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
            if isSuccess{
                self.dataAddress.branchProfile = (data as? [String : AnyObject])?["data"] as? String ?? ""
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    func uploadLogoImage(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModelA.apiUploadLogoImage(imageData: LogoImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
            if isSuccess{
                self.dataAddress.logo = (data as? [String : AnyObject])?["data"] as? String ?? ""
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    
    func editAddressDetails(){



        if isEdit{

            var certificateAndRewardArray : [[String : String]] = [[:]]

            for i in 0..<(viewModel.dataModel?.data?.certificateAwards!.count)! {

                if let iii = viewModel.dataModel?.data?.certificateAwards![i].image, let ddd = viewModel.dataModel?.data?.certificateAwards![i].date {

                    certificateAndRewardArray.insert(["image" : iii, "date" : ddd], at: i)

                }

            }

            editProfileVm.editProfesstionalProfile(FirstName: (viewModel.dataModel?.data?.firstName ?? ""), LastName: viewModel.dataModel?.data?.lastName ?? "", Email: viewModel.dataModel?.data?.email ?? "", branchNameEn: viewModel.dataModel?.data?.branchNameEn ?? "", branchNameAr: viewModel.dataModel?.data?.branchNameAr ?? "", branchTypeId: (viewModel.dataModel?.data?.branchTypeID ?? ""), branchCategoryId: (viewModel.dataModel?.data?.branchCategoryID ?? ""), branchBrief: viewModel.dataModel?.data?.branchBrief ?? "", certificateAward: certificateAndRewardArray, noOfBranches: String(viewModel.dataModel?.data?.noOfBranches ?? 0), profileImage: self.dataAddress.branchProfile ?? "", LogoImage: self.dataAddress.logo ?? "",country: dataAddress.country ?? "", country_ph_code: dataAddress.phoneCode ?? "", phoneNumber: dataAddress.phoneNumber ?? "", addFirstName: dataAddress.addFirstName ?? "", addLastName: dataAddress.addLastName ?? "", addLine1: dataAddress.addressLine1 ?? "", addLine2: dataAddress.addressLine2 ?? "", pincode: dataAddress.pincode ?? "", landmark: dataAddress.landmark ?? "", state: dataAddress.state ?? "", city: dataAddress.city ?? "", co_ordinator_eng: viewModel.dataModel?.data?.contactDetails?.coOrdinatorEng ?? "", co_ordinator_arabic: viewModel.dataModel?.data?.contactDetails?.coOrdinatorArabic ?? "", branchEmail: viewModel.dataModel?.data?.contactDetails?.branchEmail ?? "", branchWebsite: viewModel.dataModel?.data?.contactDetails?.branchWebsite ?? "", countryCode: viewModel.dataModel?.data?.contactDetails?.countryCode ?? "", businessCountryCode: viewModel.dataModel?.data?.contactDetails?.businessCountryCode ?? "", mobileNumber: viewModel.dataModel?.data?.contactDetails?.mobileNumber ?? "", businessMobileNumber: viewModel.dataModel?.data?.contactDetails?.businessMobileNumber ?? "", instaAccount: viewModel.dataModel?.data?.contactDetails?.instaAcc ?? "", youtubeAccount: viewModel.dataModel?.data?.contactDetails?.youtubeChannel ?? "", branchYear: (viewModel.dataModel?.data?.businessDetails?.branchYear ?? 0), issued_in_countries: (viewModel.dataModel?.data?.businessDetails?.issuedInCountries)!, issued_in_cities: (viewModel.dataModel?.data?.businessDetails?.issuedInCities)!, branchLicence: viewModel.dataModel?.data?.businessDetails?.branchLicence ?? "", licenceNumber: viewModel.dataModel?.data?.businessDetails?.licenceNumber ?? "", no_of_emp: viewModel.dataModel?.data?.businessDetails?.noOfEmp ?? "", serviceCategories: self.viewModel.dataModel?.data?.serviceCategories.map({$0.id ?? ""}) ?? [], serviceSubCate: self.viewModel.dataModel?.data?.serviceSubcategories.map({$0.id ?? ""}) ?? [], newCategories: [[:]], serviceCountry: (viewModel.dataModel?.data?.serviceDetails?.serviceCountry)!, serviceCity: (viewModel.dataModel?.data?.serviceDetails?.serviceCity)!, serviceCost: viewModel.dataModel?.data?.serviceDetails?.serviceCost ?? "") { (isSuccess, message) in
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

            editProfileVm.apiEditBranch(branchId: self.branchId, FirstName: self.branchVM.getBranchDetails()?.firstName ?? "" , LastName: self.branchVM.getBranchDetails()?.lastName ?? "", Email: self.branchVM.getBranchDetails()?.email ?? "", branchNameEn: self.branchVM.getBranchDetails()?.branchNameEn ?? "", branchNameAr: self.branchVM.getBranchDetails()?.branchNameAr ?? "", branchTypeId: branchVM.getBranchDetails()?.branchTypeID?.brandTypeID ?? "" , branchCategoryId: branchVM.getBranchDetails()?.branchCategoryID?.id ?? "", branchBrief: self.branchVM.getBranchDetails()?.branchBrief ?? "", branchProfile: self.dataAddress.branchProfile ?? "", branchLogo: self.dataAddress.logo ?? "", certificateAward: certificateAndRewardArray,  country: dataAddress.country ?? "", country_ph_code: dataAddress.phoneCode ?? "", phoneNumber: dataAddress.phoneNumber ?? "", addFirstName: dataAddress.addFirstName ?? "", addLastName: dataAddress.addLastName ?? "", addLine1: dataAddress.addressLine1 ?? "", addLine2: dataAddress.addressLine2 ?? "", pincode: dataAddress.pincode ?? "", landmark: dataAddress.landmark ?? "", state: dataAddress.state ?? "", city: dataAddress.city ?? "", co_ordinator_eng: self.branchVM.getBranchDetails()?.contactDetails?.coOrdinatorEng ?? "", co_ordinator_arabic: self.branchVM.getBranchDetails()?.contactDetails?.coOrdinatorArabic ?? "", branchEmail: self.branchVM.getBranchDetails()?.contactDetails?.branchEmail ?? "", branchWebsite: self.branchVM.getBranchDetails()?.contactDetails?.branchWebsite ?? "", countryCode: self.branchVM.getBranchDetails()?.contactDetails?.countryCode ?? "", businessCountryCode: self.branchVM.getBranchDetails()?.contactDetails?.businessCountryCode ?? "", mobileNumber: self.branchVM.getBranchDetails()?.contactDetails?.mobileNumber ?? "", businessMobileNumber: self.branchVM.getBranchDetails()?.contactDetails?.businessMobileNumber ?? "", instaAccount: self.branchVM.getBranchDetails()?.contactDetails?.instaAcc ?? "", youtubeAccount: self.branchVM.getBranchDetails()?.contactDetails?.youtubeChannel ?? "", branchYear: self.branchVM.getBranchDetails()?.businessDetails?.branchYear ?? 0, issued_in_countries: (branchVM.getBranchDetails()?.businessDetails?.issuedInCountries)!, issued_in_cities: (branchVM.getBranchDetails()?.businessDetails?.issuedInCities)!, branchLicence: (branchVM.getBranchDetails()?.businessDetails?.branchLicence ?? ""), licenceNumber: (branchVM.getBranchDetails()?.businessDetails?.licenceNumber ?? ""), no_of_emp: (branchVM.getBranchDetails()?.businessDetails?.noOfEmp ?? ""), serviceCategories: branchVM.getBranchDetails()?.serviceCategories?.map({$0.id ?? ""}) ?? [], serviceSubCate: branchVM.getBranchDetails()?.serviceSubcategories?.map({$0.id ?? ""}) ?? [], newCategories: [[:]], serviceCountry: (self.branchVM.getBranchDetails()?.serviceDetails?.serviceCountry)!, serviceCity: (self.branchVM.getBranchDetails()?.serviceDetails?.serviceCity)!, serviceCost: self.branchVM.getBranchDetails()?.serviceDetails?.serviceCost ?? "") { (isSuccess, message) in
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

//MARK:- Country Picker delegates
extension EditAddressDetailsViewController : CountryPickerViewDelegate{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.countryNameLbl.text = country.name
    }
    
    
}
