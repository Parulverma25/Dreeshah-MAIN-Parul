//
//  EditBuisnessDetailsViewController.swift
//  Dreesha User
//
//  Created by Admin on 22/04/21.
//

import UIKit
import SBCardPopup

class EditBuisnessDetailsViewController: UIViewController,CountryList,Year {
    
    func getYearValue(year: String) {
        print(year)
        lowerYearLabel.text = year
        upperYearLabel.isHidden = false
        lowerYearLabel.alpha = 1.0
    }
    
    
    func countries(name: [String], isCity: Bool, code: [String]) {
        if !isCity {
            if name.count > 0 {
                self.countryName.append(contentsOf: name)
                collectionView.reloadData()
                collectionView.isHidden = false
                countryLabel.isHidden = false
                countryHighlightLabel.isHidden = true
                print(code)
                selectedCode = code
                self.city(countryCode: selectedCode)
                //self.cityName.removeAll()
                cityCollectionView.reloadData()
            } else {
//                collectionView.isHidden = true
//                countryLabel.isHidden = true
//                countryHighlightLabel.isHidden = false
            }
        } else {
            if name.count > 0 {
                self.cityName.append(contentsOf: name)
                cityCollectionView.reloadData()
                cityCollectionView.isHidden = false
                cityLabel.isHidden = false
                cityHighlightLabel.isHidden = true
            } else {
//                cityCollectionView.isHidden = true
//                cityLabel.isHidden = true
//                cityHighlightLabel.isHidden = false
            }
        }
    }
        
    var countryName: [String] = []
    var cityName: [String] = []
    
    
    var viewModelP = PersonalInfoViewModel()
    var isEdit: Bool! = false
    var isProfileImg = false
    var isLogoImage = false
    @IBOutlet weak var browseBtnOutlet: SetButton!
    @IBOutlet weak var fileName: UILabel!
    
    
    var countryNameArray: [String] = []
    var codeNameArray: [String] = []
    var cityNameArray: [String] = []
    var selectedCode: [String] = []
    
    var dataBusiness = ProfessionalSignUpdata()
    var viewModel = SignupViewModel()
    var imageData = Data()
    var imagePicker = ImagePickerViewControler()
    
    var profileImageData = Data()
    var LogoImageData = Data()
    var editProfileVm = EditDetailsViewModel()
    var branchVM = DetailsOfBranchViewModel()
    var branchId = ""
    var shownImage : UIImage!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryHighlightLabel: UILabel!
    
    @IBOutlet weak var cityHighlightLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var establishYear: SkyFloatingLabelTextField!
    @IBOutlet weak var licenceNoView: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btn1: SetButton!
    @IBOutlet weak var btn2: SetButton!
    @IBOutlet weak var btn3: SetButton!
    @IBOutlet weak var btn4: SetButton!
    @IBOutlet weak var btn5: SetButton!
    
    @IBOutlet weak var upperYearLabel: UILabel!
    @IBOutlet weak var lowerYearLabel: UILabel!
    @IBOutlet weak var profileImageView: SetImage!
    @IBOutlet weak var profileImgBtn: SetButton!
    @IBOutlet weak var ProfileLogoImage: SetImage!
    
    var data: [CountryName] = []
    var isBranchAdd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        
        btn1.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
        btn1.setImage(UIImage(named: "Ellipse 14"), for: .normal)
        
        upperYearLabel.isHidden = true
        collectionView.isHidden = true
        countryLabel.isHidden = true
        cityCollectionView.isHidden = true
        cityLabel.isHidden = true
        self.dataBusiness.branchLicence = ""
        country()
        collectionView.reloadData()
        collectionView.isHidden = false
        countryLabel.isHidden = false
        countryHighlightLabel.isHidden = true
        
