//
//  AddProductViewController.swift
//  Dreeshah
//
//  Created by Promatics on 18/03/21.
//

import UIKit
import iOSDropDown
class AddProductViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, ImagePickerDelegete {
  
    //MARK:- IBOutlets
    @IBOutlet weak var ProductTitle_tf: SkyFloatingLabelTextField!
    @IBOutlet weak var category_tfld: DropDown!
    @IBOutlet weak var subCategory_tfld: DropDown!
    @IBOutlet weak var description_tView: UITextView!
    @IBOutlet weak var uploadedImageView: UICollectionView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var productPrice: SkyFloatingLabelTextField!
    @IBOutlet weak var compareAtPrice_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var prodMargin_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var prodProfit_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var costPerItem_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var chargeTax_btn: UIButton!
    @IBOutlet weak var inventoryType_tfld: DropDown!
    @IBOutlet weak var collectionDrop: DropDown!
    @IBOutlet weak var stockKUnit_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var barCode_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var trackQuantity_btn: UIButton!
    @IBOutlet weak var quantiyView: SetView!
    @IBOutlet weak var stockLocationsTab: UITableView!
    @IBOutlet weak var stockTabHeight: NSLayoutConstraint!
    @IBOutlet weak var isPhysicalPrdct_btn: UIButton!
    @IBOutlet weak var weight_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var weightUnitTab: UITableView!
    @IBOutlet weak var unitTabHeight: NSLayoutConstraint!
    @IBOutlet weak var countryRegion_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var HSCode_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var VariantPrdct_btn: UIButton!
    @IBOutlet weak var VariantView: UIView!
    @IBOutlet weak var variantViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var sizeviewHeight: NSLayoutConstraint!
    @IBOutlet weak var size_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var colorviewHeight: NSLayoutConstraint!
    @IBOutlet weak var colorName_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var colorCode_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var professionalVisible_btn: UIButton!
    @IBOutlet weak var customerVisible_btn: UIButton!
    @IBOutlet weak var productType_tfls: DropDown!
    @IBOutlet weak var vendor_tfld: DropDown!
    @IBOutlet weak var collection_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var tags_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var unitdrop: DropDown!
    
    //MARK:- Variables
    
    var arrDataforApi = [String]()
    
    var viewModelP = SignupViewModel()
    var viewModel = AddProductViewModel()
    
    var SubstrIdval = ""
    var CategorystrIdval = ""
    var collectionIdStrVal = ""
    var producttypeVal = ""
    var inventoryNameVal = ""
    var VendorVal = ""
    var unitStr = ""
    var shippingval = ""
    var variantval = ""
    var visible = ""
    var visiblecustomer = ""
    var charged = ""
    var imagePicker = ImagePickerViewControler()
    var ProductsImgString = ""
    var imgDescription = ""
    var ProductImageArray = [[String: String]]()
    
    var arrLabel1 = ["Mumbai","Delhi","Kolkata"]
    var arrLabel2 = ["12","9","5"]
    var unitArray = ["Kg", "g"]
    var isclickedquan = false
    var isclicked = false
    var isclickedPhysical = false
    var isProductVarient  = false
    var isProfessionalVisible = false
    var isCustomerVisible = false
    var ProductSizes = [String]()
    var ProductColor = [String]()
    var ProductColorCode = [String]()
    var ImagesData = [Data]()
    var arrnewImg = [UIImage]()
    var arrImageData = [Data]()
    var arrImageName = [String]()
    var arrImageType = [String]()
    var selectedImage = UIImage()
    var imageParam = [String]()
    var city = [String]()
    var BranchName = [String]()
    var BranchID = [String]()
    
    var arrayOfcount : [String] = [String]()
    
    var Size = [[String : String]]()
    var Color = [[String : String]]()
    var quantity = [[String : String]]()
//MARK:- View Did Laod
    override func viewDidLoad() {
        super.viewDidLoad()
        stockLocationsTab.delegate=self
        stockLocationsTab.dataSource=self
        stockLocationsTab.reloadData()
        
        
        sizeCollectionView.delegate=self
        sizeCollectionView.dataSource=self
        sizeCollectionView.reloadData()
        
        colorCollectionView.delegate=self
        colorCollectionView.dataSource=self
        colorCollectionView.reloadData()
        
        
        subCategory_tfld.didSelect { (name, index, id) in
            self.SubstrIdval = self.viewModel.SubModel?.data?[index].id ?? ""
        }
        category_tfld.didSelect { (name, index, id) in
            self.CategorystrIdval = self.viewModel.CatModel?.categories?[index].id ?? ""
        }
        unitdrop.didSelect { (name, index, id) in
            self.unitStr = self.unitArray[index]
        }
        productType_tfls.didSelect { (name, index, id) in
            self.producttypeVal = self.viewModel.TypeModel?.productTypes?[index].productTypeID ?? ""
            let ProductTypeID = self.viewModel.TypeModel?.productTypes?[index].productTypeID ?? ""
            self.VendorList(ProductTypeID : ProductTypeID)
            
        }
        vendor_tfld.didSelect { (name, index, id) in
            self.VendorVal = self.viewModel.vendorModel?.result?[index].id ?? ""
        }
        inventoryType_tfld.didSelect { (name, index, id) in
            self.inventoryNameVal = self.viewModel.inventModel?.result?[index].id ?? ""
        }
        
        collectionDrop.didSelect { (name, index, id) in
            self.collectionIdStrVal = self.viewModel.CollectModel?.collections?[index].collectionID ?? ""
        }
    }
    
    
    //MARK:- WillAppear
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Add Product")
        
