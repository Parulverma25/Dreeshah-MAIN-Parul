//
//  AddProjectARViewController.swift
//  Dreesha User
//
//  Created by promatics on 5/3/21.
//

import UIKit
import SBCardPopup

class AddProjectARViewController: UIViewController,Year {
   
    @IBOutlet weak var productBtnOutlet: UIButton!
    
    @IBOutlet weak var heightConstrainsMainPage: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var serviceBtnOutlet: UIButton!
    @IBOutlet weak var professionalBtnOutlet: UIButton!
    @IBOutlet weak var projectAddress: SkyFloatingLabelTextField!
    @IBOutlet weak var getNoticeProfile: SkyFloatingLabelTextField!
    @IBOutlet weak var keyWords: SkyFloatingLabelTextField!
    @IBOutlet weak var linkInWebsite: SkyFloatingLabelTextField!
    @IBOutlet weak var projectCost: SkyFloatingLabelTextField!
    @IBOutlet weak var projectYear: SkyFloatingLabelTextField!
    @IBOutlet weak var projectStyle: SkyFloatingLabelTextField!
    @IBOutlet weak var selectCategory: SkyFloatingLabelTextField!
    @IBOutlet weak var projectName: SkyFloatingLabelTextField!
    @IBOutlet weak var tableViewForCategories : UITableView!
    @IBOutlet weak var photosHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewForStyles : UITableView!
    @IBOutlet weak var photosCollectionView : UICollectionView!
    @IBOutlet weak var popUpOuterView : UIView!
    @IBOutlet weak var popUpOuterView2 : UIView!
    @IBOutlet weak var keywordTableView : UITableView!
    var viewModelP = SignupViewModel()
    let imagePicker = ImagePickerViewControler()
    var viewModel = AddServiceARViewModel()
    
    
    var professionalCount = 1
    var serviceCount = 1
    var productCount = 1
    var viewModelForStyles = AddServiceARViewModel()
    var heightContent : Int!
    var idCategory : String!
    var idStyle : String!
    var imagesArray = [UIImage]()
    var keyWordSArray = [String]()
    var categoryArrayname = [String]()
    var categoryArrayid = [String]()
    var stylesArrayName = [String]()
    var stylesArrayId = [String]()
    var isProfessional = false
    var isProduct = false
    var isService = false
    var imageData : Data?
    var viewModelForService = ServiceCategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        hitServiceCategoryApi()
        hitStyleApi()
        tableViewHeight.constant = 0
        heightContent = 1600
        

    }
    
    @IBAction func addKeywordBtn(_ sender: UIButton) {
        if keyWords.text == ""
        {
            view.makeToast("Enter Keyword")
        }else
        {
            let c = keyWords.text!
            keyWordSArray.append(c)
            keyWords.text = ""
            tableViewHeight.constant = CGFloat((keyWordSArray.count * 40))
            heightConstrainsMainPage.constant = CGFloat((keyWordSArray.count * 40) + heightContent)
            keywordTableView.reloadData()
            
        }
        
    }
    @IBAction func PhtoBtnDelete(_ sender: UIButton)
    {
        let index = sender.tag
        imagesArray.remove(at: index )
        photosCollectionView.reloadData()
    }
    @IBAction func uploadImageBtn(_ sender: UIButton) {
        self.imagePicker.imagePickerDelegete = self
        self.imagePicker.showImagePicker(viewController: self)
    }
    @IBAction func professionalBtn(_ sender: UIButton) {
        self.professionalCount = professionalCount + 1
        if professionalCount % 2 == 0
        {
           isProfessional = true
            professionalBtnOutlet.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
        }else
        {
            professionalBtnOutlet.setImage(#imageLiteral(resourceName: "checkbox Off"), for: .normal)
            isProfessional = false
        }
       
    }
    @IBAction func removeKeywords(_ sender: UIButton) {
        if keyWordSArray.count > 0
        {
            keyWordSArray.remove(at: sender.tag)
            tableViewHeight.constant = CGFloat((keyWordSArray.count * 40))
            heightConstrainsMainPage.constant = CGFloat((keyWordSArray.count * 40) + heightContent)
            keywordTableView.reloadData()
        }
    }
    
    @IBAction func publishProject(_ sender: UIButton) {
        hitAddProductApi()
        
    }
    @IBAction func productBtn(_ sender: UIButton) {
        self.productCount = productCount + 1
        if productCount % 2 == 0
        {
           isProduct = true
            productBtnOutlet.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
        }else
        {
            productBtnOutlet.setImage(#imageLiteral(resourceName: "checkbox Off"), for: .normal)
            isProduct = false
        }
    }
    @IBAction func serviceBtn(_ sender: UIButton) {
        self.serviceCount = serviceCount + 1
        if serviceCount % 2 == 0
        {
           isService = true
            serviceBtnOutlet.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
        }else
        {
            serviceBtnOutlet.setImage(#imageLiteral(resourceName: "checkbox Off"), for: .normal)
            isService = false
        }
    }
    @IBAction func popUpBtn(_ sender: UIButton) {
        popUpOuterView.frame = window.frame
        
        window.addSubview(popUpOuterView)
    }
    @IBAction func stylesPopup(_ sender: UIButton) {
        popUpOuterView2.frame = window.frame
        
        window.addSubview(popUpOuterView2)
    }
    
    @IBAction func year(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "YearPopUpViewController") as! YearPopUpViewController
        vc.delegate = self
        let card = SBCardPopupViewController(contentViewController: vc)
        card.show(onViewController: self)

        
    }
    
    func getYearValue(year: String) {
        projectYear.text = year
    }
    
}


//MARK:- table View Delegates
extension AddProjectARViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewForCategories
        {
            return categoryArrayid.count
            
        }else if tableView == keywordTableView
        {
            return keyWordSArray.count
        }
        else
        {
            return stylesArrayId.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewForCategories
        {
            let cell = tableViewForCategories.dequeueReusableCell(withIdentifier: "cell") as! ServiceAddPopUpTableViewCell
             
            cell.serviceLbl.text = categoryArrayname[indexPath.row]
            return cell
        }else if tableView == keywordTableView
            {
            let cell = keywordTableView.dequeueReusableCell(withIdentifier: "cell") as! KeywordsTableViewCell
            cell.keywordLbl.text = keyWordSArray[indexPath.row]
            cell.keywordBtn.tag = indexPath.row
            return cell
        }
        else
        {
            let cell = tableViewForStyles.dequeueReusableCell(withIdentifier: "cell") as! ServiceAddPopUpTableViewCell
             
            cell.serviceLbl.text = self.stylesArrayName[indexPath.row]
            return cell
        }
        
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewForCategories
        { idCategory = categoryArrayid[indexPath.row]
            selectCategory.text = categoryArrayname[indexPath.row]
            selectCategory.textColor = UIColor.black
            print((idCategory)!)
            popUpOuterView.removeFromSuperview()}
        else{
            projectStyle.text = stylesArrayName[indexPath.row]
            projectStyle.textColor = UIColor.black
            idStyle = stylesArrayId[indexPath.row]
            popUpOuterView2.removeFromSuperview()
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
//MARK:- collectionView delegate
extension AddProjectARViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imagesArray.count
            == 0
        {return 0
            
        }else
        {
            return imagesArray.count
        }
       
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RelatedPhotosCollectionViewCell
        cell.imagePhoto.image = imagesArray[indexPath.row]
        cell.relatedPhtoBtn1.tag = indexPath.row
           
            return cell
        }
    }


//MARK:- hit Api
extension AddProjectARViewController
{
    func hitServiceCategoryApi()
    {
        viewModelForService.hitGetServiceCategory { [self] (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
              //  self.tableViewForCategories.reloadData()
                let count =   self.viewModelForService.model.data?.count
                for i in 0...(count! - 1)
                {
                 var count2 =  self.viewModelForService.model.data?[i].subCategories?.count
                    for c in 0...(count2! - 1)
                    {
                        categoryArrayname.append((self.viewModelForService.model.data?[i].subCategories?[c].name)!)
                        categoryArrayid.append((self.viewModelForService.model.data?[i].subCategories?[c].id)!)
                        
                    }
                    
                            
                }
                
            }else{
                self.view.makeToast(message , position : .center)
            }
            print("IDDDDDDD===>>\(categoryArrayname)")
        }
    }
    
    func hitStyleApi()
    {
        viewModelForStyles.hitStylesApi { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
              //  self.tableViewForCategories.reloadData()
                
                let count = self.viewModelForStyles.styleModel.data?.count
                for i in 0...(count! - 1)
                {
                    self.stylesArrayName.append((self.viewModelForStyles.styleModel.data?[i].name)!)
                    self.stylesArrayId.append((self.viewModelForStyles.styleModel.data?[i].id)!)
                    
                }
                            
          
                
            }else{
                self.view.makeToast(message , position : .center)
            }
            
        }
    }
}
//MARK:- Image Picker
extension AddProjectARViewController : ImagePickerDelegete {
//
    func disFinishPicking(imgData: Data, img: UIImage) {
       
            imageData = img.jpegData(compressionQuality: 0.6)!
            uploadImage()
        self.imagesArray.append(img)
        
        

    }


    func showPic() {
        
    }
//
    func uploadImage() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModelP.hitUploadImage(imageData: imageData!, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                }
               
                self.showPic()
                self.photosCollectionView.reloadData()
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    //Add project Api
    
    func hitAddProductApi()
    {
        viewModel.hitAddProjectApi(projectName: self.projectName.text!, projectAddress: self.projectAddress.text!, Projectcategory: idCategory, projectStyle: idStyle, projectYear: Int(self.projectYear.text!)!, projectCost: Int(self.projectCost.text!)!, projectWebsite: linkInWebsite.text!, projectKeywords: keyWordSArray, projectImages: ["3674283432432.jpg"], projectProfessional: isProfessional, projectProduct: isProduct, projectServices: isService, notifyBranchId: ["sdfdfsdfsdfs"]) { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess
            {
                self.view.makeToast("Project Added")
            }else
            {
                self.view.makeToast(message)
            }
        }
    }
    
}
