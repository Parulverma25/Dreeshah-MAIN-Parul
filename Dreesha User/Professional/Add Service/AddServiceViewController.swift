//
//  AddServiceViewController.swift
//  Dreesha User
//
//  Created by Apple on 01/04/21.
//

import UIKit
import AnimatedField
import SBCardPopup

let window = UIApplication.shared.windows.last!
struct Cities{
    var city: String
}
struct Projects{
    var project_id: String
}
class AddServiceViewController: UIViewController,CountryList, addImage {
    
    
    @IBOutlet weak var otherPhtoHeight: NSLayoutConstraint!
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    var shownImage : UIImage!
    @IBOutlet weak var addrelatedPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var otherPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var otherPhotosCollectionView : UICollectionView!
    @IBOutlet weak var relatedPhtoHeight: NSLayoutConstraint!
    @IBOutlet weak var relatedPhotoColletionView : UICollectionView!
    @IBOutlet weak var popUpOuterVIEW : UIView!
    @IBOutlet weak var countryHighLightLabel: UILabel!
    @IBOutlet weak var upperServiceLbl: UILabel!
    @IBOutlet weak var downServicelbl: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityHighlightLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var certificateLBL : UILabel!
    @IBOutlet weak var certificateName: UILabel!
    @IBOutlet weak var downSubService: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var showProjectsColletionView: UICollectionView!
    @IBOutlet weak var upperSubService: UILabel!
    @IBOutlet weak var popUpTabHeading: UILabel!
    @IBOutlet weak var popUpTableview : UITableView!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    @IBOutlet weak var serviceName: SkyFloatingLabelTextField!
    @IBOutlet weak var serviceCatCollView: UICollectionView!
    @IBOutlet weak var serviceSubCatCollView: UICollectionView!
    @IBOutlet weak var price: SkyFloatingLabelTextField!
    @IBOutlet weak var certificateBtnss: UIButton!

    @IBOutlet weak var durationLbl: SkyFloatingLabelTextField!
    @IBOutlet weak var Discription: UITextView!
    @IBOutlet weak var customers: UIButton!
    
    
    @IBOutlet weak var agreementBtn: UIButton!
    @IBOutlet weak var professionalBtn: UIButton!
    
    @IBOutlet weak var lowerSelectBranch: UILabel!
    @IBOutlet weak var upperSelectBranch: UILabel!
    
    @IBOutlet weak var branchCollection: UICollectionView!
    
    @IBOutlet weak var tagsTextField: SkyFloatingLabelTextField!
    
    //MARK: Variables
    
    var imagePickerData : Int!
    var imageVM = SignupViewModel()
    var serviceDataArrayAR :[String]!
    var serviceDataArrayIDAR :[String]!
    var valueForTabSelected : Int!
    var valueForSelectedCat : Int!
    var countryDAtaAR :[String]!
    var cityDataAR :[String]!
    var countryNameArray: [String] = []
    var codeNameArray: [String] = []
    var cityNameArray: [String] = []
    var selectedCode: [String] = []
    var viewModelForService = ServiceCategoryViewModel()
    var viewModel = AddProjectViewModel()
    var countryName: [String] = []
    var countryId = [String]()
    var cityId = [String]()
    var cityName: [String] = []
    var serviceSubCategories: [String] = []
    var serviceSubCategoriesId: [String] = []
    var selectedServiceCategory: [String] = []
    var selectedServiceCategoryId: [String] = []
    var selectedServiceSubCategory: [String] = []
    var selectedServiceSubCategoryId: [String] = []
    var priceArray = ["Upto 100000 AED", "Upto 50000 AED", "Upto 1000000 AED", "Upto 500000 AED", "More than 500000 AED"]
    var selectedPrice = ""
    var viewModelP = SignupViewModel()
    var projects = ProjectBySubCategoryModel()
    var imageData = Data()
    var imgDescription = ""
   // var imageDataArrayOther = [Data()]
    var imagePicker = ImagePickerViewControler()
    var imagePickerForRelated = ImagePickerViewControler()
    var addserviceVM = AddServiceARViewModel()
    var otherImageArray = [UIImage]()
    var relatedImageArray = [UIImage]()
    var relatedImgDataArray = [Data]()
    var otherImageDataArray = [Data]()
    var ImageType = [String]()
    var ImagesData = [Data]()
    var ImagesName = [String]()
    var ImagesParam = [String]()
    var otherImgDescriptionArray = [String]()
    var relatedImgDescriptionArray = [String]()
    var ServiceImgData : Data!
    var projectIds = [[String : String]]()//[NSString]()//[Projects]()
    