        cityCollectionView.reloadData()
        cityCollectionView.isHidden = false
        cityLabel.isHidden = false
        cityHighlightLabel.isHidden = true
        if isEdit {
            setBackWithTitle(titleVal: "Personal Information")
            let url = URLS.profileImageUrl(viewModelP.dataModel?.data?.profileImage ?? "").getDescription()
            profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataBusiness.branchProfile = viewModelP.dataModel?.data?.profileImage ?? ""
            let urld = URLS.profileImageUrl(viewModelP.dataModel?.data?.logoImage ?? "").getDescription()
            ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataBusiness.logo = viewModelP.dataModel?.data?.logoImage ?? ""
            
            switch viewModelP.dataModel?.data?.businessDetails?.noOfEmp ?? "" {
            case "1 to 10":
                btn1Perform()
            case "upto 50":
                btn2Perform()
            case "upto 100":
                btn3Perform()
            case "upto 500":
                btn4Perform()
            case "more than 500":
                btn5Perform()
            default:
                break
            }
            
            
            lowerYearLabel.text = String(viewModelP.dataModel?.data?.businessDetails?.branchYear ?? 0)
            upperYearLabel.isHidden = false
            lowerYearLabel.alpha = 1.0
            
            licenceNoView.text = viewModelP.dataModel?.data?.businessDetails?.licenceNumber
            
            self.browseBtnOutlet.sd_setImage(with: URL(string: URLS.certificateImageUrl((self.viewModelP.dataModel?.data?.businessDetails?.branchLicence)!).getDescription()), for: .normal, placeholderImage: UIImage(named: "placeholder.png"))
            
            fileName.text = self.viewModelP.dataModel?.data?.businessDetails?.branchLicence
        }else{
            setBackWithTitle(titleVal: "Branch Details")
            let url = URLS.profileImageUrl(branchVM.getBranchDetails()?.branchProfile ?? "").getDescription()
            profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataBusiness.branchProfile = branchVM.getBranchDetails()?.branchProfile ?? ""
            let urld = URLS.profileImageUrl(branchVM.getBranchDetails()?.branchLogo ?? "").getDescription()
            ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataBusiness.logo = branchVM.getBranchDetails()?.branchLogo ?? ""
            
            switch branchVM.getBranchDetails()?.businessDetails?.noOfEmp ?? "" {
            case "1 to 10":
                btn1Perform()
            case "upto 50":
                btn2Perform()
            case "upto 100":
                btn3Perform()
            case "upto 500":
                btn4Perform()
            case "more than 500":
                btn5Perform()
            default:
                break
            }
            
            lowerYearLabel.text = String(branchVM.getBranchDetails()?.businessDetails?.branchYear ?? 0)
            upperYearLabel.isHidden = false
            lowerYearLabel.alpha = 1.0
            
            licenceNoView.text = branchVM.getBranchDetails()?.businessDetails?.licenceNumber
            
            self.browseBtnOutlet.sd_setImage(with: URL(string: URLS.certificateImageUrl((self.branchVM.getBranchDetails()?.businessDetails?.branchLicence)!).getDescription()), for: .normal, placeholderImage: UIImage(named: "placeholder.png"))
            
            fileName.text = self.branchVM.getBranchDetails()?.businessDetails?.branchLicence
        }
    }

    
    func country() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitUserCountry(){(isSuccess , message) in
        
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.countryNameArray = (self.viewModel.countryModel?.data?.map({$0.name ?? ""}))!
                print(self.countryNameArray)
                self.codeNameArray = (self.viewModel.countryModel?.data?.map({$0.isoCode ?? ""}))!
                print(self.codeNameArray)
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    
    func city(countryCode : [String]){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitUserCity(CountryCode: countryCode){(isSuccess , message) in
        
            Indicator.shared.hideProgressView()
            if isSuccess {
                self.cityNameArray = (self.viewModel.cityModel?.data?.map({$0.name ?? ""}))!
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    @IBAction func browseBtn(_ sender: Any) {
        imagePicker.imagePickerDelegete = self
        isProfileImg = false
        isLogoImage = false
        imagePicker.showImagePicker(viewController: self)
    }
    
    @IBAction func calenderBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(identifier: "YearPopUpViewController") as! YearPopUpViewController
        vc.delegate = self
        let card = SBCardPopupViewController(contentViewController: vc)
        card.show(onViewController: self)
    }
    
    @IBAction func tapProfileImgBtn(_ sender: Any) {
        self.imagePicker.imagePickerDelegete = self
        isProfileImg = true
        imagePicker.showImagePicker(viewController: self)
    }
    
    @IBAction func tapLogoImageBtn(_ sender: SetButton) {
        self.imagePicker.imagePickerDelegete = self
        isLogoImage = true
        imagePicker.showImagePicker(viewController: self)
    }
    
    
    func btn1Perform(){
        btn1.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
        btn1.setImage(UIImage(named: "Ellipse 14"), for: .normal)
        btn2.BorderColor = .gray
        btn2.setImage(nil, for: .normal)
        btn3.BorderColor = .gray
        btn3.setImage(nil, for: .normal)
        btn4.BorderColor = .gray
        btn4.setImage(nil, for: .normal)
        btn5.BorderColor = .gray
        btn5.setImage(nil, for: .normal)
    }
    
    func btn2Perform(){
        btn2.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
        btn2.setImage(UIImage(named: "Ellipse 14"), for: .normal)
        btn1.BorderColor = .gray
        btn1.setImage(nil, for: .normal)
        btn3.BorderColor = .gray
        btn3.setImage(nil, for: .normal)
        btn4.BorderColor = .gray
        btn4.setImage(nil, for: .normal)
        btn5.BorderColor = .gray
        btn5.setImage(nil, for: .normal)
    }
    
    func btn3Perform(){
        btn3.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
        btn3.setImage(UIImage(named: "Ellipse 14"), for: .normal)
        btn2.BorderColor = .gray
        btn2.setImage(nil, for: .normal)
        btn1.BorderColor = .gray
        btn1.setImage(nil, for: .normal)
        btn4.BorderColor = .gray
        btn4.setImage(nil, for: .normal)
        btn5.BorderColor = .gray
        btn5.setImage(nil, for: .normal)
    }
    
    func btn4Perform(){
        btn4.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
        btn4.setImage(UIImage(named: "Ellipse 14"), for: .normal)
        btn2.BorderColor = .gray
        btn2.setImage(nil, for: .normal)
        btn3.BorderColor = .gray
        btn3.setImage(nil, for: .normal)
        btn1.BorderColor = .gray
        btn1.setImage(nil, for: .normal)
        btn5.BorderColor = .gray
        btn5.setImage(nil, for: .normal)
    }
    
    func btn5Perform(){
        btn5.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
        btn5.setImage(UIImage(named: "Ellipse 14"), for: .normal)
        btn2.BorderColor = .gray
        btn2.setImage(nil, for: .normal)
        btn3.BorderColor = .gray
        btn3.setImage(nil, for: .normal)
        btn4.BorderColor = .gray
        btn4.setImage(nil, for: .normal)
        btn1.BorderColor = .gray
        btn1.setImage(nil, for: .normal)
    }
    
    
    @IBAction func btn1Action(_ sender: Any) {
        btn1Perform()
    }
    
    @IBAction func btn2Action(_ sender: Any) {
        btn2Perform()
    }
    
    @IBAction func btn3Action(_ sender: Any) {
        btn3Perform()
    }
    
    @IBAction func btn4Action(_ sender: Any) {
        btn4Perform()
    }
    
    @IBAction func btn5Action(_ sender: Any) {
      btn5Perform()
    }
    
    @IBAction func serviceBtn(_ sender: Any) {
        


            if self.lowerYearLabel.text == "Branch Establishment Year*" {
                self.view.makeToast("Please Select Branch Establishment Year")
            } else if self.countryName.isEmpty {
                self.view.makeToast("Please Select Country")
            }  else if self.cityName.isEmpty {
                self.view.makeToast("Please Select City")
            }  else if self.licenceNoView.text == "" {
                self.view.makeToast("Please Enter Licence Number")
            }  else if (self.dataBusiness.branchLicence == nil || self.dataBusiness.branchLicence == "") {
                self.view.makeToast("Please Upload Branch Licence")
            } else {
                
                self.dataBusiness.branchYear = Int(lowerYearLabel.text ?? "")
                self.dataBusiness.issued_in_countries = countryName
                self.dataBusiness.issued_in_cities = cityName
                self.dataBusiness.licenceNumber = licenceNoView.text

                if btn1.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataBusiness.no_of_emp = "1 to 10"
                } else if btn2.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataBusiness.no_of_emp = "upto 50"
                } else if btn3.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataBusiness.no_of_emp = "upto 100"
                } else if btn4.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataBusiness.no_of_emp = "upto 500"
                } else {
                    self.dataBusiness.no_of_emp = "more than 500"
                }

                editBuisnessDetails()
            }
        
    }
    
   
    
    @IBAction func countryBtn(_ sender: Any) {
        let vc =  UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(withIdentifier: "CountyPopUpViewController") as! CountyPopUpViewController
        vc.delegate = self
        vc.isCity = false
        vc.countryAndCity = countryNameArray
        vc.countryCode = codeNameArray
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    
    @IBAction func cityBtn(_ sender: Any) {
        if cityNameArray.isEmpty {
            self.view.makeToast("No city found.")
        } else {
            let vc =  UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(withIdentifier: "CountyPopUpViewController") as! CountyPopUpViewController
            vc.delegate = self
            vc.isCity = true
            vc.countryAndCity = cityNameArray
            let cardPopup = SBCardPopupViewController(contentViewController: vc)
            cardPopup.show(onViewController: self)
        }
    }
    
    
}


