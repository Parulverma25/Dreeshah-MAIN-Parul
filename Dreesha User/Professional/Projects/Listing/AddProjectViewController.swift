//
//  AddProjectViewController.swift
//  Dreesha User
//
//  Created by Promatics on 17/04/21.
//

import UIKit
import SBCardPopup
import SDWebImage
class AddProjectViewController: UIViewController, TypeAndCategoryList, Year, Cost, Image_VideoPickerDelegate {
    
    
   
    
    
    
    func getCostValue(cost: String) {
        projectCost_txtfld.text = cost
    }
    
    func listData(name: String, isType: Bool, id: String?) {
        
    }
    
    func getYearValue(year: String) {
        projectYear_txtfld.text = year
        }
    
    //MARK:- Outltes
    
    @IBOutlet weak var selProject_TxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var ProjectDescriptionTxt: SkyFloatingLabelTextField!
    @IBOutlet weak var selProject_Btn: UIButton!
    @IBOutlet weak var projectName_TxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var projNameTF_align: NSLayoutConstraint!
    @IBOutlet weak var projectAddress_txtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var selCategoryCollView: UICollectionView!
    @IBOutlet weak var style_TxtFd: SkyFloatingLabelTextField!
    @IBOutlet weak var projectYear_txtfld: SkyFloatingLabelTextField!
    @IBOutlet weak var websiteLink_TxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var keywords_TxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var projectCost_txtfld: SkyFloatingLabelTextField!
    @IBOutlet weak var selectednotifyProfessionalIDs: UICollectionView!
    
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var SelProjectTab: UITableView!
    @IBOutlet weak var projectSearchBar: UISearchBar!
    @IBOutlet weak var projectTabHeight: NSLayoutConstraint!
    
    @IBOutlet weak var uploadImagesView: SetView!
    @IBOutlet weak var uploadImages_btn: UIButton!
    @IBOutlet weak var UploadedImages: UICollectionView!
    @IBOutlet weak var UploadedImgsHeight: NSLayoutConstraint!
    
    @IBOutlet weak var Professional_btn: UIButton!
    @IBOutlet weak var Services_btn: UIButton!
    @IBOutlet weak var Products_Btn: UIButton!
    
    @IBOutlet weak var subCategoryColl: UICollectionView!
    
    
    @IBOutlet weak var subCateBtn: UIButton!
    
    @IBOutlet weak var countryColl: UICollectionView!
    @IBOutlet weak var cityColl: UICollectionView!
    
    //MARK:- Variables
    
    var selectedBranchIds : [String]!
    var selectedBranchNames : [String]!
    
    
    
    var notifyBranchName = [String]()
    var notifyBranchIds = [String]()
    var selectedCategoryId = [String]()
    var selectedCategory = [String]()
    var selectedSubCategory = [String]()
    var selectedSubCategoryID = [String]()
    var selectedStyleId = ""
    var categoryidforSub = ""
    var prevView = ""
    var viewModel = AddProjectViewModel()
    var projectList = [String]()
    var projectListId = [String]()
    var SearchedProjectList: [String]!
    var SearchActive = false
    var categoryList: [String]!
    var categoryListId: [String]!
    var SubcategoryList: [String]!
    var SubcategoryListId: [String]!
    var StyleList: [String]!
    var StyleListId : [String]!
    
