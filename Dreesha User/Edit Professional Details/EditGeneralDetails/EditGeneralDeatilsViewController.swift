//
//  EditGeneralDeatilsViewController.swift
//  Dreesha User
//
//  Created by promatics on 22/04/21.
//

import UIKit
import SBCardPopup

class EditGeneralDeatilsViewController: UIViewController , TypeAndCategoryList , SelectDate {
    
    
    func listData(name: String, ListType: String, id: String?){
        
    }

    func onDate(date: String) {
        if dateArray.indices.contains(selectedCell) {
            dateArray[selectedCell] = date
        } else {
            dateArray.append(date)
        }
        tableView.reloadData()
    }
    
    
    func listData(name: String, isType: Bool, id: String?) {
        if isType {
            lowerBranchType.text = name
            lowerBranchType.alpha = 1.0
            upperBranchType.isHidden = false
            typeId = id
            categoryNameArray.removeAll()
            categoryidNameArray.removeAll()
            categoryId = ""
            branchCategory(id: id!)
            if lowerBranchCategory.text != "Company Category" {
                lowerBranchCategory.text = ""
            }
            
        } else {
            print(id as Any)
            categoryId = id
            upperBranchCategory.isHidden = false
            lowerBranchCategory.alpha = 1.0
            lowerBranchCategory.text = name
        }
    }
    
    @IBOutlet weak var firstNameView: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameView: SkyFloatingLabelTextField!
    @IBOutlet weak var emailView: SkyFloatingLabelTextField!
    @IBOutlet weak var branchNameEnglishView: SkyFloatingLabelTextField!
    @IBOutlet weak var branchNameArabicView: SkyFloatingLabelTextField!
    @IBOutlet weak var branchDescriptionView: SkyFloatingLabelTextField!
    
    @IBOutlet weak var upperBranchType: UILabel!
    @IBOutlet weak var lowerBranchType: UILabel!
    
    @IBOutlet weak var lowerBranchCategory: UILabel!
    @IBOutlet weak var upperBranchCategory: UILabel!
    
    @IBOutlet weak var profileImageView: SetImage!
    @IBOutlet weak var ProfileLogoImage: SetImage!
    
    @IBOutlet weak var profileImgBtn: SetButton!
    @IBOutlet weak var bottomTableHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    var typeNameArray: [String] = []
    var typeidNameArray: [String] = []
    var categoryNameArray: [String] = []
    var categoryidNameArray: [String] = []
    var typeId: String!
    var categoryId: String!
    
    
    var dateArray : [String] = []
    var certificateArray : [UIImage] = []
    var certificateCount = 1
    var selectedCell = 0
    var certificateDataArray : [String] = []
    var certificateAndRewardArray : [[String : String]] = [[:]]
    
    
    var imageData = Data()
    var imagePicker = ImagePickerViewControler()
    
    var shownImage : UIImage!
    
    var passClick = true
    var confirmClick = true


    var dataGeneral = ProfessionalSignUpdata()
    
    var viewModel = SignupViewModel()
    var typeModel = BranchTypeAndCategoryViewModel()
    
    var editProfileVm = EditDetailsViewModel()
    
    var viewModelP = PersonalInfoViewModel()
    var branchVM = DetailsOfBranchViewModel()
    var isEdit: Bool! = false
    
    
    var profileImageData = Data()
    var LogoImageData = Data()
    var isProfileImage = false
    var isLogoImage = false
    
    var branchTypeVal = ""
    var branchCat = ""
    