//MARK:- Collection View Delegates


extension EditBuisnessDetailsViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cityCollectionView {
            return cityName.count
        }
        return countryName.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cityCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CityCollectionViewCell
            cell.cityNameLabel.text = cityName[indexPath.row]
            cell.onCityDelete = {
                self.cityName.remove(at: indexPath.row)
                self.cityCollectionView.reloadData()
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CountryCollectionViewCell
            cell.countyNameLabel.text = countryName[indexPath.row]
            cell.onDeleteCountry = {
                self.countryName.remove(at: indexPath.row)
                if !self.isEdit {
                    self.selectedCode.remove(at: indexPath.row)
                    self.city(countryCode: self.selectedCode)
                }
                collectionView.reloadData()
                self.cityName.removeAll()
                self.cityCollectionView.reloadData()
            }
            return cell
        }
    }
}

//MARK:- Image Picker

extension EditBuisnessDetailsViewController : ImagePickerDelegete {
    
    func disFinishPicking(imgData: Data, img: UIImage) {
        
        if isProfileImg{
            profileImageData = img.jpegData(compressionQuality: 0.6)!
            self.profileImageView.image = img
            uploadProfileImage()
        }else if isLogoImage{
            LogoImageData = img.jpegData(compressionQuality: 0.6)!
            self.ProfileLogoImage.image = img
            uploadLogoImage()
        }else{
            imageData = img.jpegData(compressionQuality: 0.6)!
            uploadImage()
            self.shownImage = img
        }
       
    }
    