    var professionalCount = 1
    var customerCount = 1
    var professionalValue = false
    var customerValue = false
    var agreementValue = false
    var projectPrice = ""
    
    
    var serviceImgString = ""
    var RelatedImagewithDesc = [[String: String]]()
    var OtherImgWithDec = [[String : String]]()
    
    var branchVM = AddedBranchesViewModel()
    
    var selectedBranchName = [String]()
    var selectedBranchId = ""
    
    func getImageValues(image: UIImage, imgData: Data, imgName: String, imgDescription: String) {
        if self.imagePickerData == 1{
            imageData = image.jpegData(compressionQuality: 0.6)!
            self.imgDescription = imgDescription
            ServiceImgData = imageData
            uploadImage()
           // serviceImgString = uploadImage()
            certificateBtnss.setImage(image, for: .normal)
            self.shownImage = image
            certificateName.text = imgDescription
        }else if self.imagePickerData == 2{
            imageData = image.jpegData(compressionQuality: 0.6)!
            self.imgDescription = imgDescription
            uploadImage()
            relatedImgDataArray.append(imageData)
            let uploadImgName = uploadImage()
            //let imgWithDesc = ["image_name" : uploadImgName, "description": imgDescription]
          //  RelatedImagewithDesc.append(imgWithDesc)
            
            relatedImageArray.append(image)
            relatedImgDescriptionArray.append(imgDescription)
            self.relatedPhtoHeight.constant = 140
            relatedPhotoColletionView.reloadData()
        }else if self.imagePickerData == 3{
            imageData = image.jpegData(compressionQuality: 0.6)!
            self.imgDescription = imgDescription
            uploadImage()
            otherImageDataArray.append(imageData)
          //  let imgWithDesc = ["image_name" : uploadImage(), "description": imgDescription]
           // OtherImgWithDec.append(imgWithDesc)
            
            otherImageArray.append(image)
            otherImgDescriptionArray.append(imgDescription)
            self.otherPhotoHeight.constant = 140
            otherPhotosCollectionView.reloadData()
        }
    }
    
    func selectImage() {
        imagePicker.imagePickerDelegete = self
        imagePicker.showImagePicker(viewController: self)
    }
    
