//
//  EditServiceDetailsViewController.swift
//  Dreesha User
//
//  Created by Admin on 23/04/21.
//

import UIKit
import SBCardPopup

class EditServiceDetailsViewController: UIViewController,CountryList,ServiceDataValue {
    
    
    func getValue(name: [String], id: [String]) {
        
        
        print(name)
        print(id)
        
        if isSubSer{
            editSubServiceNameArray.append(contentsOf: name)
            self.editSubServiceIDArray.append(contentsOf: id)
          
            upperSubServiceLbl.isHidden = false
            lowerSubServiceLbl.alpha = 1.0
            subServiceColl.reloadData()
        }else{
            editServiceNameArray.append(contentsOf: name)
            self.selectedServiceIdArray.append(contentsOf: id)
            lowerSerivceLabel.text = editServiceNameArray.joined(separator: ", ")
            upperSericeLabel.isHidden = false
            lowerSerivceLabel.alpha = 1.0
            serviceCollView.reloadData()
            
            for i in selectedServiceIdArray{
                subServiceList(cateId: i)
            }
        }
        
        
    }
    

    func countries(name: [String], isCity: Bool, code: [String]) {
        if !isCity {
            if name.count > 0 {
                self.countryName.append(contentsOf: name)
                collectionView.reloadData()
                collectionView.isHidden = false
                countryLabel.isHidden = false
                countryHighLightLabel.isHidden = true
                
                
                selectedCode = code
                self.city(countryCode: selectedCode)
                //self.cityName.removeAll()
                cityCollectionView.reloadData()
            } else {
//                collectionView.isHidden = true
//                countryLabel.isHidden = true
//                countryHighLightLabel.isHidden = false
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
    
    
    @IBOutlet weak var btn1: SetButton!
    
    
    @IBOutlet weak var btn2: SetButton!
    @IBOutlet weak var btn3: SetButton!
    @IBOutlet weak var btn4: SetButton!
    @IBOutlet weak var btn5: SetButton!
    
    @IBOutlet weak var countryHighLightLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityHighlightLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var serviceCollView: UICollectionView!
    
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    @IBOutlet weak var subServiceColl: UICollectionView!
    @IBOutlet weak var lowerSerivceLabel: UILabel!
    @IBOutlet weak var upperSericeLabel: UILabel!
    @IBOutlet weak var upperSubServiceLbl: UILabel!
    
    @IBOutlet weak var lowerSubServiceLbl: UILabel!
    
    @IBOutlet weak var profileImageView: SetImage!
    @IBOutlet weak var profileImgBtn: SetButton!
    @IBOutlet weak var LogoImageView: SetImage!
    
    
    
    
    var countryNameArray: [String] = []
    var codeNameArray: [String] = []
    var cityNameArray: [String] = []
    var selectedCode: [String] = []
    
    var countryName: [String] = []
    var cityName: [String] = []
    
    var serviceNameArray: [String] = []
    var serviceIdArray : [String] = []
    var selectedServiceIdArray : [String] = []
    
    var subServiceNameArray : [String] = []
    var subServiceIdArray : [String] = []
    
    
    var editServiceNameArray: [String] = []
    var EditServiceIdArray : [String] = []
    var editSubServiceNameArray : [String] = []
    var editSubServiceIDArray : [String] = []
    
    var dataService = ProfessionalSignUpdata()
    var viewModel = SignupViewModel()
    
    
    var viewModelP = PersonalInfoViewModel()
    var isEdit: Bool! = false
    var isBranchAdd = false
    var editProfileVm = EditDetailsViewModel()
    
    var imagePicker = ImagePickerViewControler()
    var profileImageData = Data()
    var LogoImageData = Data()
    var isProfileImage = false
    var branchVM = DetailsOfBranchViewModel()
    var branchId = ""
    var isSubSer = false

    override func viewDidLoad() {
        super.viewDidLoad()
        serviceCollView.delegate = self
        serviceCollView.dataSource = self
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        subServiceColl.delegate = self
        subServiceColl.dataSource = self
        
//        btn1.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
//        btn1.setImage(UIImage(named: "Ellipse 14"), for: .normal)
//        
//        btn2.BorderColor = .gray
//        btn2.setImage(nil, for: .normal)
//        btn3.BorderColor = .gray
//        btn3.setImage(nil, for: .normal)
//        btn4.BorderColor = .gray
//        btn4.setImage(nil, for: .normal)
//        btn5.BorderColor = .gray
//        btn5.setImage(nil, for: .normal)
        //serviceView.placeholder = "Please List the Services and Product you Provide*"
        
        upperSericeLabel.isHidden = true
        upperSubServiceLbl.isHidden = true
        
        collectionView.isHidden = true
        countryLabel.isHidden = true
        cityCollectionView.isHidden = true
        cityLabel.isHidden = true
        
        if isEdit {
            
            let url = URLS.profileImageUrl(viewModelP.dataModel?.data?.profileImage ?? "").getDescription()
            profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "Placeholding"))
            self.dataService.branchProfile = viewModelP.dataModel?.data?.profileImage ?? ""
            let urld = URLS.profileImageUrl(viewModelP.dataModel?.data?.logoImage ?? "").getDescription()
            LogoImageView.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "Placeholding"))
            self.dataService.logo = viewModelP.dataModel?.data?.logoImage ?? ""
            
            switch viewModelP.dataModel?.data?.serviceDetails?.serviceCost ?? "" {
            case "Upto 10,000 AED" , "Upto 10000 AED":
                btn1Data()
            case "Upto 50,000 AED" , "Upto 50000 AED":
                btn2Data()
            case "Upto 100,000 AED" , "Upto 100000 AED":
                btn3Data()
            case "Upto 500,000 AED" , "Upto 500000 AED":
                btn4Data()
            case "More than 500,000 AED" , "More than 500000 AED":
                btn5Data()
            default:
                break
            }
            
            print(countryName)
            print(cityName)
            
            if btn1.currentTitle == self.viewModelP.dataModel?.data?.serviceDetails?.serviceCost {
                self.btn1Data()
            } else if btn2.currentTitle == self.viewModelP.dataModel?.data?.serviceDetails?.serviceCost {
                self.btn2Data()
            } else if btn3.currentTitle == self.viewModelP.dataModel?.data?.serviceDetails?.serviceCost {
                self.btn3Data()
            } else if btn4.currentTitle == self.viewModelP.dataModel?.data?.serviceDetails?.serviceCost {
                self.btn4Data()
            } else if btn5.currentTitle == self.viewModelP.dataModel?.data?.serviceDetails?.serviceCost {
                self.btn5Data()
            }
            

            
           
        }else{
            
            let url = URLS.profileImageUrl(branchVM.getBranchDetails()?.branchProfile ?? "").getDescription()
            profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataService.branchProfile = branchVM.getBranchDetails()?.branchProfile ?? ""
            let urld = URLS.profileImageUrl(branchVM.getBranchDetails()?.branchLogo ?? "").getDescription()
            LogoImageView.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            self.dataService.logo = branchVM.getBranchDetails()?.branchLogo ?? ""
            
            switch branchVM.getBranchDetails()?.serviceDetails?.serviceCost ?? "" {
            case "Upto 10,000 AED" , "Upto 10000 AED":
                btn1Data()
            case "Upto 50,000 AED" , "Upto 50000 AED":
                btn2Data()
            case "Upto 100,000 AED" , "Upto 100000 AED":
                btn3Data()
            case "Upto 500,000 AED" , "Upto 500000 AED":
                btn4Data()
            case "More than 500,000 AED" , "More than 500000 AED":
                btn5Data()
            default:
                break
            }
            
            print(countryName)
            print(cityName)
            
            if btn1.currentTitle == self.branchVM.getBranchDetails()?.serviceDetails?.serviceCost {
                self.btn1Data()
            } else if btn2.currentTitle == self.branchVM.getBranchDetails()?.serviceDetails?.serviceCost {
                self.btn2Data()
            } else if btn3.currentTitle == self.branchVM.getBranchDetails()?.serviceDetails?.serviceCost {
                self.btn3Data()
            } else if btn4.currentTitle == self.branchVM.getBranchDetails()?.serviceDetails?.serviceCost {
                self.btn4Data()
            } else if btn5.currentTitle == self.branchVM.getBranchDetails()?.serviceDetails?.serviceCost {
                self.btn5Data()
            }
        }
        self.selectedServiceIdArray = EditServiceIdArray
        lowerSerivceLabel.text = editServiceNameArray.joined(separator: ", ")
        upperSericeLabel.isHidden = false
        upperSubServiceLbl.isHidden = false
        lowerSerivceLabel.alpha = 1.0
        
        
        collectionView.reloadData()
        collectionView.isHidden = false
        countryLabel.isHidden = false
        countryHighLightLabel.isHidden = true
        