    var uploadedImagesArray = [UIImage]()
    var uploadedImagesDataArray = [Data]()
    var uploadeImageName = [String]()
    var imageType = [String]()
    var imageParam = [String]()
    var imagePicker = ImagePickerViewControler()
    var proj_Professional = false
    var proj_Service = true
    var proj_Product = false
    var project_KeyWords = [String]()
    var countryNameArray: [String] = []
    var codeNameArray: [String] = []
    var cityNameArray: [String] = []
    var countryName: [String] = []
    var countryId = [String]()
    var selectedCode: [String] = []
    var cityId = [String]()
    var cityName: [String] = []
    var viewModelP = SignupViewModel()
    //MARK:- View Did load
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        SelProjectTab.isHidden = true
        projectTabHeight.constant = 0
        SelProjectTab.delegate = self
        SelProjectTab.dataSource = self
        projectSearchBar.delegate = self
        selectednotifyProfessionalIDs.delegate = self
        selectednotifyProfessionalIDs.dataSource = self
        selCategoryCollView.delegate = self
        selCategoryCollView.dataSource = self
        countryColl.delegate = self
        countryColl.dataSource = self
        cityColl.delegate = self
        cityColl.dataSource = self
        subCategoryColl.delegate = self
        subCategoryColl.dataSource = self
        UploadedImages.delegate = self
        UploadedImages.dataSource = self
        UploadedImages.isHidden = true
        uploadImagesView.addShadow()
        if(prevView == "AddService"){
            selCategoryCollView.reloadData()
            categoryBtn.isUserInteractionEnabled = false
            subCategoryColl.reloadData()
            subCateBtn.isUserInteractionEnabled = false
        }
        //projectList = [String]()
       // projectList = ["ABC1", "BCD2", "DEFA3"]
       // categoryList = ["catg1","catg2","catg3"]
       // StyleList = ["Style1"]
      //  notifyList = ["N1", "Notf2", "N3", "notify4"]
        // Do any additional setup after loading the view.
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Add Project")
        hitAPIProfStyles()
        hitAPIProfCategory()
        