    func showPic() {
        self.browseBtnOutlet.setImage(self.shownImage, for: .normal)
    }
    
    func uploadImage() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitUploadImage(imageData: imageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message) in
            print(message)
            if isSuccess {
                self.dataBusiness.branchLicence = self.viewModel.imageData?.data
                self.showPic()
                //self.fileName.text = self.viewModel.imageData?.data
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    func uploadProfileImage(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiUploadProfileImage(imageData: profileImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
            if isSuccess{
                self.dataBusiness.branchProfile = (data as? [String : AnyObject])?["data"] as? String ?? ""
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    func uploadLogoImage(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiUploadLogoImage(imageData: LogoImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
            if isSuccess{
                self.dataBusiness.logo = (data as? [String : AnyObject])?["data"] as? String ?? ""
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
}


//MARK:- API CALL
extension EditBuisnessDetailsViewController{
    
    func editBuisnessDetails(){
        
     
        
        if isEdit{
            
            var certificateAndRewardArray : [[String : String]] = [[:]]

            for i in 0..<(viewModelP.dataModel?.data?.certificateAwards!.count)! {

                if let iii = viewModelP.dataModel?.data?.certificateAwards![i].image, let ddd = viewModelP.dataModel?.data?.certificateAwards![i].date {

                    certificateAndRewardArray.insert(["image" : iii, "date" : ddd], at: i)

                }

            }
            
            editProfileVm.editProfesstionalProfile(FirstName: (viewModelP.dataModel?.data?.firstName ?? ""), LastName: viewModelP.dataModel?.data?.lastName ?? "", Email: viewModelP.dataModel?.data?.email ?? "", branchNameEn: viewModelP.dataModel?.data?.branchNameEn ?? "", branchNameAr: viewModelP.dataModel?.data?.branchNameAr ?? "", branchTypeId: (viewModelP.dataModel?.data?.branchTypeID ?? ""), branchCategoryId: (viewModelP.dataModel?.data?.branchCategoryID ?? ""), branchBrief: viewModelP.dataModel?.data?.branchBrief ?? "", certificateAward: certificateAndRewardArray, noOfBranches: String(viewModelP.dataModel?.data?.noOfBranches ?? 0), profileImage: self.dataBusiness.branchProfile ?? "", LogoImage: self.dataBusiness.logo ?? "", country: self.viewModelP.dataModel?.data?.professionalAddress?.country ?? "", country_ph_code: self.viewModelP.dataModel?.data?.professionalAddress?.countryPhCode ?? "", phoneNumber: self.viewModelP.dataModel?.data?.professionalAddress?.phoneNumber ?? "", addFirstName: self.viewModelP.dataModel?.data?.professionalAddress?.addrFirstName ?? "", addLastName: self.viewModelP.dataModel?.data?.professionalAddress?.addrLastName ?? "", addLine1: self.viewModelP.dataModel?.data?.professionalAddress?.addressLine1 ?? "", addLine2: self.viewModelP.dataModel?.data?.professionalAddress?.addressLine2 ?? "", pincode: String(self.viewModelP.dataModel?.data?.professionalAddress?.pincode ?? 0), landmark: self.viewModelP.dataModel?.data?.professionalAddress?.landmark ?? "", state: self.viewModelP.dataModel?.data?.professionalAddress?.state ?? "", city: self.viewModelP.dataModel?.data?.professionalAddress?.city ?? "", co_ordinator_eng: viewModelP.dataModel?.data?.contactDetails?.coOrdinatorEng ?? "", co_ordinator_arabic: viewModelP.dataModel?.data?.contactDetails?.coOrdinatorArabic ?? "", branchEmail: viewModelP.dataModel?.data?.contactDetails?.branchEmail ?? "", branchWebsite: viewModelP.dataModel?.data?.contactDetails?.branchWebsite ?? "", countryCode: viewModelP.dataModel?.data?.contactDetails?.countryCode ?? "", businessCountryCode: viewModelP.dataModel?.data?.contactDetails?.businessCountryCode ?? "", mobileNumber: viewModelP.dataModel?.data?.contactDetails?.mobileNumber ?? "", businessMobileNumber: viewModelP.dataModel?.data?.contactDetails?.businessMobileNumber ?? "", instaAccount: viewModelP.dataModel?.data?.contactDetails?.instaAcc ?? "", youtubeAccount: viewModelP.dataModel?.data?.contactDetails?.youtubeChannel ?? "", branchYear: dataBusiness.branchYear ?? 0, issued_in_countries: (dataBusiness.issued_in_countries)!, issued_in_cities: (dataBusiness.issued_in_cities)!, branchLicence: dataBusiness.branchLicence ?? "", licenceNumber: dataBusiness.licenceNumber ?? "", no_of_emp: dataBusiness.no_of_emp ?? "",serviceCategories: self.viewModelP.dataModel?.data?.serviceCategories.map({$0.id ?? ""}) ?? [], serviceSubCate: self.viewModelP.dataModel?.data?.serviceSubcategories.map({$0.id ?? ""}) ?? [], newCategories: [[:]], serviceCountry: (viewModelP.dataModel?.data?.serviceDetails?.serviceCountry)!, serviceCity: (viewModelP.dataModel?.data?.serviceDetails?.serviceCity)!, serviceCost: viewModelP.dataModel?.data?.serviceDetails?.serviceCost ?? "") { (isSuccess, message) in
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

            editProfileVm.apiEditBranch(branchId: self.branchId, FirstName: self.branchVM.getBranchDetails()?.firstName ?? "" , LastName: self.branchVM.getBranchDetails()?.lastName ?? "", Email: self.branchVM.getBranchDetails()?.email ?? "", branchNameEn: self.branchVM.getBranchDetails()?.branchNameEn ?? "", branchNameAr: self.branchVM.getBranchDetails()?.branchNameAr ?? "", branchTypeId: branchVM.getBranchDetails()?.branchTypeID?.brandTypeID ?? "" , branchCategoryId: branchVM.getBranchDetails()?.branchCategoryID?.id ?? "", branchBrief: self.branchVM.getBranchDetails()?.branchBrief ?? "", branchProfile: self.dataBusiness.branchProfile ?? "", branchLogo: self.dataBusiness.logo ?? "", certificateAward: certificateAndRewardArray,   country: self.branchVM.getBranchDetails()?.addressDetails?.first?.country ?? "", country_ph_code: self.branchVM.getBranchDetails()?.addressDetails?.first?.countryPhCode ?? "", phoneNumber: self.branchVM.getBranchDetails()?.addressDetails?.first?.phoneNumber ?? "", addFirstName: self.branchVM.getBranchDetails()?.addressDetails?.first?.addrFirstName ?? "", addLastName: self.branchVM.getBranchDetails()?.addressDetails?.first?.addrLastName ?? "", addLine1: self.branchVM.getBranchDetails()?.addressDetails?.first?.addressLine1 ?? "", addLine2: self.branchVM.getBranchDetails()?.addressDetails?.first?.addressLine2 ?? "", pincode: String(self.branchVM.getBranchDetails()?.addressDetails?.first?.pincode ?? 0), landmark: self.branchVM.getBranchDetails()?.addressDetails?.first?.landmark ?? "", state: self.branchVM.getBranchDetails()?.addressDetails?.first?.state ?? "", city: self.branchVM.getBranchDetails()?.addressDetails?.first?.city ?? "", co_ordinator_eng: self.branchVM.getBranchDetails()?.contactDetails?.coOrdinatorEng ?? "", co_ordinator_arabic: self.branchVM.getBranchDetails()?.contactDetails?.coOrdinatorArabic ?? "", branchEmail: self.branchVM.getBranchDetails()?.contactDetails?.branchEmail ?? "", branchWebsite: self.branchVM.getBranchDetails()?.contactDetails?.branchWebsite ?? "", countryCode: self.branchVM.getBranchDetails()?.contactDetails?.countryCode ?? "", businessCountryCode: self.branchVM.getBranchDetails()?.contactDetails?.businessCountryCode ?? "", mobileNumber: self.branchVM.getBranchDetails()?.contactDetails?.mobileNumber ?? "", businessMobileNumber: self.branchVM.getBranchDetails()?.contactDetails?.businessMobileNumber ?? "", instaAccount: self.branchVM.getBranchDetails()?.contactDetails?.instaAcc ?? "", youtubeAccount: self.branchVM.getBranchDetails()?.contactDetails?.youtubeChannel ?? "", branchYear: dataBusiness.branchYear ?? 0, issued_in_countries: (dataBusiness.issued_in_countries)!, issued_in_cities: (dataBusiness.issued_in_cities)!, branchLicence: dataBusiness.branchLicence ?? "", licenceNumber: dataBusiness.licenceNumber ?? "", no_of_emp: dataBusiness.no_of_emp ?? "", serviceCategories: branchVM.getBranchDetails()?.serviceCategories?.map({$0.id ?? ""}) ?? [], serviceSubCate: branchVM.getBranchDetails()?.serviceSubcategories?.map({$0.id ?? ""}) ?? [], newCategories: [[:]], serviceCountry: (self.branchVM.getBranchDetails()?.serviceDetails?.serviceCountry)!, serviceCity: (self.branchVM.getBranchDetails()?.serviceDetails?.serviceCity)!, serviceCost: self.branchVM.getBranchDetails()?.serviceDetails?.serviceCost ?? "") { (isSuccess, message) in
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