        cityCollectionView.isHidden = false
        cityLabel.isHidden = false
        cityHighlightLabel.isHidden = true
        
        country()
        serviceList()
        
        for i in selectedServiceIdArray{
            subServiceList(cateId: i)
        }
    }

    func country() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitUserCountry(){(isSuccess , message) in
        
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.countryNameArray.append(contentsOf: (self.viewModel.countryModel?.data?.map({$0.name ?? ""}))!)
                print(self.countryNameArray)
                self.codeNameArray = (self.viewModel.countryModel?.data?.map({$0.isoCode ?? ""}))!
                print(self.codeNameArray)
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    func serviceList() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitServiceList(search: "") { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                print(message)
                self.serviceNameArray = (self.viewModel.serviceModel.map({$0.name ?? "" }))
                self.serviceIdArray = (self.viewModel.serviceModel.map({$0.id ?? "" }))
                print(self.serviceNameArray)
                print(self.serviceIdArray)
            }
        }
    }
    
    
    func subServiceList(cateId : String){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiGetSubCategory(categoryId: cateId) { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.subServiceNameArray = self.viewModel.subCateModel.map({$0.name ?? ""})
                self.subServiceIdArray = self.viewModel.subCateModel.map({$0.id ?? ""})
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
    
    func btn1Data() {
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
    
    func btn2Data() {
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
    
    func btn3Data() {
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
    
    func btn4Data() {
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
    
    func btn5Data() {
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
        btn1Data()
    }
    
    @IBAction func btn2Action(_ sender: Any) {
        btn2Data()
    }
    
    @IBAction func btn3Action(_ sender: Any) {
        btn3Data()
    }
    
    @IBAction func btn4Action(_ sender: Any) {
        btn4Data()
    }
    
    @IBAction func btn5Action(_ sender: Any) {
        btn5Data()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = false
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isEdit{
            setBackWithTitle(titleVal : "Personal Information")
        }else{
            setBackWithTitle(titleVal: "Branch Details")
        }
        
    }
    
    @IBAction func branchBtn(_ sender: Any) {
        
        print(countryName)
        print(cityName)
        
        
       
            if self.lowerSerivceLabel.text == "" || lowerSerivceLabel.text == "Please List the Services and Product you Provide*" {
                self.view.makeToast("Please Select Service")
            } else if self.countryName.isEmpty {
                self.view.makeToast("Please Select Country")
            }  else if self.cityName.isEmpty {
                self.view.makeToast("Please Select City")
            } else {
                self.dataService.services_products = self.selectedServiceIdArray
                self.dataService.serviceCountry = countryName
                self.dataService.serviceSubCategories = self.editSubServiceIDArray
                self.dataService.serviceCity = cityName
                
                if btn1.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataService.serviceCost = "Upto 10,000 AED"
                } else if btn2.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataService.serviceCost = "Upto 50,000 AED"
                } else if btn3.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataService.serviceCost = "Upto 100,000 AED"
                } else if btn4.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataService.serviceCost = "Upto 500,000 AED"
                } else {
                    self.dataService.serviceCost = "More than 500,000 AED"
                }
                
                if isBranchAdd{
                    
                }else{
                    
                  editServiceDetails()
                }
 
            }
    }
    
    @IBAction func cityBtn(_ sender: Any) {
        if cityNameArray.isEmpty {
            self.view.makeToast("No city found.")
        } else {
            let vc = UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(withIdentifier: "CountyPopUpViewController") as! CountyPopUpViewController
            vc.delegate = self
            vc.isCity = true
            vc.countryAndCity = cityNameArray
            let cardPopup = SBCardPopupViewController(contentViewController: vc)
            cardPopup.show(onViewController: self)
        }
    }
    
    @IBAction func countryBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(withIdentifier: "CountyPopUpViewController") as! CountyPopUpViewController
        vc.delegate = self
        vc.isCity = false
        vc.countryAndCity = countryNameArray
        vc.countryCode = codeNameArray
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    
    
    @IBAction func serviceListBtn(_ sender: Any) {
         isSubSer = false
        let vc = UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(identifier: "ServiceListPopUpViewController") as! ServiceListPopUpViewController
        vc.nameArray = serviceNameArray
        vc.idArray = serviceIdArray
        vc.delegate = self
        let card = SBCardPopupViewController(contentViewController: vc)
        card.show(onViewController: self)
    }
    
    
    @IBAction func tapSubServiceList(_ sender: Any) {
        isSubSer = true
       let vc = UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(identifier: "ServiceListPopUpViewController") as! ServiceListPopUpViewController
       vc.nameArray = subServiceNameArray
       vc.idArray = subServiceIdArray
       vc.delegate = self
       let card = SBCardPopupViewController(contentViewController: vc)
       card.show(onViewController: self)
    }
    
    @IBAction func tapProfileImgBtn(_ sender: Any) {
        self.imagePicker.imagePickerDelegete = self
        isProfileImage = true
        imagePicker.showImagePicker(viewController: self)
    }
    
    @IBAction func TapLogoImageBtn(_ sender: UIButton) {
        
            self.imagePicker.imagePickerDelegete = self
         
            imagePicker.showImagePicker(viewController: self)
    }
    
    
    
}

//MARK:- Image Picker Delegate

extension EditServiceDetailsViewController : ImagePickerDelegete {
    
    func disFinishPicking(imgData: Data, img: UIImage) {

        if isProfileImage{
            profileImageData = img.jpegData(compressionQuality: 0.6)!
            self.profileImageView.image = img
            uploadProfileImage()
        }else {
            LogoImageData = img.jpegData(compressionQuality: 0.6)!
            self.LogoImageView.image = img
            uploadLogoImage()
        }


    }
   
}

//MARK:- Collection View Delegates


extension EditServiceDetailsViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cityCollectionView {
            return cityName.count
        }else if collectionView == serviceCollView{
            return selectedServiceIdArray.count
        }else if collectionView == subServiceColl{
            return editSubServiceIDArray.count
        }else{
            return countryName.count
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cityCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCityCollectionViewCell
            cell.cityNameLabel.text = cityName[indexPath.row]
            cell.onDelete = {
                self.cityName.remove(at: indexPath.row)
                self.cityCollectionView.reloadData()
            }
            return cell
        } else if collectionView == serviceCollView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCityCollectionViewCell
            cell.cityNameLabel.text = editServiceNameArray[indexPath.row]
            cell.onDelete = {
                self.selectedServiceIdArray.remove(at: indexPath.row)
                self.editServiceNameArray.remove(at: indexPath.row)
                self.serviceCollView.reloadData()
            }
            return cell
        }else if collectionView == subServiceColl{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCityCollectionViewCell
            cell.cityNameLabel.text = editSubServiceNameArray[indexPath.row]
            cell.onDelete = {
                self.editSubServiceIDArray.remove(at: indexPath.row)
                self.editSubServiceNameArray.remove(at: indexPath.row)
                self.serviceCollView.reloadData()
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCountryCollectionViewCell
            cell.countryNameLabel.text = countryName[indexPath.row]
            cell.onDelete = {
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

//MARK:- API CALL
extension EditServiceDetailsViewController{
    
    func uploadProfileImage(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiUploadProfileImage(imageData: profileImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
            if isSuccess{
                self.dataService.branchProfile = (data as? [String : AnyObject])?["data"] as? String ?? ""
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    func uploadLogoImage(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiUploadLogoImage(imageData: LogoImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
            if isSuccess{
                self.dataService.logo = (data as? [String : AnyObject])?["data"] as? String ?? ""
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    
    
    func editServiceDetails(){



        if isEdit{

            var certificateAndRewardArray : [[String : String]] = [[:]]

            for i in 0..<(viewModelP.dataModel?.data?.certificateAwards!.count)! {

                if let iii = viewModelP.dataModel?.data?.certificateAwards![i].image, let ddd = viewModelP.dataModel?.data?.certificateAwards![i].date {

                    certificateAndRewardArray.insert(["image" : iii, "date" : ddd], at: i)

                }

            }

            editProfileVm.editProfesstionalProfile(FirstName: (viewModelP.dataModel?.data?.firstName ?? ""), LastName: viewModelP.dataModel?.data?.lastName ?? "", Email: viewModelP.dataModel?.data?.email ?? "", branchNameEn: viewModelP.dataModel?.data?.branchNameEn ?? "", branchNameAr: viewModelP.dataModel?.data?.branchNameAr ?? "", branchTypeId: (viewModelP.dataModel?.data?.branchTypeID ?? ""), branchCategoryId: (viewModelP.dataModel?.data?.branchCategoryID ?? ""), branchBrief: viewModelP.dataModel?.data?.branchBrief ?? "", certificateAward: certificateAndRewardArray, noOfBranches: dataService.noOfBranches ?? "", profileImage: self.dataService.branchProfile ?? "", LogoImage: self.dataService.logo ?? "", country: self.viewModelP.dataModel?.data?.professionalAddress?.country ?? "", country_ph_code: self.viewModelP.dataModel?.data?.professionalAddress?.countryPhCode ?? "", phoneNumber: self.viewModelP.dataModel?.data?.professionalAddress?.phoneNumber ?? "", addFirstName: self.viewModelP.dataModel?.data?.professionalAddress?.addrFirstName ?? "", addLastName: self.viewModelP.dataModel?.data?.professionalAddress?.addrLastName ?? "", addLine1: self.viewModelP.dataModel?.data?.professionalAddress?.addressLine1 ?? "", addLine2: self.viewModelP.dataModel?.data?.professionalAddress?.addressLine2 ?? "", pincode: String(self.viewModelP.dataModel?.data?.professionalAddress?.pincode ?? 0), landmark: self.viewModelP.dataModel?.data?.professionalAddress?.landmark ?? "", state: self.viewModelP.dataModel?.data?.professionalAddress?.state ?? "", city: self.viewModelP.dataModel?.data?.professionalAddress?.city ?? "", co_ordinator_eng: viewModelP.dataModel?.data?.contactDetails?.coOrdinatorEng ?? "", co_ordinator_arabic: viewModelP.dataModel?.data?.contactDetails?.coOrdinatorArabic ?? "", branchEmail: viewModelP.dataModel?.data?.contactDetails?.branchEmail ?? "", branchWebsite: viewModelP.dataModel?.data?.contactDetails?.branchWebsite ?? "", countryCode: viewModelP.dataModel?.data?.contactDetails?.countryCode ?? "", businessCountryCode: viewModelP.dataModel?.data?.contactDetails?.businessCountryCode ?? "", mobileNumber: viewModelP.dataModel?.data?.contactDetails?.mobileNumber ?? "", businessMobileNumber: viewModelP.dataModel?.data?.contactDetails?.businessMobileNumber ?? "", instaAccount: viewModelP.dataModel?.data?.contactDetails?.instaAcc ?? "", youtubeAccount: viewModelP.dataModel?.data?.contactDetails?.youtubeChannel ?? "", branchYear: (viewModelP.dataModel?.data?.businessDetails?.branchYear ?? 0), issued_in_countries: (viewModelP.dataModel?.data?.businessDetails?.issuedInCountries)!, issued_in_cities: (viewModelP.dataModel?.data?.businessDetails?.issuedInCities)!, branchLicence: viewModelP.dataModel?.data?.businessDetails?.branchLicence ?? "", licenceNumber: viewModelP.dataModel?.data?.businessDetails?.licenceNumber ?? "", no_of_emp: viewModelP.dataModel?.data?.businessDetails?.noOfEmp ?? "", serviceCategories: dataService.services_products, serviceSubCate: dataService.serviceSubCategories, newCategories: [[:]], serviceCountry: dataService.serviceCountry, serviceCity: dataService.serviceCity, serviceCost: dataService.serviceCost) { (isSuccess, message) in
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

            editProfileVm.apiEditBranch(branchId: self.branchId, FirstName: self.branchVM.getBranchDetails()?.firstName ?? "" , LastName: self.branchVM.getBranchDetails()?.lastName ?? "", Email: self.branchVM.getBranchDetails()?.email ?? "", branchNameEn: self.branchVM.getBranchDetails()?.branchNameEn ?? "", branchNameAr: self.branchVM.getBranchDetails()?.branchNameAr ?? "", branchTypeId: branchVM.getBranchDetails()?.branchTypeID?.brandTypeID ?? "" , branchCategoryId: branchVM.getBranchDetails()?.branchCategoryID?.id ?? "", branchBrief: self.branchVM.getBranchDetails()?.branchBrief ?? "", branchProfile: self.dataService.branchProfile ?? "", branchLogo: self.dataService.logo ?? "", certificateAward: certificateAndRewardArray,  country: self.branchVM.getBranchDetails()?.addressDetails?.first?.country ?? "", country_ph_code: self.branchVM.getBranchDetails()?.addressDetails?.first?.countryPhCode ?? "", phoneNumber: self.branchVM.getBranchDetails()?.addressDetails?.first?.phoneNumber ?? "", addFirstName: self.branchVM.getBranchDetails()?.addressDetails?.first?.addrFirstName ?? "", addLastName: self.branchVM.getBranchDetails()?.addressDetails?.first?.addrLastName ?? "", addLine1: self.branchVM.getBranchDetails()?.addressDetails?.first?.addressLine1 ?? "", addLine2: self.branchVM.getBranchDetails()?.addressDetails?.first?.addressLine2 ?? "", pincode: String(self.branchVM.getBranchDetails()?.addressDetails?.first?.pincode ?? 0), landmark: self.branchVM.getBranchDetails()?.addressDetails?.first?.landmark ?? "", state: self.branchVM.getBranchDetails()?.addressDetails?.first?.state ?? "", city: self.branchVM.getBranchDetails()?.addressDetails?.first?.city ?? "", co_ordinator_eng: self.branchVM.getBranchDetails()?.contactDetails?.coOrdinatorEng ?? "", co_ordinator_arabic: self.branchVM.getBranchDetails()?.contactDetails?.coOrdinatorArabic ?? "", branchEmail: self.branchVM.getBranchDetails()?.contactDetails?.branchEmail ?? "", branchWebsite: self.branchVM.getBranchDetails()?.contactDetails?.branchWebsite ?? "", countryCode: self.branchVM.getBranchDetails()?.contactDetails?.countryCode ?? "", businessCountryCode: self.branchVM.getBranchDetails()?.contactDetails?.businessCountryCode ?? "", mobileNumber: self.branchVM.getBranchDetails()?.contactDetails?.mobileNumber ?? "", businessMobileNumber: self.branchVM.getBranchDetails()?.contactDetails?.businessMobileNumber ?? "", instaAccount: self.branchVM.getBranchDetails()?.contactDetails?.instaAcc ?? "", youtubeAccount: self.branchVM.getBranchDetails()?.contactDetails?.youtubeChannel ?? "", branchYear: self.branchVM.getBranchDetails()?.businessDetails?.branchYear ?? 0, issued_in_countries: (branchVM.getBranchDetails()?.businessDetails?.issuedInCountries)!, issued_in_cities: (branchVM.getBranchDetails()?.businessDetails?.issuedInCities)!, branchLicence: (branchVM.getBranchDetails()?.businessDetails?.branchLicence ?? ""), licenceNumber: (branchVM.getBranchDetails()?.businessDetails?.licenceNumber ?? ""), no_of_emp: (branchVM.getBranchDetails()?.businessDetails?.noOfEmp ?? ""), serviceCategories: dataService.services_products, serviceSubCate: dataService.serviceSubCategories, newCategories: [[:]], serviceCountry: dataService.serviceCountry, serviceCity: dataService.serviceCity, serviceCost: dataService.serviceCost) { (isSuccess, message) in
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