        hitAPIProffessionalsID()
        hitAPIgetProfProjects()
        country()
    }
   
    
   
    func listData(name: String, ListType: String, id: String?) {
        if ListType == "categoryList" {
            selectedCategory.append(name)
            selectedCategoryId.append(id!)
            selCategoryCollView.reloadData()
            hitAPIProfSubCategory(categoryId: id!)
        } else if ListType == "SubcategoryList"{
            selectedSubCategory.append(name)
            selectedSubCategoryID.append(id!)
            subCategoryColl.reloadData()
            
        } else if ListType == "StyleList"{
            style_TxtFd.text = name
            selectedStyleId = id!
        }
        else{
            notifyBranchName.append(name)
            notifyBranchIds.append(id!)
            selectednotifyProfessionalIDs.reloadData()
        }
    }
    
    func projectListTableHideUnhide(){
        SelProjectTab.isHidden = !SelProjectTab.isHidden
        if(SelProjectTab.isHidden){
            projectTabHeight.constant = 0
        }
        else{
            if(projectList.count>5){
                projectTabHeight.constant = 250
            }else{
                projectTabHeight.constant = CGFloat((projectList.count*40) + 50)
            }
        }
    }
    
    
    func setDataAccToProject(indexVal : Int){
        self.projectAddress_txtFld.text = viewModel.getProjList()[indexVal].projectAddress ?? ""
       // selCategory_TxtFld.text = viewModel.getProjList()[indexVal].projectCategory?.name ?? ""
        style_TxtFd.text = viewModel.getProjList()[indexVal].projectStyle?.name ?? ""
        projectYear_txtfld.text = String(viewModel.getProjList()[indexVal].projectYear ?? 0)
        projectCost_txtfld.text = String(viewModel.getProjList()[indexVal].projectCost ?? 0)
        websiteLink_TxtFld.text = viewModel.getProjList()[indexVal].projectWebsite ?? ""
        keywords_TxtFld.text = (viewModel.getProjList()[indexVal].projectKeyword?.map({$0.name ?? ""}))?.joined(separator: ", ")
       // self.selectedCategoryId = viewModel.getProjList()[indexVal].projectCategory?.id ?? ""
        self.selectedStyleId = viewModel.getProjList()[indexVal].projectStyle?.id ?? ""
        if viewModel.getProjList()[indexVal].projectPublishProfessional ?? false{
            Professional_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
            proj_Professional = true
        }else{
            Professional_btn.setImage(UIImage(named: "checkbox Off"), for: .normal)
            proj_Professional = false
        }
        
        if viewModel.getProjList()[indexVal].projectPublishServices ?? false{
            Services_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
            proj_Service = true
        }else{
            Services_btn.setImage(UIImage(named: "checkbox Off"), for: .normal)
            proj_Service = false
        }
        
        if viewModel.getProjList()[indexVal].projectPublishProduct ?? false{
            Products_Btn.setImage(UIImage(named: "checkbox On"), for: .normal)
            proj_Product = true
        }else{
            Products_Btn.setImage(UIImage(named: "checkbox Off"), for: .normal)
            proj_Product = false
        }
        
        for i in 0..<(viewModel.getProjList()[indexVal].projectImages?.count ?? 0){
            let url = URLS.projectImageUrl(viewModel.getProjList()[indexVal].projectImages?[i].name ?? "").getDescription()
            SDWebImageDownloader().downloadImage(with: URL(string: url)) { (image, data, error, success) in
                if error != nil{
                    print(error ?? "")
                }else{
                    self.uploadedImagesArray.append(image ?? UIImage())
                    self.uploadedImagesDataArray.append(data ?? Data())
                    self.imageType.append("image/jpeg")
                    self.imageParam.append("project_images")
                    self.uploadeImageName.append("Image\(self.uploadedImagesDataArray.count)")
                    self.UploadedImages.isHidden = false
                    self.UploadedImgsHeight.constant = 150
                    self.UploadedImages.reloadData()
                }
            }
        }
    }
    
    //MARK:- OBJC Function
    
    @objc func deselectBranch(_ sender: UIButton){
        selectedBranchNames.remove(at: sender.tag)
        selectedBranchIds.remove(at: sender.tag)
        selectednotifyProfessionalIDs.reloadData()
    }
    
    @objc func deselectCategory(_ sender: UIButton){
        self.selectedCategory.remove(at: sender.tag)
        self.selectedCategoryId.remove(at: sender.tag)
        selCategoryCollView.reloadData()
    }
    
    @objc func deselectSubCategory(_ sender: UIButton){
        self.selectedSubCategory.remove(at: sender.tag)
        self.selectedSubCategoryID.remove(at: sender.tag)
        subCategoryColl.reloadData()
    }
    
    @objc func deselectPhotos(_ sender: UIButton){
        uploadedImagesArray.remove(at: sender.tag)
     
        UploadedImages.reloadData()
    }

    //MARK:- IBActions
    
    @IBAction func viewSelectProjectTab(_ sender: Any) {
        projectListTableHideUnhide()
    }
    
    @IBAction func viewCategoryList(_ sender: Any) {
        if categoryList.count == 0 {
            self.view.makeToast("No category found.")
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BranchTypeAndCategoryPopUpViewController") as! BranchTypeAndCategoryPopUpViewController
            vc.ListType = "categoryList"
            vc.delegate = self
            vc.name = categoryList
            vc.id = categoryListId
            let cardPopup = SBCardPopupViewController(contentViewController: vc)
            cardPopup.show(onViewController: self)
        }
    }
    
    @IBAction func viewSubCategoryList(_ sender: UIButton) {
        if SubcategoryList.count == 0 {
            self.view.makeToast("No Subcategory found.")
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BranchTypeAndCategoryPopUpViewController") as! BranchTypeAndCategoryPopUpViewController
            vc.ListType = "SubcategoryList"
            vc.delegate = self
            vc.name = SubcategoryList
            vc.id = SubcategoryListId
            let cardPopup = SBCardPopupViewController(contentViewController: vc)
            cardPopup.show(onViewController: self)
        }
        
    }
    
    @IBAction func viewGetNoticedList(_ sender: UIButton) {
   
        if selectedBranchNames.count == 0 {
            self.view.makeToast("No Branch Found.")
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BranchTypeAndCategoryPopUpViewController") as! BranchTypeAndCategoryPopUpViewController
            vc.ListType = "notifyList"
            vc.delegate = self
            vc.name = selectedBranchNames
            vc.id = selectedBranchIds
            let cardPopup = SBCardPopupViewController(contentViewController: vc)
            cardPopup.show(onViewController: self)
        }
    }
    
    
    
    
    @IBAction func tapCountryList(_ sender: Any) {
        let vc =  UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(withIdentifier: "CountyPopUpViewController") as! CountyPopUpViewController
        vc.delegate = self
        vc.isCity = false
        vc.countryAndCity = countryNameArray
        vc.countryCode = codeNameArray
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    
    @IBAction func tapCityList(_ sender: Any) {
        
        let vc =  UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(withIdentifier: "CountyPopUpViewController") as! CountyPopUpViewController
        vc.delegate = self
        vc.isCity = true
        vc.countryAndCity = cityNameArray
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
        
    }
    
    @IBAction func viewStyleList(_ sender: Any) {
        if StyleList.isEmpty {
            self.view.makeToast("No Style found.")
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BranchTypeAndCategoryPopUpViewController") as! BranchTypeAndCategoryPopUpViewController
            vc.ListType = "StyleList"
            vc.delegate = self
            vc.name = StyleList//self.viewModel.getProfStyle()
            vc.id = StyleListId//self.viewModel.getProfStyle().id!
            let cardPopup = SBCardPopupViewController(contentViewController: vc)
            cardPopup.show(onViewController: self)
        }
    }
    
    @IBAction func SelectProjectYear(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "YearPopUpViewController") as! YearPopUpViewController
        vc.delegate = self
        let card = SBCardPopupViewController(contentViewController: vc)
        card.show(onViewController: self)
        
    }
    
    @IBAction func SelectProjectCost(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "CostPopUpViewController") as! CostPopUpViewController
        vc.delegate = self
        let card = SBCardPopupViewController(contentViewController: vc)
        card.show(onViewController: self)
        
    }
    
    
    @IBAction func selectImagestoUpload(_ sender: Any) {
        imagePicker.Image_Videos_PickerDelegate = self
        imagePicker.showImage_videoPicker(viewController: self)
        
    }
    
    func disFinishPickingforVid(imgData: Data, img: UIImage) {
        uploadedImagesArray.append(img)
        uploadedImagesDataArray.append(img.jpegData(compressionQuality: 0.6)!)
        imageType.append("image/jpeg")
        imageParam.append("project_images")
        uploadeImageName.append("Image\(uploadedImagesDataArray.count)")
        UploadedImages.isHidden = false
        UploadedImgsHeight.constant = 150
        UploadedImages.reloadData()
        print(uploadeImageName)
        print(uploadedImagesDataArray)
        print(imageType)
        print(imageParam)
        print("FOR IMAGES")
    }
    
    func didFinishVideoPickingforvid(videoData: Data, thumbnail: UIImage) {
        uploadedImagesArray.append(thumbnail)
        uploadedImagesDataArray.append(videoData)
        uploadeImageName.append(GenerateUniqueVideoName())
        imageType.append("video/mp4")
        imageParam.append("project_images")
        UploadedImages.isHidden = false
        UploadedImgsHeight.constant = 150
        UploadedImages.reloadData()
        print(uploadeImageName)
        print(uploadedImagesDataArray)
        print(imageType)
        print(imageParam)
        print("FOR Videos")
    }
    
    
    
    @IBAction func selectProfessionalPublish(_ sender: Any) {
        if(Professional_btn.currentImage == UIImage(named: "checkbox Off")){
            Professional_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
            proj_Professional = true
        }else{
            Professional_btn.setImage(UIImage(named: "checkbox Off"), for: .normal)
            proj_Professional = false
        }
    }
    
    @IBAction func selectServicePublish(_ sender: Any) {
        if(Services_btn.currentImage == UIImage(named: "checkbox On")){
            Services_btn.setImage(UIImage(named: "checkbox Off"), for: .normal)
            proj_Service = false
        }else{
            Services_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
            proj_Service = true
        }
    }
    
    @IBAction func SelectProductPublish(_ sender: Any) {
        if(Products_Btn.currentImage == UIImage(named: "checkbox Off")){
            Products_Btn.setImage(UIImage(named: "checkbox On"), for: .normal)
            proj_Product = true
        }else{
            Products_Btn.setImage(UIImage(named: "checkbox Off"), for: .normal)
            proj_Product = false
        }
    }
    
    
    @IBAction func publishProject(_ sender: Any) {
        var msg = ""
        if(projectName_TxtFld.text == ""){
            msg = "Please enter project Name."
        }
        
        else if(projectAddress_txtFld.text == ""){
            msg = "Please enter project address."
        }
        else if(selectedCategory.count == 0){
            msg = "Please select project category."
        }
        else if(style_TxtFd.text == ""){
            msg = "Please enter project style."
        }
        else if(projectYear_txtfld.text == ""){
            msg = "Please select project year."
        }
        else if(websiteLink_TxtFld.text == ""){
            msg = "Please enter project website link."
        }
        else if(keywords_TxtFld.text == ""){
            msg = "Please enter project keyords."
        }else if(uploadedImagesArray.count == 0){
            msg = "Please enter project Name."
        }
        if(msg != ""){
            self.showDefaultAlert(Message: msg)
        }
        else{
            for i in 0...uploadedImagesArray.count-1{
                uploadeImageName.append("\(projectName_TxtFld.text!)Image\(i+1)")
            }
            project_KeyWords = keywords_TxtFld.text!.components(separatedBy: ", ")
            hitAddProject()
        }

    }
    
    @IBAction func saveProject(_ sender: Any) {
    }
    
    @IBAction func saveProjectLater(_ sender: Any) {
    }
    
}