        Productcategory()
        Subcategory()
        ProductTypeList()
        InventoryList()
        hitAPIProfBranch()
        CollectionList()
        unitdrop.optionArray = unitArray
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
    
    //MARK:- IBActionFunction
    
    @IBAction func tapSelectCategory(_ sender: Any) {
        
    }
    
    @IBAction func tapSelectSubCategory(_ sender: Any) {
    }
    
    @IBAction func CrossbuttonTapped(_ sender: UIButton) {
       
        arrnewImg.remove(at: sender.tag)
        arrImageData.remove(at: sender.tag)
        arrImageName.remove(at: sender.tag)
        arrImageType.remove(at: sender.tag)
        imageParam.remove(at: sender.tag)
        uploadedImageView.reloadData()
        if arrnewImg.count == 0{
            imageViewHeight.constant = 0
        }else{
            imageViewHeight.constant = 150
        }
    }
    
    @IBAction func tapChargeTax(_ sender: Any) {
        if !isclicked{
            isclicked = true
            charged = "true"
            chargeTax_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
        }else{
            isclicked = false
            charged = "false"
            chargeTax_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
        }
    }
    
    @IBAction func tapTrackQuantity(_ sender: Any) {
        if !isclickedquan{
            isclickedquan = true
            trackQuantity_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
        }else{
            isclickedquan = false
            trackQuantity_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
        }
    }
    
    @IBAction func tapPhysicalPrdct(_ sender: Any) {
        if !isclickedPhysical{
            isclickedquan = true
            isPhysicalPrdct_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
            shippingval = "yes"
        }else{
            isclickedPhysical = false
            isPhysicalPrdct_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
            shippingval = "no"
        }
    }

    @IBAction func tapVarient(_ sender: Any) {
        if !isProductVarient{
            isProductVarient = true
            variantViewHeight.constant = 245
            VariantView.isHidden = false
            variantval = "yes"
            VariantPrdct_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
        }else{
            isProductVarient = false
            VariantView.isHidden = true
            variantViewHeight.constant = 0
            variantval = "no"
            VariantPrdct_btn.setImage(UIImage(named: "checkbox Off"), for: .normal)
        }
    }
    
    @IBAction func addProdctSize(_ sender: Any) {
        if size_tfld.text!.isEmpty{
            view.makeToast("Please enter size")
        }else {
            sizeviewHeight.constant = 50
            ProductSizes.append("\(size_tfld.text ?? "")")
            sizeCollectionView.reloadData()
            size_tfld.text = ""
        }
    }
    
    @IBAction func addProdctColor(_ sender: Any) {
        if colorName_tfld.text!.isEmpty{
            view.makeToast("Please enter color name")
        }else if colorCode_tfld.text!.isEmpty{
            view.makeToast("Please enter color code")
        }else if !(colorCode_tfld?.text?.isValidHex() ?? false) {
            self.view.makeToast("Please Enter valid hexCode")
        }
        else {
            colorviewHeight.constant = 50
            ProductColor.append("\(colorName_tfld.text ?? "")")
            ProductColorCode.append("\(colorCode_tfld.text ?? "")")
            colorCollectionView.reloadData()
            colorCode_tfld.text = ""
            colorName_tfld.text = ""
        }
    }
    
    @IBAction func tapProfessional(_ sender: Any) {
        if !isProfessionalVisible{
            isProfessionalVisible = true
            visible = "true"
            professionalVisible_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
        }else{
            isProfessionalVisible = false
            visible = "false"
            professionalVisible_btn.setImage(UIImage(named: "checkbox Off"), for: .normal)
        }
    }
    
    @IBAction func tapCustomer(_ sender: Any) {
        if !isCustomerVisible{
            isCustomerVisible = true
            visiblecustomer = "true"
            customerVisible_btn.setImage(UIImage(named: "checkbox On"), for: .normal)
        }else{
            isCustomerVisible = false
            visiblecustomer = "false"
            customerVisible_btn.setImage(UIImage(named: "checkbox Off"), for: .normal)
        }
    }