    var branchId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        branchType()
        if isEdit {
            setBackWithTitle(titleVal: "Personal Information")
            let url = URLS.profileImageUrl(viewModelP.dataModel?.data?.profileImage ?? "").getDescription()
            profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataGeneral.branchProfile = viewModelP.dataModel?.data?.profileImage ?? ""
            let urls = URLS.profileImageUrl(viewModelP.dataModel?.data?.logoImage ?? "").getDescription()
            ProfileLogoImage.sd_setImage(with: URL(string: urls), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataGeneral.logo = viewModelP.dataModel?.data?.logoImage ?? ""
            firstNameView.text = viewModelP.dataModel?.data?.firstName
            lastNameView.text = viewModelP.dataModel?.data?.lastName
            emailView.text = viewModelP.dataModel?.data?.email
           
            branchNameEnglishView.text = viewModelP.dataModel?.data?.branchNameEn
            branchNameArabicView.text = viewModelP.dataModel?.data?.branchNameAr
            branchDescriptionView.text = viewModelP.dataModel?.data?.branchBrief
            lowerBranchType.alpha = 1.0
            lowerBranchCategory.alpha = 1.0
            lowerBranchType.text = branchTypeVal
            lowerBranchCategory.text = branchCat
            
            dateArray.append(contentsOf: viewModelP.dataModel?.data?.certificateAwards?.map({$0.date ?? ""}) ?? [])
            
            let imageArr = viewModelP.dataModel?.data?.certificateAwards?.map({$0.image ?? ""}) ?? []
            
            for i in imageArr{
                let image = UIImageView()
                let url = URLS.certificateImageUrl(i).getDescription()
                image.sd_setImage(with: URL(string : url), placeholderImage: #imageLiteral(resourceName: "Placehold"))
                certificateArray.append(image.image ?? UIImage())
            }
            
            
            
        }else{
            setBackWithTitle(titleVal: "Branch Details")
            let url = URLS.profileImageUrl(branchVM.getBranchDetails()?.branchProfile ?? "").getDescription()
            profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataGeneral.branchProfile = branchVM.getBranchDetails()?.branchProfile ?? ""
            let urls = URLS.profileImageUrl(branchVM.getBranchDetails()?.branchLogo ?? "").getDescription()
            ProfileLogoImage.sd_setImage(with: URL(string: urls), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataGeneral.logo = branchVM.getBranchDetails()?.branchLogo ?? ""
            firstNameView.text = branchVM.getBranchDetails()?.firstName ?? ""
            lastNameView.text = branchVM.getBranchDetails()?.lastName ?? ""
            emailView.text = branchVM.getBranchDetails()?.email ?? ""
           
            branchNameEnglishView.text = branchVM.getBranchDetails()?.branchNameEn ?? ""
            branchNameArabicView.text = branchVM.getBranchDetails()?.branchNameAr ?? ""
            branchDescriptionView.text = branchVM.getBranchDetails()?.branchBrief ?? ""
            lowerBranchType.alpha = 1.0
            lowerBranchCategory.alpha = 1.0
            lowerBranchType.text = branchTypeVal
            lowerBranchCategory.text = branchCat
            
            self.dataGeneral.branchProfile = branchVM.getBranchDetails()?.branchProfile ?? ""
            self.dataGeneral.logo = branchVM.getBranchDetails()?.branchLogo ?? ""
            
            dateArray.append(contentsOf: branchVM.getBranchDetails()?.branchCertificates?.map({$0.date ?? ""}) ?? [])
            
            let imageArr = branchVM.getBranchDetails()?.branchCertificates?.map({$0.image ?? ""}) ?? []
            
            for i in imageArr{
                let image = UIImageView()
                let url = URLS.certificateImageUrl(i).getDescription()
                image.sd_setImage(with: URL(string : url), placeholderImage: #imageLiteral(resourceName: "Placehold"))
                certificateArray.append(image.image ?? UIImage())
            }
        }
       
       
    }
 
    
    
    
    
    @IBAction func branchTypeBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(withIdentifier: "BranchTypeAndCategoryPopUpViewController") as! BranchTypeAndCategoryPopUpViewController
        vc.isType = true
        vc.delegate = self
        vc.name = typeNameArray
        vc.id = typeidNameArray
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    
    @IBAction func branchCategoryBtn(_ sender: Any) {
        if categoryNameArray.isEmpty {
            self.view.makeToast("No category found.")
        } else {
            let vc = UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(withIdentifier: "BranchTypeAndCategoryPopUpViewController") as! BranchTypeAndCategoryPopUpViewController
            vc.isType = false
            vc.delegate = self
            vc.name = categoryNameArray
            vc.id = categoryidNameArray
            let cardPopup = SBCardPopupViewController(contentViewController: vc)
            cardPopup.show(onViewController: self)
        }
    }
    
    @IBAction func tapProfileImgBtn(_ sender: Any) {
        isLogoImage = false
        self.imagePicker.imagePickerDelegete = self
        isProfileImage = true
        imagePicker.showImagePicker(viewController: self)
    }
    @IBAction func tapLogoImageBtn(_ sender: SetButton) {
        isProfileImage = false
        self.imagePicker.imagePickerDelegete = self
        isLogoImage = true
        imagePicker.showImagePicker(viewController: self)
        
    }
    
    
    @IBAction func tapSaveDetails(_ sender: Any) {
        
       
            
        if (self.dataGeneral.branchProfile ?? "" == "") && !(isEdit){
               self.view.makeToast("Please upload profile image")
           }
           else if self.firstNameView.text == "" {
               self.view.makeToast("Please Enter First Name")
           } else if self.lastNameView.text == "" {
               self.view.makeToast("Please Enter Last Name")
           }  else if self.emailView.text == "" {
               self.view.makeToast("Please Enter Email")
           }  else if !(self.emailView.text?.isValidEmail() ?? false) {
               self.view.makeToast("Please Enter valid email")
           }    else if self.branchNameEnglishView.text == "" {
               self.view.makeToast("Please Enter Company Name")
           }  else if self.branchNameArabicView.text == "" {
               self.view.makeToast("Please Enter Company Name in Arabic Only")
           }  else if !(Validation().validOnlyArabic(arabicTextField: self.branchNameArabicView.text ?? "")){
                self.view.makeToast("Enter Arabic Language Only")
           }  else if lowerBranchType.text == "Company Type" {
               self.view.makeToast("Please Select Company Type")
           }  else if lowerBranchCategory.text == "Company Category" || lowerBranchCategory.text == "" {
               self.view.makeToast("Please Select Company Category")
           }  else if self.branchDescriptionView.text == "" {
               self.view.makeToast("Please Enter Company Description")
           }  else if certificateArray.isEmpty || dateArray.isEmpty {
              self.view.makeToast("Please Select Certificate & Reward")
            
           } else if certificateDataArray.count == dateArray.count {
           
               for i in 0..<certificateDataArray.count {
                   if certificateAndRewardArray.indices.contains(i) {
                       certificateAndRewardArray[i] = ["image" : certificateDataArray[i], "date" : dateArray[i]]
                   } else {
                       certificateAndRewardArray.insert(["image" : certificateDataArray[i], "date" : dateArray[i]], at: i)
                   }
               }

               self.dataGeneral.certificateAward = certificateAndRewardArray
               print(self.dataGeneral.certificateAward)
            
            if isEdit{
                editGeneralDetails()
            }else{
                //editBranchGeneralDetails()
            }

              


           } else {

              

               for i in 0..<certificateDataArray.count {
                   if certificateAndRewardArray.indices.contains(i) {
                       certificateAndRewardArray[i] = ["image" : certificateDataArray[i], "date" : dateArray[i]]
                   } else {
                       certificateAndRewardArray.insert(["image" : certificateDataArray[i], "date" : dateArray[i]], at: i)
                   }
               }

               self.dataGeneral.certificateAward = self.certificateAndRewardArray

            if self.isEdit{
                self.editGeneralDetails()
            }else{
               // self.editBranchGeneralDetails()
            }
               print(self.dataGeneral.certificateAward)
           }
       
        
        
    }
    

 

}

//MARK:- Image Picker Delegate

extension EditGeneralDeatilsViewController : ImagePickerDelegete {
    
    func disFinishPicking(imgData: Data, img: UIImage) {
        
       
        
        
        if isProfileImage{
            profileImageData = img.jpegData(compressionQuality: 0.6)!
            self.profileImageView.image = img
            uploadProfileImage()
        }else if isLogoImage{
            LogoImageData = img.jpegData(compressionQuality: 0.6)!
            self.ProfileLogoImage.image = img
            uploadLogoImage()
//            isLogoImage = false
        }
        else{
            
            print(self.certificateDataArray.count)
            
            imageData = img.jpegData(compressionQuality: 0.6)!
            uploadImage()
            self.shownImage = img
        }
        

    }
    
    
    func showPic() {
        if self.certificateArray.indices.contains(selectedCell) {
            self.certificateArray[selectedCell] = self.shownImage
        } else {
            self.certificateArray.append(self.shownImage)
        }
        print(self.certificateDataArray)
        tableView.reloadData()
    }
    

    
    
}


//MARK:- Table View Delegates

extension EditGeneralDeatilsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return certificateCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CertificateCell

        indexPath.row == 0 ? cell.addBtnOutlet.setImage(UIImage(named: "plus 6"), for: .normal) : cell.addBtnOutlet.setImage(UIImage(named: "minus-bt"), for: .normal)
        
        cell.dateLabel.text = "Choose Date"
        cell.dateLabel.alpha = 0.3
        cell.imageBtnOutlet.setImage(UIImage(named: "cloud-computing 1"), for: .normal)
        
        if dateArray.indices.contains(indexPath.row) {
            cell.dateLabel.text = dateArray[indexPath.row]
            cell.dateLabel.alpha = 1.0
        }
        
        if certificateArray.indices.contains(indexPath.row) {
            cell.imageBtnOutlet.setImage(certificateArray[indexPath.row], for: .normal)
        }
        
        cell.onAdd = {
            self.selectedCell = indexPath.row
            
            if indexPath.row == 0 {
                if self.certificateArray.count != self.certificateCount {
                    self.view.makeToast("Please Select Certificate & Reward")
                    return
                } else if self.dateArray.count != self.certificateCount {
                    self.view.makeToast("Please Select Date")
                    return
                }
                self.certificateCount += 1
                tableView.reloadData()
//                self.viewHeightConstraint.constant = CGFloat((1263 + (53 * self.certificateCount)))
                self.bottomTableHeight.constant = CGFloat((53 * self.certificateCount))
            } else {
                if self.certificateCount > 1 {
                    self.certificateCount -= 1
                    
                    if self.dateArray.indices.contains(self.selectedCell) {
                        self.dateArray.remove(at: self.selectedCell)
                    }
                    if self.certificateArray.indices.contains(self.selectedCell) {
                        self.certificateArray.remove(at: self.selectedCell)
                    }
                    if self.certificateDataArray.indices.contains(self.selectedCell) {
                        self.certificateDataArray.remove(at: self.selectedCell)
                    }
                    
                    self.certificateAndRewardArray.removeAll()
                    
                    tableView.reloadData()
                    //self.viewHeightConstraint.constant = CGFloat((1263 + (53 * self.certificateCount)))
                    
                    self.bottomTableHeight.constant = CGFloat((53 * self.certificateCount))
                }
            }
        }
                
        cell.onCalender = {
            self.selectedCell = indexPath.row
            let vc = UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(identifier: "CalenderPopUpViewController") as! CalenderPopUpViewController
            vc.delegate = self
            let card = SBCardPopupViewController(contentViewController: vc)
            card.show(onViewController: self)
        }

        cell.onImage = {
            self.selectedCell = indexPath.row
            self.imagePicker.imagePickerDelegete = self
            self.isProfileImage = false
            self.isLogoImage = false
            self.imagePicker.showImagePicker(viewController: self)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


//MARK:- API CALL
extension EditGeneralDeatilsViewController{
    func branchType() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        typeModel.hitBranchType { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            print(message)
            if isSuccess {
                self.typeNameArray = (self.typeModel.typeModelData?.data?.map({$0.name ?? ""}))!
                self.typeidNameArray = (self.typeModel.typeModelData?.data?.map({$0.id ?? ""}))!
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    func branchCategory(id: String) {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        typeModel.hitBranchCategory(typeId: id) { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess {
                self.categoryNameArray = (self.typeModel.categoryModel?.data?.map({$0.name ?? ""}))!
                self.categoryidNameArray = (self.typeModel.categoryModel?.data?.map({$0.id ?? ""}))!
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    func uploadImage() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitUploadImage(imageData: imageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message) in
            if isSuccess {
                if self.certificateDataArray.indices.contains(self.selectedCell) {
                    self.certificateDataArray[self.selectedCell] = (self.viewModel.imageData?.data)!
                } else {
                    self.certificateDataArray.append((self.viewModel.imageData?.data)!)
                }
                self.showPic()
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    func uploadProfileImage(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiUploadProfileImage(imageData: profileImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
            if isSuccess{
                self.dataGeneral.branchProfile = (data as? [String : AnyObject])?["data"] as? String ?? ""
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    func uploadLogoImage(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiUploadLogoImage(imageData: LogoImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
            if isSuccess{
                self.dataGeneral.logo = (data as? [String : AnyObject])?["data"] as? String ?? ""
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    
    func editGeneralDetails(){
        
        editProfileVm.editProfesstionalProfile(FirstName: firstNameView.text ?? "", LastName: lastNameView.text ?? "", Email: emailView.text ?? "", branchNameEn: branchNameEnglishView.text ?? "", branchNameAr: branchNameArabicView.text ?? "", branchTypeId: typeId ?? viewModelP.dataModel?.data?.branchTypeID ?? "", branchCategoryId: categoryId ?? viewModelP.dataModel?.data?.branchCategoryID ?? "", branchBrief: branchDescriptionView.text ?? "", certificateAward: certificateAndRewardArray, noOfBranches: String(viewModelP.dataModel?.data?.noOfBranches ?? 0), profileImage: self.dataGeneral.branchProfile ?? "", LogoImage: self.dataGeneral.logo ?? "", country: self.viewModelP.dataModel?.data?.professionalAddress?.country ?? "", country_ph_code: self.viewModelP.dataModel?.data?.professionalAddress?.countryPhCode ?? "", phoneNumber: self.viewModelP.dataModel?.data?.professionalAddress?.phoneNumber ?? "", addFirstName: self.viewModelP.dataModel?.data?.professionalAddress?.addrFirstName ?? "", addLastName: self.viewModelP.dataModel?.data?.professionalAddress?.addrLastName ?? "", addLine1: self.viewModelP.dataModel?.data?.professionalAddress?.addressLine1 ?? "", addLine2: self.viewModelP.dataModel?.data?.professionalAddress?.addressLine2 ?? "", pincode: String(self.viewModelP.dataModel?.data?.professionalAddress?.pincode ?? 0), landmark: self.viewModelP.dataModel?.data?.professionalAddress?.landmark ?? "", state: self.viewModelP.dataModel?.data?.professionalAddress?.state ?? "", city: self.viewModelP.dataModel?.data?.professionalAddress?.city ?? "",co_ordinator_eng: viewModelP.dataModel?.data?.contactDetails?.coOrdinatorEng ?? "", co_ordinator_arabic: viewModelP.dataModel?.data?.contactDetails?.coOrdinatorArabic ?? "", branchEmail: viewModelP.dataModel?.data?.contactDetails?.branchEmail ?? "", branchWebsite: viewModelP.dataModel?.data?.contactDetails?.branchWebsite ?? "", countryCode: viewModelP.dataModel?.data?.contactDetails?.countryCode ?? "", businessCountryCode: viewModelP.dataModel?.data?.contactDetails?.businessCountryCode ?? "", mobileNumber: viewModelP.dataModel?.data?.contactDetails?.mobileNumber ?? "", businessMobileNumber: viewModelP.dataModel?.data?.contactDetails?.businessMobileNumber ?? "", instaAccount: viewModelP.dataModel?.data?.contactDetails?.instaAcc ?? "", youtubeAccount: viewModelP.dataModel?.data?.contactDetails?.youtubeChannel ?? "", branchYear: (viewModelP.dataModel?.data?.businessDetails?.branchYear ?? 0), issued_in_countries: (viewModelP.dataModel?.data?.businessDetails?.issuedInCountries)!, issued_in_cities: (viewModelP.dataModel?.data?.businessDetails?.issuedInCities)!, branchLicence: viewModelP.dataModel?.data?.businessDetails?.branchLicence ?? "", licenceNumber: viewModelP.dataModel?.data?.businessDetails?.licenceNumber ?? "", no_of_emp: viewModelP.dataModel?.data?.businessDetails?.noOfEmp ?? "", serviceCategories: self.viewModelP.dataModel?.data?.serviceCategories.map({$0.id ?? ""}) ?? [], serviceSubCate: self.viewModelP.dataModel?.data?.serviceSubcategories.map({$0.id ?? ""}) ?? [], newCategories: [[:]], serviceCountry: (viewModelP.dataModel?.data?.serviceDetails?.serviceCountry)!, serviceCity: (viewModelP.dataModel?.data?.serviceDetails?.serviceCity)!, serviceCost: viewModelP.dataModel?.data?.serviceDetails?.serviceCost ?? "") { (isSuccess, message) in
            if isSuccess {

                self.view.makeToast("Profile Edit Successfully")

                self.navigationController?.popViewController(animated: true)

            } else {

                self.view.makeToast(message)

            }
        }
        

    }
    
    
    
    
    func editBranchGeneralDetails(){
        
        editProfileVm.apiEditBranch(branchId: self.branchId,FirstName: firstNameView.text ?? "", LastName: lastNameView.text ?? "", Email: emailView.text ?? "", branchNameEn: branchNameEnglishView.text ?? "", branchNameAr: branchNameArabicView.text ?? "", branchTypeId: typeId ?? branchVM.getBranchDetails()?.branchTypeID?.brandTypeID ?? "", branchCategoryId: categoryId ?? branchVM.getBranchDetails()?.branchCategoryID?.brandTypeID ?? "", branchBrief: branchDescriptionView.text ?? "", branchProfile: self.dataGeneral.branchProfile ?? "", branchLogo: self.dataGeneral.logo ?? "", certificateAward: certificateAndRewardArray, country: self.branchVM.getBranchDetails()?.addressDetails?.first?.country ?? "", country_ph_code: self.branchVM.getBranchDetails()?.addressDetails?.first?.countryPhCode ?? "", phoneNumber: self.branchVM.getBranchDetails()?.addressDetails?.first?.phoneNumber ?? "", addFirstName: self.branchVM.getBranchDetails()?.addressDetails?.first?.addrFirstName ?? "", addLastName: self.branchVM.getBranchDetails()?.addressDetails?.first?.addrLastName ?? "", addLine1: self.branchVM.getBranchDetails()?.addressDetails?.first?.addressLine1 ?? "", addLine2: self.branchVM.getBranchDetails()?.addressDetails?.first?.addressLine2 ?? "", pincode: String(self.branchVM.getBranchDetails()?.addressDetails?.first?.pincode ?? 0), landmark: self.branchVM.getBranchDetails()?.addressDetails?.first?.landmark ?? "", state: self.branchVM.getBranchDetails()?.addressDetails?.first?.state ?? "", city: self.branchVM.getBranchDetails()?.addressDetails?.first?.city ?? "",co_ordinator_eng: self.branchVM.getBranchDetails()?.contactDetails?.coOrdinatorEng ?? "", co_ordinator_arabic: self.branchVM.getBranchDetails()?.contactDetails?.coOrdinatorArabic ?? "", branchEmail: self.branchVM.getBranchDetails()?.contactDetails?.branchEmail ?? "", branchWebsite: self.branchVM.getBranchDetails()?.contactDetails?.branchWebsite ?? "", countryCode: self.branchVM.getBranchDetails()?.contactDetails?.countryCode ?? "", businessCountryCode: self.branchVM.getBranchDetails()?.contactDetails?.businessCountryCode ?? "", mobileNumber: self.branchVM.getBranchDetails()?.contactDetails?.mobileNumber ?? "", businessMobileNumber: self.branchVM.getBranchDetails()?.contactDetails?.businessMobileNumber ?? "", instaAccount: self.branchVM.getBranchDetails()?.contactDetails?.instaAcc ?? "", youtubeAccount: self.branchVM.getBranchDetails()?.contactDetails?.youtubeChannel ?? "", branchYear: self.branchVM.getBranchDetails()?.businessDetails?.branchYear ?? 0, issued_in_countries: (self.branchVM.getBranchDetails()?.businessDetails?.issuedInCountries)!, issued_in_cities: (self.branchVM.getBranchDetails()?.businessDetails?.issuedInCities)!, branchLicence: self.branchVM.getBranchDetails()?.businessDetails?.branchLicence ?? "", licenceNumber: self.branchVM.getBranchDetails()?.businessDetails?.licenceNumber ?? "", no_of_emp: self.branchVM.getBranchDetails()?.businessDetails?.noOfEmp ?? "", serviceCategories: branchVM.getBranchDetails()?.serviceCategories?.map({$0.id ?? ""}) ?? [], serviceSubCate: branchVM.getBranchDetails()?.serviceSubcategories?.map({$0.id ?? ""}) ?? [], newCategories: [[:]], serviceCountry: (self.branchVM.getBranchDetails()?.serviceDetails?.serviceCountry)!, serviceCity: (self.branchVM.getBranchDetails()?.serviceDetails?.serviceCity)!, serviceCost: self.branchVM.getBranchDetails()?.serviceDetails?.serviceCost ?? "") { (isSuccess, message) in
            if isSuccess{

                    self.navigationController?.popViewController(animated: true)

                } else {

                    self.view.makeToast(message)

                }

        }
        
    
    }
}
extension String {
 var isPersian: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@",
                                    "([-.]*\\s*[-.]*\\p{Arabic}*[-.]*\\s*)*[-.]*")
        return predicate.evaluate(with: self)
    }

}