//MARK:- TableView Delegate

extension AddProjectViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == SelProjectTab{
            return projectList.count
        }else{
            return SearchedProjectList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == SelProjectTab{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectListTableViewCell", for: indexPath) as! ProjectListTableViewCell
            cell.projectName.text = projectList[indexPath.row]
            return cell
        }else{
            let cell =  tableView.dequeueReusableCell(withIdentifier: "projCell")
            if(SearchedProjectList.count>0){
                cell?.textLabel?.text = SearchedProjectList[indexPath.row]
            }
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == SelProjectTab{
            self.uploadedImagesArray.removeAll()
            self.uploadedImagesDataArray.removeAll()
            self.imageType.removeAll()
            self.imageParam.removeAll()
            selProject_TxtFld.text = projectList[indexPath.row]
            setDataAccToProject(indexVal: indexPath.row)
            projectListTableHideUnhide()
        }else{
            selProject_TxtFld.text = SearchedProjectList[indexPath.row]
        }
    }
}



extension AddProjectViewController: UISearchBarDelegate{
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       /* SearchedProjectList = projectList.filter {
            $0.lowercased().contains(searchBar.text!.count) == searchBar.text!.lowercased() }
        if(searchBar.text! == ""){
            SearchedProjectList = projectList
        }
        SearchActive = true
        projectSearchBar.showsCancelButton = true
        SelProjectTab.reloadData()*/
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       /* SearchedProjectList = projectList.filter {
            $0.lowercased().contains(searchText.count) == searchText.lowercased() }
        if(searchText == ""){
            SearchedProjectList = projectList
        }
        SearchActive = true
        projectSearchBar.showsCancelButton = true
        SelProjectTab.reloadData()*/
    }
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        SearchActive = false
//        projectSearchBar.showsCancelButton = false
//        projectSearchBar.text = ""
//        SelProjectTab.reloadData()
//    }
}

