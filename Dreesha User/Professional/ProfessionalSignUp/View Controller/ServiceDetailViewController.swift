//
//  ServiceDetailViewController.swift
//  Dreeshah
//
//  Created by Apple on 23/03/21.
//

import UIKit
import AnimatedField
import SBCardPopup


class ServiceCountryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    
    var onDelete: (() -> Void)!
    
    @IBAction func deleteBtn(_ sender: Any) {
        onDelete()
    }
}


class ServiceCityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var onDelete: (() -> Void)!
    
    @IBAction func deleteBtn(_ sender: Any) {
        onDelete()
    }
    
}


class ServiceDetailViewController: UIViewController, CountryList, ServiceDataValue {
    
    
    func getValue(name: [String], id: [String]) {
        print(name)
        print(id)
        
        if isService{
            selectedServiceName.append(contentsOf: name)
           
            selectedServiceIdArray.append(contentsOf: id)
            upperSericeLabel.isHidden = false
            serviceCatColl.isHidden = false
            for i in id{
                subServiceList(categoryId: i)
            }
            self.serviceCatColl.reloadData()
        }else{
            SelectedSubServiceNameArr.append(contentsOf: name)
            SelectedSubServiceIDArr.append(contentsOf: id)
            serSubCatUppTitle.isHidden = false
            serviceSubCatColl.isHidden = false
            serviceSubCatColl.reloadData()
        }
        
//
//        lowerSerivceLabel.text = name.joined(separator: ", ")
//        upperSericeLabel.isHidden = false
//        lowerSerivceLabel.alpha = 1.0
    }
    