    @IBAction func tapSaveLater(_ sender: UIButton) {
    }
    
    @IBAction func TapSave(_ sender: UIButton) {
        
    }
    
    @IBAction func tapPublish(_ sender: UIButton) {
        
        var msg = ""
        if ProductTitle_tf.text == ""{
            msg = "Please enter Product Title"
        }else if description_tView.text == ""{
            msg = "Please enter Product Description"
        }else if arrnewImg.count == 0{
            msg = "Please select Image"
        }else if CategorystrIdval == ""{
            msg = "Please select Category"
        }else if SubstrIdval == ""{
            msg = "Please select Sub-category"
        }else if productPrice.text == ""{
            msg = "Please enter price"
        }else if compareAtPrice_tfld.text == ""{
            msg = "Please enter Comprice"
        }else if prodMargin_tfld.text == ""{
            msg = "Please enter Margin"
        }else if costPerItem_tfld.text == ""{
            msg = "Please enter CostPerItem"
        }else if prodProfit_tfld.text == ""{
            msg = "Please enter Profit"
        }
        if msg != ""{
            self.showDefaultAlert(Message: msg)
        }else{
            if (variantval == "yes"){
            
        for i in 0...ProductSizes.count-1{
            let PDSIZE: Dictionary = ["size": "\(ProductSizes[i])"]
            Size.append(PDSIZE)//.jsonString()!)
            //projectIds.append(Projects(project_id: projects[i].id!))
        }
//        print(Size)
        for i in 0...ProductColor.count-1{
            let PColor: Dictionary = ["color_name": "\(ProductColor[i])","color_code": "\(ProductColorCode[i])"]
            Color.append(PColor)//.jsonString()!)
            //projectIds.append(Projects(project_id: projects[i].id!))
        }}else{print(variantval)}
//        print(Color)
        var i = 0
        while i < self.city.count {
               let indexPath = IndexPath(row: i, section: 0)
               let cell : AddProductTableViewCell? = self.stockLocationsTab.cellForRow(at: indexPath) as! AddProductTableViewCell?
               if let item = cell?.count_txtFld.text {
                arrayOfcount.append(item)
               }
               i = i + 1
           }
//           print("\(arrayOfcount)")
        
        for i in 0...city.count-1{
            let Quantity: Dictionary = ["branch_name": "\(BranchName[i])","branch_quantity": "\(arrayOfcount[i])","branch_id": "\(BranchID[i])"]
            quantity.append(Quantity)//.jsonString()!)
            //projectIds.append(Projects(project_id: projects[i].id!))
        }
//        print(quantity)
        
            AddProduct()
        
        
        
        
    }
}
    
    @IBAction func tapToAddImage(_ sender: UIButton) {
        
        uploadedImageView.delegate=self
        uploadedImageView.dataSource=self
        uploadedImageView.reloadData()
        
        imagePicker.imagePickerDelegete = self
        imagePicker.showImagePicker(viewController: self)
        
    
    }
    
    func disFinishPicking(imgData: Data, img: UIImage) {
        
            imageViewHeight.constant = 150
             arrnewImg.append(img)                                                              //MARK: To SHOW Images in Collection View
             arrImageData.append(img.jpegData(compressionQuality: 0.6)!)
             arrImageName.append(GenerateUniqueName())
             arrImageType.append("image/jpeg")
             imageParam.append("product_media")

            uploadedImageView.reloadData()
    }
    
    
    
}
//Mark Table View Delegate Func
extension AddProductViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.LocationModel?.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddProductTableViewCell
        
        cell.Label1.text = city[indexPath.row]
        
        return cell
    }
}

extension AddProductViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == uploadedImageView{
            return arrnewImg.count
        }else if collectionView == sizeCollectionView{
            return ProductSizes.count
        }else {
            return ProductColor.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sizeCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCityCollectionViewCell
            cell.cityNameLabel.text = ProductSizes[indexPath.row]
            cell.onDelete = {
                self.ProductSizes.remove(at: indexPath.row)
                self.sizeCollectionView.reloadData()
                if self.ProductSizes.count == 0 {
                    self.sizeviewHeight.constant = 0
                }else{
                    self.sizeviewHeight.constant = 50
                }
            }
            
            return cell
        }else if collectionView == uploadedImageView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as! AddProjectImagesCell
            cell.ProjImage.image = arrnewImg[indexPath.row]
            cell.crossbtn.tag = indexPath.row
            cell.crossbtn.addTarget(self, action: #selector(CrossbuttonTapped(_:)), for: .touchUpInside)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCityCollectionViewCell
            cell.cityNameLabel.text = ProductColor[indexPath.row]
            cell.onDelete = {
                self.ProductColor.remove(at: indexPath.row)
                self.colorCollectionView.reloadData()
                if self.ProductColor.count == 0 {
                    self.colorviewHeight.constant = 0
                }else{
                    self.colorviewHeight.constant = 50
                }
            }
            return cell
        }
    }
}