//MARK:- Collection View Delegates

extension AddProjectViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == selectednotifyProfessionalIDs){
            return notifyBranchName.count
        } else if collectionView == selCategoryCollView{
            return selectedCategory.count
        }else if collectionView == subCategoryColl{
            return selectedSubCategory.count
        }else if collectionView == cityColl{
            return cityName.count
        }else if collectionView == countryColl{
            return countryName.count
        }else{
            return uploadedImagesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == selectednotifyProfessionalIDs){
            let cell: NotifyBranchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NotifyBranchCell
            cell.BranchNameLabel.text = notifyBranchName[indexPath.row]
            cell.deselectBtn.tag = indexPath.row
            cell.deselectBtn.addTarget(self, action: #selector(deselectBranch(_:)), for: .touchUpInside)
            return cell
        }else if collectionView == selCategoryCollView{
            let cell: NotifyBranchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NotifyBranchCell
            cell.BranchNameLabel.text = selectedCategory[indexPath.row]
            cell.deselectBtn.tag = indexPath.row
            cell.deselectBtn.addTarget(self, action: #selector(deselectCategory(_:)), for: .touchUpInside)
            return cell
        } else if collectionView == subCategoryColl{
            let cell: SubCategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SubCategoryCollectionViewCell
            cell.BranchNameLabel.text = selectedSubCategory[indexPath.row]
            cell.deselectBtn.tag = indexPath.row
            cell.deselectBtn.addTarget(self, action: #selector(deselectSubCategory(_:)), for: .touchUpInside)
            return cell
        }else if collectionView == cityColl{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCityCollectionViewCell
            cell.cityNameLabel.text = cityName[indexPath.row]
            cell.onDelete = {
                self.cityName.remove(at: indexPath.row)
                self.cityId.remove(at: indexPath.row)
                self.cityColl.reloadData()
            }
            return cell
        }else if collectionView == countryColl{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCityCollectionViewCell
            cell.cityNameLabel.text = countryName[indexPath.row]
            cell.onDelete = {
                self.countryName.remove(at: indexPath.row)
                self.countryId.remove(at: indexPath.row)
                self.countryColl.reloadData()
                self.cityName.removeAll()
                self.cityColl.reloadData()
            }
            return cell
        }else{
            let cell : AddProjectImagesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as! AddProjectImagesCell
            cell.ProjImage.image = uploadedImagesArray[indexPath.row]
            cell.crossbtn.tag = indexPath.row
            cell.crossbtn.addTarget(self , action: #selector(deselectPhotos(_:)), for: .touchUpInside )
            return cell
        }
    }
}

//MARK:- API CALL

extension AddProjectViewController{
    
    func city(countryCode : [String]){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModelP.hitUserCity(CountryCode: countryCode){(isSuccess , message) in
        
            Indicator.shared.hideProgressView()
            if isSuccess {
                self.cityNameArray = (self.viewModelP.cityModel?.data?.map({$0.name ?? ""}))!
               // self.cityId = countryCode
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    func country() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModelP.hitUserCountry(){(isSuccess , message) in
        
            Indicator.shared.hideProgressView()
            if isSuccess{
                print(self.viewModelP.countryModel)
                self.countryNameArray = (self.viewModelP.countryModel?.data?.map({$0.name ?? ""}))!
                print(self.countryNameArray)
                self.codeNameArray = (self.viewModelP.countryModel?.data?.map({$0.isoCode ?? ""}))!
                
                print(self.codeNameArray)
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    func hitAPIgetProfProjects(){
        viewModel.apigetProjects { (isSuccess, message) in
            if isSuccess{
                self.projectList = self.viewModel.getProjList().map({$0.projectName ?? ""})
                self.projectListId = self.viewModel.getProjList().map({$0.projectListingModelID ?? ""})
                
                if(self.projectList.count == 0){
                    self.selProject_TxtFld.isHidden = true
                    self.selProject_Btn.isHidden = true
                    self.projNameTF_align.constant = -40
                }else{
                   
                }
                
                self.SelProjectTab.reloadData()
            }
        }
    }
    
    func hitAPIProfStyles(){
        viewModel.apigetStyles(){ (isSuccess, msg) in
            if(isSuccess){
                
                self.StyleList = self.viewModel.getProfStyle().map({$0.name ?? ""})
                self.StyleListId = self.viewModel.getProfStyle().map({$0.id ?? ""})
                
            }else{
                print("Hit Fail")
                self.view.makeToast(msg)
            }
        }
    }
    
    func hitAPIProfCategory(){
        viewModel.apigetCategory(){ (isSuccess, msg) in
            if(isSuccess){
                
                self.categoryList = self.viewModel.getProfCategory().map({$0.name ?? ""})
                self.categoryListId = self.viewModel.getProfCategory().map({$0.id ?? ""})
                
            }else{
                print("Hit Fail")
                self.view.makeToast(msg)
            }
        }
    }
    
    func hitAPIProfSubCategory(categoryId:String){
        viewModel.apiGetSubCategory(categoryId: categoryId){ (isSuccess, msg) in
            if(isSuccess){
                
                self.SubcategoryList = self.viewModel.getProfSubCategory().map({$0.name ?? ""})
                self.SubcategoryListId = self.viewModel.getProfSubCategory().map({$0.id ?? ""})
                
            }else{
                print("Hit Fail")
                self.view.makeToast(msg)
            }
        }
    }
    
    
    
//    func hitAPIProfBranch(){
//        viewModel.apigetBranches(){ (isSuccess, msg) in
//            if(isSuccess){
//
//                self.selectedBranchNames = self.viewModel.getProfBranch().map({$0.branchNameEn ?? ""})
//                self.selectedBranchIds = self.viewModel.getProfBranch().map({$0.id ?? ""})
//
//            }else{
//                print("Hit Fail")
//                self.view.makeToast(msg)
//            }
//        }
//    }
    
    func hitAPIProffessionalsID(){
        viewModel.apigetProfessionals(){ (isSuccess, msg) in
            if(isSuccess){
                
                self.selectedBranchNames = self.viewModel.ProfPaginationModel.map({$0.branchNameEn ?? ""})
                self.selectedBranchIds = self.viewModel.ProfPaginationModel.map({$0.id ?? ""})
                
            }else{
                print("Hit Fail")
                self.view.makeToast(msg)
            }
        }
    }
    
    
    func hitAddProject(){
        
        viewModel.apiAddProject(project_name: projectName_TxtFld.text ?? "",project_address: projectAddress_txtFld.text ?? "",ProDescription: ProjectDescriptionTxt.text ?? "" ,project_category: selectedCategoryId, project_style: selectedStyleId, project_year: Int(projectYear_txtfld.text ?? "") ?? 0, project_cost: Int(projectCost_txtfld.text ?? "") ?? 0, project_website: websiteLink_TxtFld.text!, project_keyword: project_KeyWords, project_images: uploadedImagesDataArray, project_images_Name: uploadeImageName, project_images_Type: imageType, project_images_Param: imageParam,  project_publish_product: proj_Product, project_publish_professional: proj_Professional, project_publish_services: proj_Service, notify_professional_ids: selectedBranchIds, projectCountries: countryName, projectCities: cityName, projectCate: selectedCategoryId, projectSubCate: selectedSubCategoryID) { (isSuccess, msg) in
            if(isSuccess){
//                self.showDefaultAlert(Message: msg)
                self.showAlertWithAction(Title: "Dreeshah", Message: msg, ButtonTitle: "OK") {
                self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                self.showDefaultAlert(Message: msg)
            }
            
        }
        
      
    }
}

//MARK:- Get Country And City
extension AddProjectViewController : CountryList{
    func countries(name: [String], isCity: Bool, code: [String]) {
        if !isCity {
            if name.count > 0 {
                
                self.countryName = name
                self.countryId = code
                countryColl.reloadData()
                countryColl.isHidden = false
                
                
                
                selectedCode = code
                self.city(countryCode: selectedCode)
                self.cityName.removeAll()
                cityColl.reloadData()
            } else {
//                collectionView.isHidden = true
//                countryLabel.isHidden = true
//                countryHighLightLabel.isHidden = false
            }
        } else {
            if name.count > 0 {
               
                self.cityName = name
                self.cityId = code
                cityColl.reloadData()
                cityColl.isHidden = false
               
            } else {
//                cityCollectionView.isHidden = true
//                cityLabel.isHidden = true
//                cityHighlightLabel.isHidden = false
            }
        }
    }
    
    
}

//API TO SEND AND GET ARRAY OF SELECTED CATEGORY AND ITS ID