    func countries(name: [String], isCity: Bool, code: [String]) {
        if !isCity {
            if name.count > 0 {
                self.countryName = name
                collectionView.reloadData()
                collectionView.isHidden = false
                countryLabel.isHidden = false
                countryHighLightLabel.isHidden = true
                
                
                selectedCode = code
                self.city(countryCode: selectedCode)
                self.cityName.removeAll()
                cityCollectionView.reloadData()
            } else {
//                collectionView.isHidden = true
//                countryLabel.isHidden = true
//                countryHighLightLabel.isHidden = false
            }
        } else {
            if name.count > 0 {
                self.cityName = name
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
    
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    @IBOutlet weak var lowerSerivceLabel: UILabel!
    @IBOutlet weak var upperSericeLabel: UILabel!
    
    @IBOutlet weak var topImageHeight: NSLayoutConstraint!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var serviceCatColl: UICollectionView!
    
    @IBOutlet weak var serviceSubCatColl: UICollectionView!
    @IBOutlet weak var serviceCatCollHeight: NSLayoutConstraint!
    @IBOutlet weak var serviceSubCatCollHeight: NSLayoutConstraint!
    
    @IBOutlet weak var serviceCatTable: UITableView!
    
    @IBOutlet weak var serviecCatTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var serviceCatTextFld: SkyFloatingLabelTextField!

    @IBOutlet weak var serSubCatUppTitle: UILabel!
    
    @IBOutlet weak var serSubCatLowerTitle: UILabel!
    //MARK:- Variables
    
    var countryNameArray: [String] = []
    var codeNameArray: [String] = []
    var cityNameArray: [String] = []
    var selectedCode: [String] = []
    
    var countryName: [String] = []
    var cityName: [String] = []
    
    var serviceNameArray: [String] = []
    var serviceSearchArray : [String] = []
    var isServiceSearch = false
    var serviceIdArray : [String] = []
    var selectedServiceIdArray : [String] = []
    
    var subServiceNameArr : [String] = []
    var subServiceIDArr : [String] = []
    
    var SelectedSubServiceNameArr : [String] = []
    var SelectedSubServiceIDArr : [String] = []
    
    var selectedServiceName: [String] = []
    var EditServiceIdArray : [String] = []
    
    var newCate = [[String:String]]()
    
    var dataService = ProfessionalSignUpdata()
    var viewModel = SignupViewModel()
    var format = AnimatedFieldFormat()
    
    var viewModelP = PersonalInfoViewModel()
    var isEdit: Bool! = false
    var isBranchAdd = false
    var isService = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        country()
        serviceList(search: "")
        
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
        //serviceView.placeholder = "Please List the Services and Product you Provide*"
        
        format.textColor = .black
        format.lineColor = .black
        format.highlightColor = .black
        format.titleColor = .black
        
        //upperSericeLabel.isHidden = true
        
        collectionView.isHidden = true
        countryLabel.isHidden = true
        cityCollectionView.isHidden = true
        cityLabel.isHidden = true
        serSubCatUppTitle.isHidden = true
        serviceSubCatColl.isHidden = true
        upperSericeLabel.isHidden = true
        serviceCatColl.isHidden = true
        
        serviceCatColl.delegate = self
        serviceCatColl.dataSource = self
       // serviceCatCollHeight.constant = 0
        
        serviceCatTable.delegate = self
        serviceCatTable.dataSource = self
        serviecCatTableHeight.constant = 0
        
        
        serviceSubCatColl.delegate = self
        serviceSubCatColl.dataSource = self
       // serviceSubCatCollHeight.constant = 0
        
        if isEdit {
            
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
            
//            if btn1.currentTitle == "Upto 100000 AED" {
//                self.btn1Data()
//            } else if btn2.currentTitle == "Upto 100000 AED" {
//                self.btn2Data()
//            } else if btn3.currentTitle == "Upto 100000 AED" {
//                self.btn3Data()
//            } else if btn4.currentTitle == "Upto 100000 AED" {
//                self.btn4Data()
//            } else if btn5.currentTitle == "Upto 100000 AED" {
//                self.btn5Data()
//            }
            
            self.selectedServiceIdArray = EditServiceIdArray
//            lowerSerivceLabel.text = editServiceNameArray.joined(separator: ", ")
//            upperSericeLabel.isHidden = false
//            lowerSerivceLabel.alpha = 1.0
            
            
            collectionView.reloadData()
            collectionView.isHidden = false
            countryLabel.isHidden = false
            countryHighLightLabel.isHidden = true
            
            cityCollectionView.isHidden = false
            cityLabel.isHidden = false
            cityHighlightLabel.isHidden = true
        }else if isBranchAdd{
            topImageHeight.constant = 60
            topImage.isHidden = true
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
    
    func serviceList(search : String) {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitServiceList(search: search) { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                print(message)
                self.serviceNameArray = (self.viewModel.serviceModel.map({$0.name ?? "" }))
                self.serviceIdArray = (self.viewModel.serviceModel.map({$0.id ?? "" }))
//                self.serviecCatTableHeight.constant = 150
                self.serviceCatTable.reloadData()
                print(self.serviceNameArray)
                print(self.serviceIdArray)
            }else{
                //self.serviecCatTableHeight.constant = 0
            }
        }
    }
    
    func subServiceList(categoryId : String){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiGetSubCategory(categoryId: categoryId) { (isSuccess, msg) in
            if isSuccess{
                
                self.subServiceNameArr = (self.viewModel.subCateModel.map({$0.name ?? "" }))
                self.subServiceIDArr = (self.viewModel.subCateModel.map({$0.id ?? "" }))
               
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
//        if CurrentSession.shared.isProfesstionalSignUp {
//            navigationController?.isNavigationBarHidden = true
//        } else {
//            setBackWithTitle(titleVal : "Personal Information")
//        }
        
        setBackWithTitle(titleVal : "Personal Information")
    }
    
    //MARK:- IBActions
    
    @IBAction func addMannualService(_ sender: Any) {
        
       // selectedServiceName.append(<#T##newElement: String##String#>)
        
                
        if serviceCatTextFld.text ?? "" == ""{

        }else{
            selectedServiceName.append(serviceCatTextFld.text ?? "")
            serviceCatColl.reloadData()
            serviceCatCollHeight.constant
             = 45
            let dict = ["name":serviceCatTextFld.text ?? ""]
            self.newCate.append(dict)
        }
    }
    
    @IBAction func tapSubCategory(_ sender: Any) {
    }
    
    @IBAction func serviceCatChanged(_ sender: Any) {
        
        viewModel.serviceModel = []
        serviceList(search: serviceCatTextFld.text ?? "")

//        isServiceSearch = true
//        serviceSearchArray =  serviceNameArray.filter({$0.lowercased().contains(serviceCatTextFld.text?.lowercased() ?? "")})
//      /*  serviceNameArray = serviceNameArray.filter{
//            $0.lowercased().contains(serviceCatTextFld.text?.count ?? 0) == serviceCatTextFld.text?.lowercased()
//        }*/
//        if(serviceCatTextFld.text == ""){
//            serviceSearchArray = serviceNameArray
//            serviecCatTableHeight.constant = 0
//        }else{
//            serviecCatTableHeight.constant = 160
//        }
        self.serviceCatTable.reloadData()
        
        
    }
    
    @IBAction func branchBtn(_ sender: Any) {
        
        print(countryName)
        print(cityName)
        
        
        if CurrentSession.shared.isProfesstionalSignUp || isBranchAdd{
            if self.selectedServiceName.isEmpty {
                self.view.makeToast("Please Select Service Category")
            }else if self.countryName.isEmpty {
                self.view.makeToast("Please Select Country")
            } else if self.cityName.isEmpty {
                self.view.makeToast("Please Select City")
            } else {
              
                
                newCate = newCate.filter({(selectedServiceName.contains($0["name"] ?? ""))})
                
                print(newCate)
                
                self.dataService.services_products = self.selectedServiceIdArray
                self.dataService.serviceSubCategories = SelectedSubServiceIDArr
                self.dataService.newServiceCate = newCate
                self.dataService.serviceCountry = countryName
                self.dataService.serviceCity = cityName
                
                if btn1.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataService.serviceCost = "Upto 10000 AED"
                } else if btn2.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataService.serviceCost = "Upto 50000 AED"
                } else if btn3.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataService.serviceCost = "Upto 100000 AED"
                } else if btn4.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataService.serviceCost = "Upto 500000 AED"
                } else {
                    self.dataService.serviceCost = "More than 500000 AED"
                }
                
                if isBranchAdd{
                   self.hitApiAddBranch()
                }else{
                    
                    let vc = storyboard?.instantiateViewController(identifier: "BranchDetailViewController") as! BranchDetailViewController
                    vc.dataBranch = dataService
                    vc.isBranchAdd = self.isBranchAdd
                    self.navigationController?.pushViewController(vc, animated: true)
                }
 
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cityBtn(_ sender: Any) {
        if cityNameArray.isEmpty {
            self.view.makeToast("No city found.")
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountyPopUpViewController") as! CountyPopUpViewController
            vc.delegate = self
            vc.isCity = true
            vc.countryAndCity = cityNameArray
            let cardPopup = SBCardPopupViewController(contentViewController: vc)
            cardPopup.show(onViewController: self)
        }
    }
    
    @IBAction func countryBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountyPopUpViewController") as! CountyPopUpViewController
        vc.delegate = self
        vc.isCity = false
        vc.countryAndCity = countryNameArray
        vc.countryCode = codeNameArray
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    
    
    
    @IBAction func tapMainServiceList(_ sender: Any) {
        
        isService = true
        
        let vc = storyboard?.instantiateViewController(identifier: "ServiceListPopUpViewController") as! ServiceListPopUpViewController
        vc.nameArray = serviceNameArray
        vc.idArray = serviceIdArray
        vc.delegate = self
        let card = SBCardPopupViewController(contentViewController: vc)
        card.show(onViewController: self)
    }
    
    @IBAction func serviceListBtn(_ sender: Any) {
        
        isService = false
        
        let vc = storyboard?.instantiateViewController(identifier: "ServiceListPopUpViewController") as! ServiceListPopUpViewController
        vc.nameArray = subServiceNameArr
        vc.idArray = subServiceIDArr
        vc.delegate = self
        let card = SBCardPopupViewController(contentViewController: vc)
        card.show(onViewController: self)
    }
    
}

//MARK:- TableView Delegates

extension ServiceDetailViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(isServiceSearch == true){
//            return serviceSearchArray.count
//        }else{
//            return serviceNameArray.count
//        }
        
        return viewModel.serviceModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCatTableViewCell", for: indexPath) as! ServiceCatTableViewCell
//        if isServiceSearch == true{
//            cell.serviceName.text = serviceSearchArray[indexPath.row]
//        }else{
//        cell.serviceName.text = serviceNameArray[indexPath.row]
//        }
        cell.serviceName.text = viewModel.serviceModel[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        selectedServiceName.append(viewModel.serviceModel[indexPath.row].name ?? "")
       
        subServiceList(categoryId: viewModel.serviceModel[indexPath.row].id ?? "")
    
        self.serviceCatColl.reloadData()
//        self.serviceCatCollHeight.constant = 45
//        self.serviecCatTableHeight.constant = 0
        
    }
    
    
}


//MARK:- Collection View Delegates


extension ServiceDetailViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cityCollectionView {
            return cityName.count
        }else if collectionView == serviceCatColl{
            return selectedServiceName.count
        }else if collectionView == serviceSubCatColl {
            return SelectedSubServiceNameArr.count
        }
        else{
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
        }else if collectionView == serviceCatColl{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCountryCollectionViewCell
            cell.countryNameLabel.text = selectedServiceName[indexPath.row]
            cell.onDelete = {
                self.selectedServiceName.remove(at: indexPath.row)
                
               
                self.serviceCatColl.reloadData()
            }
            return cell

        }else if collectionView == serviceSubCatColl {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCountryCollectionViewCell
            cell.countryNameLabel.text = SelectedSubServiceNameArr[indexPath.row]
            cell.onDelete = {
                self.SelectedSubServiceNameArr.remove(at: indexPath.row)
                self.SelectedSubServiceIDArr.remove(at: indexPath.row)
                
                self.serviceSubCatColl.reloadData()
            }
            return cell
        } else {
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
extension ServiceDetailViewController{
    
    func hitApiAddBranch(){
        viewModel.apiAddBranch(FirstName: self.dataService.firstName!, LastName: self.dataService.lastName!, UserType: "professional", Email: self.dataService.email!, Password: self.dataService.password!, branchNameEn: self.dataService.branchNameEn!, branchNameAr: self.dataService.branchNameAr!, branchTypeId: self.dataService.branchTypeId!, branchCategoryId: self.dataService.branchCategoryId!, branchBrief: self.dataService.branchBrief!, branchProfile: self.dataService.branchProfile ?? "", certificateAward: self.dataService.certificateAward, country: self.dataService.country ?? "", country_ph_code: self.dataService.phoneCode ?? "", phoneNumber: self.dataService.phoneNumber ?? "", addFirstName: self.dataService.addFirstName ?? "", addLastName: self.dataService.addLastName ?? "", addLine1: self.dataService.addressLine1 ?? "", addLine2: self.dataService.addressLine2 ?? "", pincode: self.dataService.pincode ?? "", landmark: self.dataService.landmark ?? "", state: self.dataService.state ?? "", city: self.dataService.city ?? "", co_ordinator_eng: self.dataService.co_ordinator_eng ?? "", co_ordinator_arabic: self.dataService.co_ordinator_arabic ?? "", branchEmail: self.dataService.branchEmail ?? "", branchWebsite: self.dataService.branchWebsite ?? "", countryCode: self.dataService.countryCode ?? "", businessCountryCode: self.dataService.BusinessCountryCode ?? "", mobileNumber: self.dataService.mobileNumber ?? "", businessMobileNumber: self.dataService.businessMobileNumber ?? "", instaAccount: self.dataService.instaAccount ?? "", youtubeAccount: self.dataService.youtubeAccount ?? "", branchYear: self.dataService.branchYear ?? 0, issued_in_countries: self.dataService.issued_in_countries, issued_in_cities: self.dataService.issued_in_cities, branchLicence: self.dataService.branchLicence ?? "", licenceNumber: self.dataService.licenceNumber ?? "", no_of_emp: self.dataService.no_of_emp ?? "", serviceCategories: self.dataService.services_products, serviceSubCate: self.dataService.serviceSubCategories, newCategories: self.dataService.newServiceCate, serviceCountry: self.dataService.serviceCountry, serviceCity: self.dataService.serviceCity, serviceCost: self.dataService.serviceCost ?? "") { (isSuccess, message) in
            if isSuccess{
                self.showAlertWithAction(Title: "Dreeshah", Message: "Branch Inserted!", ButtonTitle: "OK") {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }else{
                self.showAlert(Title: "Dreeshah", Message: message, ButtonTitle: "Ok")
            }
        }
    }
    
 
}