//MARK:- API CALL
extension AddProductViewController {
    
    func AddProduct(){

        viewModel.hitaddProductArrayImg(category_id: CategorystrIdval, sub_category_id: SubstrIdval, product_title: ProductTitle_tf.text ?? "", product_description: description_tView.text ?? "", product_media: convertIntoJSONString(arrayObject: ProductImageArray)!, shipping: shippingval, variant: variantval, product_type: producttypeVal, visible_to_professinal: visible, visible_to_customer: visiblecustomer, charge_tax: charged, collection: collectionIdStrVal , vendor: VendorVal, tags: tags_tfld.text ?? "", price: Int(productPrice.text ?? "") ?? 0, comprice: Int(compareAtPrice_tfld.text ?? "") ?? 0 , costperitem: Int(costPerItem_tfld.text ?? "") ?? 0 , margin: Int(prodMargin_tfld.text ?? "") ?? 0, profit: Int(prodProfit_tfld.text ?? "") ?? 0, inventory: inventoryNameVal , sku: stockKUnit_tfld.text ?? "", barcode: barCode_tfld.text ?? "", weight: weight_tfld.text ?? "", region: countryRegion_tfld.text ?? "", code: HSCode_tfld.text ?? "", unit: unitStr , quantity: convertIntoJSONString(arrayObject: quantity)!, available_color: convertIntoJSONString(arrayObject: Color)!, available_size: convertIntoJSONString(arrayObject: Size)! ,imageParam: imageParam , imageName: arrImageName , imageData: arrImageData ,imageMime: arrImageType){ (isSuccess, msg) in
                if(isSuccess){
                    self.showDefaultAlert(Message: msg)
                    self.showAlertWithAction(Title: "Dreeshah", Message: msg, ButtonTitle: "OK") {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                else{
                    self.showDefaultAlert(Message: msg)
                }

            }

        }
    
    
    
func Subcategory(){
    Indicator.shared.showProgressView(self.parent?.view ?? self.view)
    viewModel.hitProductSubCategories { (isSuccess, message) in

        Indicator.shared.hideProgressView()
        if isSuccess{
            let SubcategoryNames = self.viewModel.SubModel?.data?.map({$0.name ?? ""})
            
            self.subCategory_tfld.optionArray = SubcategoryNames ?? []
        }else{
            self.view.makeToast(message , position : .center)
        }
    }
}
    
    func Productcategory(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitProductCategories { (isSuccess, message) in

            Indicator.shared.hideProgressView()
            if isSuccess{
                let ProductcategoryNames = self.viewModel.CatModel?.categories?.map({$0.name ?? ""})
                
                self.category_tfld.optionArray = ProductcategoryNames ?? []
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func InventoryList(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitInventory{ (isSuccess, message) in

            Indicator.shared.hideProgressView()
            if isSuccess{
                let InventoryList = self.viewModel.inventModel?.result?.map({$0.inventoryName ?? ""})
                
                self.inventoryType_tfld.optionArray = InventoryList ?? []
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func ProductTypeList(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitProducttype{ (isSuccess, message) in

            Indicator.shared.hideProgressView()
            if isSuccess{
                let ProductTypes = self.viewModel.TypeModel?.productTypes?.map({$0.productType ?? ""})
                
                self.productType_tfls.optionArray = ProductTypes ?? []
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func CollectionList(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitCollection{ (isSuccess, message) in

            Indicator.shared.hideProgressView()
            if isSuccess{
                let Collection = self.viewModel.CollectModel?.collections?.map({$0.name ?? ""})
                
                self.collectionDrop.optionArray = Collection ?? []
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    
    func VendorList(ProductTypeID : String){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitVendor(ProductTypeID:ProductTypeID ){ (isSuccess, message) in

            Indicator.shared.hideProgressView()
            if isSuccess{
                let VendorNames = self.viewModel.vendorModel?.result?.map({$0.vendorName ?? ""})
                
                self.vendor_tfld.optionArray = VendorNames ?? []
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func hitAPIProfBranch(){
        viewModel.apigetLocation(){ (isSuccess, msg) in
            if(isSuccess){
                self.city = self.viewModel.LocationModel?.result?.map{$0.branchAddress?.city ?? ""} ?? []
                self.BranchName = self.viewModel.LocationModel?.result?.map{$0.branchNameEn ?? ""} ?? []
                self.BranchID = self.viewModel.LocationModel?.result?.map{$0.id ?? ""} ?? []
                self.stockLocationsTab.reloadData()
                
            }else{
                print("Hit Fail")
                self.view.makeToast(msg)
            }
        }
    }
    
}
 