    func countries(name: [String], isCity: Bool, code: [String]) {
        if !isCity {
            if name.count > 0 {
                countryDAtaAR = name
                self.countryName = name
                self.countryId = code
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
                cityDataAR = name
                self.cityName = name
                self.cityId = code
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


    var arrName = ["interior Design", "Exterior Design"]
        
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.isHidden = true
        countryLabel.isHidden = true
        cityCollectionView.isHidden = true
        cityLabel.isHidden = true
        upperSelectBranch.isHidden = true
        branchCollection.isHidden = true
        serviceCatCollView.isHidden = true
        serviceSubCatCollView.isHidden = true
        serviceCatCollView.delegate = self
        serviceCatCollView.dataSource = self
        serviceSubCatCollView.delegate = self
        serviceSubCatCollView.dataSource = self
        branchCollection.delegate = self
        branchCollection.dataSource = self
        country()
        getBranchList()
        Discription.allowsEditingTextAttributes = true
    }
//MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Add Service")
        hitServiceCategoryApi()
        if relatedImageArray.count == 0
        {
            self.relatedPhtoHeight.constant = 0
          
        }else
        {
            self.relatedPhtoHeight.constant = 140
        }
        if otherImageArray.count == 0
        {
            self.otherPhotoHeight.constant = 0
          
        }else
        {
            self.otherPhotoHeight.constant = 140
        }
        self.projects = []
        self.projectIds = []
        getProjectBySubCategories()
    }
    //MARK:- IBACTIONS
    
    @IBAction func professionalActn(_ sender: UIButton) {
        self.professionalCount = professionalCount + 1
        if professionalCount % 2 == 0
        {
           professionalValue = true
            professionalBtn.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
        }else
        {
            professionalBtn.setImage(#imageLiteral(resourceName: "checkbox Off"), for: .normal)
            professionalValue = false
        }
            
    }
    
    @IBAction func agreementActn(_ sender: Any) {
        if !agreementValue{
            agreementBtn.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
            agreementValue = true
        }else{
            agreementBtn.setImage(#imageLiteral(resourceName: "checkbox Off"), for: .normal)
            agreementValue = false
        }
    }
    
    @IBAction func viewAppTC(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Terms_ConditionViewController") as! Terms_ConditionViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
   
    @IBAction func customersAction(_ sender: UIButton) {
        self.customerCount = customerCount + 1
        if customerCount % 2 == 0
        {
           customerValue = true
            customers.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
        }else
        {
            customers.setImage(#imageLiteral(resourceName: "checkbox Off"), for: .normal)
            customerValue = false
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

    @IBAction func addProject(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "AddProjectViewController") as! AddProjectViewController
        vc.prevView = "AddService"
        vc.selectedCategory = selectedServiceCategory
        vc.selectedCategoryId = selectedServiceCategoryId
        vc.selectedSubCategory = selectedServiceSubCategory
        vc.selectedSubCategoryID = selectedServiceSubCategoryId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addCertificate(_ sender: UIButton){
        imagePickerData = 1
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddImagePopUpViewController") as! AddImagePopUpViewController
        vc.delegate = self
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
        //self.imagePicker.imagePickerDelegete = self
        //self.imagePicker.showImagePicker(viewController: self)
    }
    @IBAction func selectSubService(_ sender: UIButton) {
        if selectedServiceCategoryId.count > 0
       {
        valueForTabSelected = 1
        self.popUpTabHeading.text = "Service Sub Category"
        self.popUpTableview.reloadData()
        popUpOuterVIEW.frame = window.frame

        window.addSubview(popUpOuterVIEW)
       }else
       {
        self.view.makeToast("Select Service First")
       }
    }
    
    @IBAction func tapGetBranchList(_ sender: Any) {
        valueForTabSelected = 3
        self.popUpTabHeading.text = "Branch list"
        self.popUpTableview.reloadData()
        popUpOuterVIEW.frame = window.frame
        window.addSubview(popUpOuterVIEW)
    }
    
    
    @IBAction func selectServiceBTn(_ sender: Any) {
        valueForTabSelected = 0
        self.popUpTabHeading.text = "Service Category"
        self.popUpTableview.reloadData()
        popUpOuterVIEW.frame = window.frame
        window.addSubview(popUpOuterVIEW)
    }

    @IBAction func selectPriceAmnt(_ sender: Any) {
        valueForTabSelected = 2
        self.popUpTabHeading.text = "Price"
        self.popUpTableview.reloadData()
        popUpOuterVIEW.frame = window.frame
        window.addSubview(popUpOuterVIEW)
    }
    
    @IBAction func relatedPhtoBtn(_ sender: UIButton) {
        let index = sender.tag
        relatedImageArray.remove(at: index )
        RelatedImagewithDesc.remove(at: index)
        relatedImgDescriptionArray.remove(at: index)
        relatedImgDataArray.remove(at: index)
        relatedPhotoColletionView.reloadData()
    }
    @IBAction func otherPhtoBtn(_ sender: UIButton)
    {
        let index = sender.tag
        otherImageArray.remove(at: index )
        OtherImgWithDec.remove(at: index)
        otherImageDataArray.remove(at: index)
        otherImgDescriptionArray.remove(at: index)
        otherPhotosCollectionView.reloadData()
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
    @IBAction func addOtherPhotos(_ sender: UIButton) {
        imagePickerData = 3
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddImagePopUpViewController") as! AddImagePopUpViewController
        vc.delegate = self
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    
    @IBAction func addRelatedPhotos(_ sender: UIButton) {
        imagePickerData = 2
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddImagePopUpViewController") as! AddImagePopUpViewController
        vc.delegate = self
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    
    @IBAction func tapPreviewBtn(_ sender: Any) {
        var msg = ""
        if serviceName.text == ""{
            msg = "Please enter service name"
        }else if Discription.text == ""{
            msg = "Please enter service description"
        }else if countryNameArray.count == 0{
            msg = "Please select country"
        }else if cityNameArray.count == 0{
            msg = "Please select city"
        }else if selectedServiceCategoryId.count == 0{
            msg = "Please select service category"
        }else if selectedServiceSubCategoryId.count == 0{
            msg = "Please select service sub-category"
        }else if projects.count == 0{
            msg = "Please add project"
        }else if price.text == ""{
            msg = "Please select price"
        }else if durationLbl.text == ""{
            msg = "Please enter duration"
        }else if certificateBtnss.currentImage == UIImage(named: ""){
            msg = "Please add service image"
        }else if agreementValue != true{
            msg = "Please agree to our TERMS AND CONDITIONS "
        }
        if msg != ""{
            self.showDefaultAlert(Message: msg)
        }else{
            
            ImagesData.append(ServiceImgData)
            ImageType.append("image/jpeg")
            ImagesName.append(certificateLBL.text ?? "")
            ImagesParam.append("service_image")
            for i in 0...relatedImageArray.count-1{
                ImagesData.append(relatedImgDataArray[i])
                ImagesName.append(relatedImgDescriptionArray[i])
                ImageType.append("image/jpeg")
                ImagesParam.append("related_images")
            }
            for i in 0...otherImageDataArray.count-1{
                ImagesData.append(otherImageDataArray[i])
                ImagesName.append(otherImgDescriptionArray[i])
                ImageType.append("image/jpeg")
                ImagesParam.append("other_images")
            }
            if(price.text == priceArray[0]){
                projectPrice = "10000"
            }else if(price.text == priceArray[1]){
                projectPrice = "50000"
            }else if(price.text == priceArray[2]){
                projectPrice = "100000"
            }else if(price.text == priceArray[3]){
                projectPrice = "500000"
            }else if(price.text == priceArray[4]){
                projectPrice = "500000"
            }
            let vc = storyboard?.instantiateViewController(identifier: "ProfServiceDetailsViewController") as! ProfServiceDetailsViewController
            vc.relatedImg = relatedImageArray
            vc.otherImg = otherImageArray
            vc.projects = projects
            vc.serviceImg  = certificateBtnss.currentImage!
            vc.serviceName = serviceName.text!
            vc.servicePrice = "AED \(projectPrice)"
            vc.serviceDuration = durationLbl.text!
            vc.serviceCountries = countryName
            vc.serviceCities = cityName
            vc.viewType = "Preview"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func submitBtn(_ sender: UIButton) {
        var msg = ""
        if serviceName.text == ""{
            msg = "Please enter service name"
        }else if Discription.text == ""{
            msg = "Please enter service description"
        }else if countryNameArray.count == 0{
            msg = "Please select country"
        }else if cityNameArray.count == 0{
            msg = "Please select city"
        }else if selectedServiceCategoryId.count == 0{
            msg = "Please select service category"
        }else if selectedServiceSubCategoryId.count == 0{
            msg = "Please select service sub-category"
        }else if projects.count == 0{
            msg = "Please add project"
        }else if price.text == ""{
            msg = "Please select price"
        }else if durationLbl.text == ""{
            msg = "Please enter duration"
        }else if certificateBtnss.currentImage == UIImage(named: ""){
            msg = "Please add service image"
        }else if agreementValue != true{
            msg = "Please agree to our TERMS AND CONDITIONS "
        }
        if msg != ""{
            self.showDefaultAlert(Message: msg)
        }else{
            for i in 0...projects.count-1{
                let projId: Dictionary = ["project_id": "\(projects[i].id!)"]
                projectIds.append(projId)//.jsonString()!)
                //projectIds.append(Projects(project_id: projects[i].id!))
            }
            
            ImagesData.append(ServiceImgData)
            ImageType.append("image/jpeg")
            ImagesName.append(certificateLBL.text ?? "")
            ImagesParam.append("service_image")
            for i in 0...relatedImageArray.count-1{
                ImagesData.append(relatedImgDataArray[i])
                ImagesName.append(relatedImgDescriptionArray[i])
                ImageType.append("image/jpeg")
                ImagesParam.append("related_images")
            }
            for i in 0...otherImageDataArray.count-1{
                ImagesData.append(otherImageDataArray[i])
                ImagesName.append(otherImgDescriptionArray[i])
                ImageType.append("image/jpeg")
                ImagesParam.append("other_images")
            }
            if(price.text == priceArray[0]){
                projectPrice = "10000"
            }else if(price.text == priceArray[1]){
                projectPrice = "50000"
            }else if(price.text == priceArray[2]){
                projectPrice = "100000"
            }else if(price.text == priceArray[3]){
                projectPrice = "500000"
            }else if(price.text == priceArray[4]){
                projectPrice = "500000"
            }
            hitAddService()
        }
    }
    func convertIntoJSONString(arrayObject: [Any]) -> String? {

            do {
                let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
                if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                    return jsonString as String
                }
                
            } catch let error as NSError {
                print("Array convertIntoJSON - \(error.description)")
            }
            return nil
        }
}

//MARK:- Collection View Delegates

extension AddServiceViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cityCollectionView {
            return cityName.count
        }else if collectionView == serviceCatCollView{
            return selectedServiceCategory.count
        }else if collectionView == serviceSubCatCollView{
            return selectedServiceSubCategory.count
        }else if collectionView == relatedPhotoColletionView
        {
            if relatedImageArray.count == 0
            {
                
               return 0
            }else
            {
                return relatedImageArray.count
            }
        }else if collectionView == otherPhotosCollectionView
        {
            if otherImageArray.count == 0
            {
               return 0
            }else
            {

                return otherImageArray.count
            }
            
        }else if collectionView == showProjectsColletionView
            {
            return projects.count
            
        }else if collectionView == branchCollection{
            return selectedBranchName.count
        }
        else
        {
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
                self.cityId.remove(at: indexPath.row)
                self.cityCollectionView.reloadData()
            }
            return cell
        }else if collectionView == serviceCatCollView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCityCollectionViewCell
            cell.cityNameLabel.text = selectedServiceCategory[indexPath.row]
            cell.onDelete = {
                self.selectedServiceCategory.remove(at: indexPath.row)
                self.selectedServiceCategoryId.remove(at: indexPath.row)
                self.serviceSubCategories = []
                self.serviceSubCategoriesId = []
                self.getServiceSubCategories()
                self.serviceCatCollView.reloadData()
            }
            return cell
        }else if collectionView == serviceSubCatCollView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCityCollectionViewCell
            cell.cityNameLabel.text = selectedServiceSubCategory[indexPath.row]
            cell.onDelete = { [self] in
                self.selectedServiceSubCategory.remove(at: indexPath.row)
                self.selectedServiceSubCategoryId.remove(at: indexPath.row)
                projects.removeAll()
                self.projects = []
                self.projectIds = []
                getProjectBySubCategories()
                self.serviceSubCatCollView.reloadData()
            }
            return cell
        }else if collectionView == relatedPhotoColletionView
        {
            let cell = relatedPhotoColletionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! RelatedPhotosCollectionViewCell
            cell.relatedPhtoBtn1.tag = indexPath.row
            cell.imagePhoto.image = relatedImageArray[indexPath.row]
            cell.imageDescription.text = relatedImgDescriptionArray[indexPath.row]
            return cell
            
        }else if collectionView == otherPhotosCollectionView
        {
            let cell = otherPhotosCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RelatedPhotosCollectionViewCell
            cell.otherPhtoBtn1.tag = indexPath.row
            cell.imagePhoto.image = otherImageArray[indexPath.row]
            cell.imageDescription.text = otherImgDescriptionArray[indexPath.row]
            return cell
            
        }else if collectionView == showProjectsColletionView
        {
            let cell = self.showProjectsColletionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShowProjectsARCollectionViewCell
            cell.projectName.text = projects[indexPath.row].projectName
            cell.projectImgCount.text = "\(String(describing: projects[indexPath.row].projectImages?.count ?? 0))"
            let imgUrl = URLS.projectImageUrl(projects[indexPath.row].projectImages?.first?.name ?? "").getDescription()
            cell.ProjectImage.sd_setImage(with: URL(string: imgUrl), placeholderImage: #imageLiteral(resourceName: "Placehold"))
            return cell
        }else if collectionView == branchCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCityCollectionViewCell
            cell.cityNameLabel.text = selectedBranchName[indexPath.row]
            cell.onDelete = {
                self.selectedBranchName.remove(at: indexPath.row)
                self.selectedBranchId = ""
                self.branchCollection.reloadData()
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCountryCollectionViewCell
            cell.countryNameLabel.text = countryName[indexPath.row]
            cell.onDelete = {
                self.countryName.remove(at: indexPath.row)
                self.countryId.remove(at: indexPath.row)
                collectionView.reloadData()
                self.cityName.removeAll()
                self.cityCollectionView.reloadData()
            }
            return cell
        }
    }
}

//MARK:- API Call
extension AddServiceViewController
{
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
}
//MARK:- tableview Delegate

extension AddServiceViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if valueForTabSelected == 0{
            return (viewModelForService.model.data?.count ?? 0)!
        }else if valueForTabSelected == 1{
            return serviceSubCategories.count
        }else if valueForTabSelected == 3{
            return branchVM.model.count
        }else{
            return priceArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if valueForTabSelected == 0
        {
        let cell = popUpTableview.dequeueReusableCell(withIdentifier: "cell") as! ServiceAddPopUpTableViewCell
            self.downServicelbl.textColor = .black
        cell.serviceLbl.text = viewModelForService.model.data?[indexPath.row].name
            return cell
        }else if valueForTabSelected == 1
        {
            let cell = popUpTableview.dequeueReusableCell(withIdentifier: "cell") as! ServiceAddPopUpTableViewCell
            self.downSubService.textColor = .black
            cell.serviceLbl.text = serviceSubCategories[indexPath.row]//viewModelForService.model.data?[self.valueForSelectedCat ?? 0].subCategories?[indexPath.row].name
            return cell
        }else if valueForTabSelected == 3{
            let cell = popUpTableview.dequeueReusableCell(withIdentifier: "cell") as! ServiceAddPopUpTableViewCell
            self.downSubService.textColor = .black
            cell.serviceLbl.text = branchVM.model[indexPath.row].branchNameEn ?? ""
            return cell
        }
        else{
            let cell = popUpTableview.dequeueReusableCell(withIdentifier: "cell") as! ServiceAddPopUpTableViewCell
            cell.serviceLbl.text = priceArray[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        valueForSelectedCat = indexPath.row
        if valueForTabSelected == 0
        {   self.upperServiceLbl.isHidden = false
            self.downServicelbl.isHidden = true
            self.serviceCatCollView.isHidden = false
           // self.downServicelbl.textColor = .black
           // self.downServicelbl.text =
            selectedServiceCategory.append((viewModelForService.model.data?[indexPath.row].name) ?? "")
            selectedServiceCategoryId.append((viewModelForService.model.data?[indexPath.row].id) ?? "")
            self.serviceSubCategories = []
            self.serviceSubCategoriesId = []
            getServiceSubCategories()
            self.serviceCatCollView.reloadData()
        }else if valueForTabSelected == 1
        {   self.upperSubService.isHidden = false
            self.downSubService.isHidden = true
            self.serviceSubCatCollView.isHidden = false
            //self.downSubService.textColor = .black
            //self.downSubService.text =
            selectedServiceSubCategory.append(serviceSubCategories[indexPath.row])
            selectedServiceSubCategoryId.append(serviceSubCategoriesId[indexPath.row])
            //(viewModelForService.model.data?[self.valueForSelectedCat ?? 0].subCategories?[indexPath.row].name ?? "")
            projects.removeAll()
            self.projects = []
            self.projectIds = []
            getProjectBySubCategories()
            self.serviceSubCatCollView.reloadData()

            //let servceCode = viewModelForService.model.data?[self.valueForSelectedCat].subCategories?[indexPath.row].id
           // print("SUBCATSERVICE DATA==========>>>> \(String(describing: servceCode))")
        }else if  valueForTabSelected == 3{
            self.upperSelectBranch.isHidden = false
            self.upperSelectBranch.isHidden = true
            self.branchCollection.isHidden = false
            
            selectedBranchName.append(branchVM.model[indexPath.row].branchNameEn ?? "")
            
            selectedBranchId = branchVM.model[indexPath.row].id ?? ""
            branchCollection.reloadData()
        }else{
            selectedPrice = priceArray[indexPath.row]
            price.text = selectedPrice
        }
        
        popUpOuterVIEW.removeFromSuperview()
        
    }
}


//MARK:- Hit API
extension AddServiceViewController
{
    func hitServiceCategoryApi()
    {
        viewModelForService.hitGetServiceCategory { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.popUpTableview.reloadData()

            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func getBranchList(){
        branchVM.apiGetBranchList { (isSuccess, message) in
            if isSuccess{
                
            }else{
                
            }
        }
    }
    
    func getServiceSubCategories(){
        if selectedServiceCategoryId.count > 0{
        for i in 0...selectedServiceCategoryId.count-1{
            viewModelP.apiGetSubCategory(categoryId: selectedServiceCategoryId[i]) { (isSuccess, msg) in
                if isSuccess{
                    
                    self.serviceSubCategories = self.viewModelP.subCateModel.map({$0.name ?? "" })
                    self.serviceSubCategoriesId = self.viewModelP.subCateModel.map({$0.id ?? "" })
                   
                }
            }
        }}
    }
    
    func getProjectBySubCategories(){
        
        viewModelP.apiGetProjectsBySubCategory(subCategoryId: selectedServiceSubCategoryId) { [self] (isSuccess, msg) in
                if isSuccess{
                    self.projects = self.viewModelP.projectBySubCat
                    showProjectsColletionView.reloadData()
                   // self.serviceSubCategories = self.viewModelP.subCateModel.map({$0.name ?? "" })
                    //self.serviceSubCategoriesId = self.viewModelP.subCateModel.map({$0.id ?? "" })
                   
                }
            }
            showProjectsColletionView.reloadData()

    }
    
    func hitAddService(){
        
        viewModel.apiAddService(service_name: serviceName.text ?? "", service_description: Discription.text ?? "", area_covered: cityName, country: countryName, service_category: selectedServiceCategoryId, service_sub_category: selectedServiceSubCategoryId, service_project: convertIntoJSONString(arrayObject: projectIds)!, price: projectPrice, duration: durationLbl.text ?? "", service_visible_customer: "\(customerValue)", service_visible_professional: "\(professionalValue)", service_image: serviceImgString, related_images: convertIntoJSONString(arrayObject: RelatedImagewithDesc)!, other_images: convertIntoJSONString(arrayObject: OtherImgWithDec)!, tags: tagsTextField.text ?? "" , serviceBranches: selectedBranchId) { (isSuccess, msg) in
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
//MARK:- ImagePIcker
extension AddServiceViewController : ImagePickerDelegete {
//
    func disFinishPicking(imgData: Data, img: UIImage) {
       /* switch imagePickerData {
        case 1:
            imageData = img.jpegData(compressionQuality: 0.6)!
            uploadImage()
            certificateBtnss.setImage(img, for: .normal)
            self.shownImage = img
        case 2:
            imageData = img.jpegData(compressionQuality: 0.6)!
            uploadImage()
            relatedImageArray.append(img)
           
            
        default:
                   imageData = img.jpegData(compressionQuality: 0.6)!
                   otherImageArray.append(img)
                   uploadImage()
                   
        }*/
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddImagePopUpViewController") as! AddImagePopUpViewController
        vc.delegate = self
        vc.selectedImage = img
        vc.imageData = imgData
        vc.imgName = GenerateUniqueImageName()
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }


    func showPic() {
        
    }
//
    func uploadImage() {
        var uploadImgData = ""
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        
        
        viewModelP.hitUploadImageService(imageData: imageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message) in
            if isSuccess {
                
                uploadImgData = self.viewModelP.imageData?.data ?? ""
                if(self.imagePickerData == 1){
                    
                    self.serviceImgString = uploadImgData
                }else if(self.imagePickerData == 2){
                    let imgWithDesc = ["image_name" : uploadImgData, "description": self.imgDescription]
                    self.RelatedImagewithDesc.append(imgWithDesc)
                }else if(self.imagePickerData == 3){
                    let imgWithDesc = ["image_name" : uploadImgData, "description": self.imgDescription]
                    self.OtherImgWithDec.append(imgWithDesc)
                }
                //self.showPic()
               // self.otherPhotosCollectionView.reloadData()
              //  self.relatedPhotoColletionView.reloadData()
                
            } else {
                self.view.makeToast(message)
            }
        }
        
    }
}

extension Dictionary {
    func jsonString() -> NSString? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [])
        guard jsonData != nil else {return nil}
        let jsonString = String(data: jsonData!, encoding: .utf8)
        guard jsonString != nil else {return nil}
        return jsonString! as NSString
    }

}
