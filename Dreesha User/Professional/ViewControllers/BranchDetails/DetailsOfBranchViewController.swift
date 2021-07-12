//
//  DetailsOfBranchViewController.swift
//  Dreesha User
//
//  Created by promatics on 21/04/21.
//

import UIKit

class DetailsOfBranchViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var genralCertificatesTable: UITableView!
    @IBOutlet weak var branchLicenseTable: UITableView!
    @IBOutlet weak var lstOfServiceTable: UITableView!
    
    @IBOutlet weak var businessCountriesColl: UICollectionView!
    @IBOutlet weak var businessCitiesColl: UICollectionView!
    @IBOutlet weak var serCountryColl: UICollectionView!
    @IBOutlet weak var serCityColl: UICollectionView!
    
    
    @IBOutlet weak var genCerTableHeight: NSLayoutConstraint!
    @IBOutlet weak var lstOfSerTableHeight: NSLayoutConstraint!
    
    //MARK:- General Details Outlets
    @IBOutlet weak var profileImage: SetImage!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNamelbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var branchNameEng: UILabel!
    @IBOutlet weak var branchNameArabic: UILabel!
    @IBOutlet weak var branchType: UILabel!
    @IBOutlet weak var branchBrief: UILabel!
    @IBOutlet weak var branchCate: UILabel!
    
    //MARK:- Address Details Outlets
    @IBOutlet weak var pincodeLbl: UILabel!
    @IBOutlet weak var flatNoLbl: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var landmarkLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var statelbl: UILabel!
    
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var phoneNumberLabl: UILabel!
    @IBOutlet weak var addFirstName: UILabel!
    
    @IBOutlet weak var addLastName: UILabel!
    //MARK:- Contact Details Outlets
    @IBOutlet weak var coOrdinatorName: UILabel!
    @IBOutlet weak var branchEmailLbl: UILabel!
    @IBOutlet weak var branchWebsitelb: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var branchMobileNo: UILabel!
    @IBOutlet weak var instaId: UILabel!
    @IBOutlet weak var youtubeId: UILabel!
    
    //MARK:- Business Details Outlets
    @IBOutlet weak var branchEstaYear: UILabel!
    @IBOutlet weak var licenceNumberLbl: UILabel!
    @IBOutlet weak var noOfEmp: UILabel!
    
    //MARK:- Service Details Outlets
    @IBOutlet weak var typicalSerLbl: UILabel!
    
    
    
    
    //MARK:- Variable
    
    var countryName = ["e" , "f"]
    var Cities = ["g" , "h"]
    var BcountryName = ["e" , "f"]
    var BCities = ["g" , "h"]
    var branchId = ""
    var serviceModel = SignupViewModel()
    var serviceNameArray: [String] = []
    var serviceIdArray: [String] = []
    var viewModel = DetailsOfBranchViewModel()
    var resultServiceNameArray: [String] = []
    var resultServiceIdArray: [String] = []
    
    //MARK:- DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        branchLicenseTable.delegate = self
        branchLicenseTable.dataSource = self
        genralCertificatesTable.delegate = self
        genralCertificatesTable.dataSource = self
        lstOfServiceTable.delegate = self
        lstOfServiceTable.dataSource = self
        
        businessCitiesColl.delegate = self
        businessCountriesColl.delegate = self
        businessCitiesColl.dataSource = self
        businessCountriesColl.dataSource = self
        serCityColl.delegate = self
        serCountryColl.delegate = self
        serCityColl.dataSource = self
        serCountryColl.dataSource = self
        getBranchDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Branches")
        
    }
    
    //MARK:- Custom Functions
    
    func SetData(){
        
        let url = URLS.profileImageUrl(viewModel.getBranchDetails()?.branchProfile ?? "").getDescription()
        profileImage.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "Image Gallery"))
        
        firstNameLbl.text = viewModel.getBranchDetails()?.firstName ?? ""
        lastNamelbl.text = viewModel.getBranchDetails()?.lastName ?? ""
        emailLbl.text = viewModel.getBranchDetails()?.email ?? ""
        branchNameEng.text = viewModel.getBranchDetails()?.branchNameEn ?? ""
        branchNameArabic.text = viewModel.getBranchDetails()?.branchNameAr ?? ""
        branchType.text = viewModel.getBranchDetails()?.branchTypeID?.name ?? ""
        branchBrief.text = viewModel.getBranchDetails()?.branchBrief ?? ""
        branchCate.text = viewModel.getBranchDetails()?.branchCategoryID?.name ?? ""
        
        pincodeLbl.text = String(viewModel.model?.branchAddress?.pincode ?? 0)
        
        
        landmarkLbl.text = viewModel.model?.branchAddress?.landmark ?? ""
        cityLbl.text = viewModel.model?.branchAddress?.city ?? ""
        statelbl.text = viewModel.model?.branchAddress?.state ?? ""
        countryNameLbl.text = viewModel.model?.branchAddress?.country ?? ""
        phoneNumberLabl.text = "\(viewModel.model?.branchAddress?.countryPhCode ?? "")-\(viewModel.model?.branchAddress?.phoneNumber ?? "")"
        
        firstNameLbl.text = viewModel.model?.branchAddress?.addrFirstName ?? ""
        lastNamelbl.text = viewModel.model?.branchAddress?.addrLastName ?? ""
        
        flatNoLbl.text = viewModel.model?.branchAddress?.addressLine1 ?? ""
        
        areaLbl.text = viewModel.model?.branchAddress?.addressLine2 ?? ""
        
        coOrdinatorName.text = viewModel.getBranchDetails()?.contactDetails?.coOrdinatorEng ?? ""
        branchEmailLbl.text = viewModel.getBranchDetails()?.contactDetails?.branchEmail ?? ""
        branchWebsitelb.text = viewModel.getBranchDetails()?.contactDetails?.branchWebsite ?? ""
        mobileLbl.text = viewModel.getBranchDetails()?.contactDetails?.mobileNumber ?? ""
        branchMobileNo.text = (viewModel.getBranchDetails()?.contactDetails?.businessCountryCode ?? "") + "-\(viewModel.getBranchDetails()?.contactDetails?.businessMobileNumber ?? "")"
        instaId.text = viewModel.getBranchDetails()?.contactDetails?.instaAcc ?? ""
        youtubeId.text = viewModel.getBranchDetails()?.contactDetails?.youtubeChannel ?? ""
        
        branchEstaYear.text = String(viewModel.getBranchDetails()?.businessDetails?.branchYear ?? 0)
        licenceNumberLbl.text = viewModel.getBranchDetails()?.businessDetails?.licenceNumber ?? ""
        noOfEmp.text = viewModel.getBranchDetails()?.businessDetails?.noOfEmp ?? ""
        
        typicalSerLbl.text = viewModel.getBranchDetails()?.serviceDetails?.serviceCost ?? ""
    }
    
    //MARK:- IB ACTIONS
    
    
    @IBAction func tapEditGeneralDetails(_ sender: Any) {
        let vc = UIStoryboard(name: "EditProfessionalStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "EditGeneralDeatilsViewController") as! EditGeneralDeatilsViewController
        

        vc.isEdit = false
        vc.branchVM = viewModel
        vc.branchTypeVal = self.branchType.text ?? ""
        vc.branchCat = self.branchCate.text ?? ""
        vc.branchId = self.branchId
        navigationController?.pushViewController(vc, animated: true)
    }
    
   
    @IBAction func tapEditAddressDetails(_ sender: Any) {
        let vc = UIStoryboard(name: "EditProfessionalStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "EditAddressDetailsViewController") as! EditAddressDetailsViewController
        

        vc.isEdit = false
        vc.branchVM = viewModel
       
        vc.branchId = self.branchId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func tapEditContactDetails(_ sender: Any) {
        
        let vc = UIStoryboard(name: "EditProfessionalStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "EditContactDetailsViewController") as! EditContactDetailsViewController
        

        vc.isEdit = false
        vc.branchVM = viewModel
       
        vc.branchId = self.branchId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func tapEditBuisnessDetails(_ sender: Any) {
        let vc = UIStoryboard(name: "EditProfessionalStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "EditBuisnessDetailsViewController") as! EditBuisnessDetailsViewController
        vc.isEdit = false
        vc.branchVM = viewModel
       
        vc.branchId = self.branchId
        vc.countryName = BcountryName
        vc.cityName = BCities
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func tapEditServiceDetails(_ sender: Any) {
        let vc = UIStoryboard(name: "EditProfessionalStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "EditServiceDetailsViewController") as! EditServiceDetailsViewController
        vc.isEdit = false
        vc.branchVM = viewModel
       
        vc.branchId = self.branchId
        vc.countryName = countryName
        vc.cityName = Cities
        vc.editServiceNameArray = resultServiceNameArray
        vc.EditServiceIdArray = resultServiceIdArray
        vc.editSubServiceNameArray = viewModel.getBranchDetails()?.serviceCategories?.map({$0.name ?? ""}) ?? []
        vc.editSubServiceIDArray = viewModel.getBranchDetails()?.serviceSubcategories?.map({$0.id ?? ""}) ?? []
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK:- TableView Delegates
extension DetailsOfBranchViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == genralCertificatesTable{
            return viewModel.getBranchDetails()?.branchCertificates?.count ?? 0
        }else if tableView == lstOfServiceTable{
            return viewModel.getBranchDetails()?.serviceCategories?.count ?? 0
        }
        else{
            return 1
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       
        if tableView == genralCertificatesTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CerImagesTableViewCell", for: indexPath) as! CerImagesTableViewCell
            let url = URLS.certificateImageUrl(viewModel.getBranchDetails()?.branchCertificates?[indexPath.row].image ?? "").getDescription()
            cell.imae.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "checkbox Off"))
            cell.name.text = viewModel.getBranchDetails()?.branchCertificates?[indexPath.row].image ?? ""
            return cell
        }else if tableView == lstOfServiceTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListofSerTableViewCell", for: indexPath) as! ListofSerTableViewCell
            cell.serviceName.text = serviceNameArray[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CerImagesTableViewCell", for: indexPath) as! CerImagesTableViewCell
            let url = URLS.certificateImageUrl(viewModel.getBranchDetails()?.businessDetails?.branchLicence ?? "").getDescription()
            cell.imae.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "checkbox Off"))
            cell.name.text = viewModel.getBranchDetails()?.businessDetails?.branchLicence ?? ""
            return cell
        }
      
    }
    
    
}

//MARK:- Collection View Delegates
extension DetailsOfBranchViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == businessCountriesColl{
            return viewModel.getBranchDetails()?.businessDetails?.issuedInCountries?.count ?? 0
        }else if collectionView == businessCitiesColl{
            return viewModel.getBranchDetails()?.businessDetails?.issuedInCities?.count ?? 0
        }else if collectionView == serCountryColl{
            return viewModel.getBranchDetails()?.serviceDetails?.serviceCountry?.count ?? 0
        }else{
            return viewModel.getBranchDetails()?.serviceDetails?.serviceCity?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cityTagsCollectionViewCell", for: indexPath) as! cityTagsCollectionViewCell
        if collectionView == businessCountriesColl{
            cell.name.text = viewModel.getBranchDetails()?.businessDetails?.issuedInCountries?[indexPath.row] ?? ""
        }else if collectionView == businessCitiesColl{
            cell.name.text = viewModel.getBranchDetails()?.businessDetails?.issuedInCities?[indexPath.row] ?? ""
        }else if collectionView == serCountryColl{
            cell.name.text = viewModel.getBranchDetails()?.serviceDetails?.serviceCountry?[indexPath.row] ?? ""
        }else{
            cell.name.text = viewModel.getBranchDetails()?.serviceDetails?.serviceCity?[indexPath.row] ?? ""
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.businessCitiesColl.bounds.width / 3 - 2, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
  
    
    
}



//MARK:- API Call
extension DetailsOfBranchViewController {
    func getBranchDetails(){
        viewModel.apiBranchDetails(BranchId: self.branchId) { (isSuccess, message) in
            if isSuccess{
                self.serviceListData()
                self.SetData()
                self.branchLicenseTable.reloadData()
                self.genralCertificatesTable.reloadData()
                
                self.countryName.removeAll()
                self.Cities.removeAll()
                
                self.countryName.insert(contentsOf: (self.viewModel.getBranchDetails()?.serviceDetails?.serviceCountry)!, at: 0)
                self.Cities.insert(contentsOf: (self.viewModel.getBranchDetails()?.serviceDetails?.serviceCity)!, at: 0)
                
                self.BcountryName.removeAll()
                self.BCities.removeAll()
                
                self.BcountryName.insert(contentsOf: (self.viewModel.getBranchDetails()?.businessDetails?.issuedInCountries)!, at: 0)
                self.BCities.insert(contentsOf: (self.viewModel.getBranchDetails()?.businessDetails?.issuedInCities)!, at: 0)
                
                self.updateTableHeight(tableName: self.genralCertificatesTable, tableHeight: self.genCerTableHeight)
               
                self.businessCitiesColl.reloadData()
                self.businessCountriesColl.reloadData()
                self.serCityColl.reloadData()
                self.serCountryColl.reloadData()
                
              
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    func serviceListData() {
        Indicator.shared.showProgressView(self.view)
        serviceModel.hitServiceList(search: "") { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess {
                self.resultServiceNameArray.removeAll()
                self.resultServiceIdArray.removeAll()
//                self.serviceNameArray = (self.serviceModel.serviceModel?.data?.first(where: {$0.id == self.viewModel.dataModel?.data?.serviceDetails?.servicesProducts})?.name)!
                
                self.serviceNameArray = (self.serviceModel.serviceModel.map({$0.name ?? "" }))
                print(self.serviceNameArray)
                self.serviceIdArray = (self.serviceModel.serviceModel.map({$0.id ?? "" }))
                print(self.serviceIdArray)
                
                for i in 0..<(self.viewModel.getBranchDetails()?.serviceCategories?.count)! {
                    for j in 0..<self.serviceIdArray.count {
                        if self.viewModel.getBranchDetails()?.serviceCategories?[i].id == self.serviceIdArray[j] {
                            self.resultServiceNameArray.append(self.serviceNameArray[j])
                            self.resultServiceIdArray.append(self.serviceIdArray[j])
                        }
                    }
                }
                print(self.resultServiceNameArray)
                self.lstOfServiceTable.reloadData()
                self.updateTableHeight(tableName: self.lstOfServiceTable, tableHeight: self.lstOfSerTableHeight)
            }
        }
    }
}


//MARK:- UIVIewController Extension
extension UIViewController{
    func updateTableHeight(tableName : UITableView , tableHeight : NSLayoutConstraint){
        var frame = tableName.frame
        frame.size.height = tableName.contentSize.height
        tableName.frame = frame
        tableName.reloadData()
        tableName.layoutIfNeeded()
        tableHeight.constant = CGFloat(tableName.contentSize.height + 20)
        
    }
}
