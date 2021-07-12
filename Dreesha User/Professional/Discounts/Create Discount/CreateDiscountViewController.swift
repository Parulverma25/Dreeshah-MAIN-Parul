//
//  CreateDiscountViewController.swift
//  Dreeshah
//
//  Created by Promatics on 20/03/21.
//

import UIKit
import DLRadioButton
import iOSDropDown
import WWCalendarTimeSelector
class CreateDiscountViewController: UIViewController, WWCalendarTimeSelectorProtocol {
//MArk Outlets

    
    @IBOutlet weak var CodeTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var PercentageOut: SetButton!
    @IBOutlet weak var FAmountOut: SetButton!
    @IBOutlet weak var FShippingOut: SetButton!
    @IBOutlet weak var BuyXandYOut: SetButton!
    
    
    @IBOutlet weak var PercentageTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var SelectX: DropDown!
    @IBOutlet weak var SelectXLineView: UIView!
    @IBOutlet weak var SelectY: DropDown!
    @IBOutlet weak var SelectYLineView: UIView!
    
    @IBOutlet weak var AllProductOut: SetButton!
    @IBOutlet weak var SpecificCollOut: SetButton!
    @IBOutlet weak var SpecificProduct: SetButton!
    
    @IBOutlet weak var NoneOut: SetButton!
    @IBOutlet weak var MinPurchaseOut: SetButton!
    @IBOutlet weak var MinQuantityOut: SetButton!
    @IBOutlet weak var MinAmountTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var MinAmountHeight: NSLayoutConstraint!
    
    @IBOutlet weak var SelectProduct: DropDown!
    
   
    
    @IBOutlet weak var Cbox1: UIButton!
    
    @IBOutlet weak var Cbox2: UIButton!
    
    @IBOutlet weak var NoUsageTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var NOUsageHeight: NSLayoutConstraint!
    
    
    
    
    @IBOutlet weak var StartdateTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var StartTimeTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var EndDateTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var EndTimeTxtFld: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var SelectproductTxtFldHeight: NSLayoutConstraint!
    
    @IBOutlet weak var DiscountBottom: NSLayoutConstraint!
    
    @IBOutlet weak var SelectXTop: NSLayoutConstraint!
    
    @IBOutlet weak var PercentageTop: NSLayoutConstraint!
    
    @IBOutlet weak var PercentageBottom: NSLayoutConstraint!
    @IBOutlet weak var percentageTxtFldHeight: NSLayoutConstraint!
    @IBOutlet weak var SelectXHeight: NSLayoutConstraint!
    
    @IBOutlet weak var SelectYheight: NSLayoutConstraint!
    
    @IBOutlet weak var ProductUpContant: NSLayoutConstraint!
    
    //MARK: Variables
    var viewModel = CreateDiscountViewModel()
    var CollviewModel = SelectCollectionViewModel()
    var ProductIDVal = ""
    var CollectionIDVal = ""
    var ProductIDXVal = ""
    var ProductIDYVal = ""
    var requirementval = ""
    var UsageTypeVal = ""
    var MinAmountVal = ""
    var UsageValStr = ""
    var DiscountTypeVal = ""
    var toValStr = ""
    var date = ""
    var time = ""
    var pickerType = ""
    var Choosepicker = ""
    
    var ProductsNames = [String]()
    var Collection = [String]()
    
    let radioController: RadioButtonController = RadioButtonController()
    let radioController2: RadioButtonController = RadioButtonController()
    let radioController3: RadioButtonController = RadioButtonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        radioController.buttonsArray = [PercentageOut, FAmountOut,FShippingOut,BuyXandYOut]
        radioController2.buttonsArray = [AllProductOut,SpecificCollOut,SpecificProduct]
        radioController3.buttonsArray = [NoneOut,MinPurchaseOut,MinQuantityOut]
        

        SelectX.didSelect { (name, index, id) in
            self.ProductIDXVal = self.viewModel.ProfessionalModel?.data?[index].id ?? ""
            print(self.ProductIDXVal)
        }
        
        SelectY.didSelect { (name, index, id) in
            self.ProductIDYVal = self.viewModel.ProfessionalModel?.data?[index].id ?? ""
            print(self.ProductIDYVal)
        }
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Create Discount")
        SetConstraints()
       
        
    }
    
    
    //MARK: ACTIONS
    
    
    @IBAction func GenerateCodeBtn(_ sender: UIButton) {
    }
    
    @IBAction func StartDate(_ sender: UIButton) {
        Choosepicker = "date"
        pickerType = "Start Date"
        let selector = WWCalendarTimeSelector.instantiate()
        
        showDateCalander(selector: selector)
        
        
        selector.optionLayoutTopPanelHeight = 28
        selector.delegate = self
    }
    
    @IBAction func EndDate(_ sender: UIButton) {
        Choosepicker = "date"
        pickerType = "End Date"
        let selector = WWCalendarTimeSelector.instantiate()
        
        showDateCalander(selector: selector)
        
        
        selector.optionLayoutTopPanelHeight = 28
        selector.delegate = self
    }
    
    @IBAction func StartTime(_ sender: UIButton) {
        pickerType = "Start Time"
        Choosepicker = "Time"
        
        let selector = WWCalendarTimeSelector.instantiate()
        
        showTimeCalander(selector: selector)
        
        selector.delegate = self
        
    }
    
    @IBAction func EndTime(_ sender: UIButton) {
        pickerType = "End Time"
        Choosepicker = "Time"
        
        let selector = WWCalendarTimeSelector.instantiate()
        
        showTimeCalander(selector: selector)
        
        selector.delegate = self
    }
    
    
    
    //MARK: TYPES RADIO BUTTONS
    
    
    @IBAction func PercentageAct(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender )
        DiscountTypeVal = "percentage"
        
        PercentageTxtFld.placeholder = "Discount Percentage*"
        PercentageTop.constant = 10
        SelectXTop.constant = 50
        percentageTxtFldHeight.constant = 40
        SelectXHeight.constant = 0
        SelectYheight.constant = 0
        PercentageTxtFld.isHidden = false
        SelectX.isHidden = true
        SelectXLineView.isHidden = true
        SelectY.isHidden = true
        SelectYLineView.isHidden = true
        print(DiscountTypeVal)
    }
    
    @IBAction func FixedAmountAct(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender )
        DiscountTypeVal = "amount"
        PercentageTxtFld.placeholder = "Discount Amount*"
        PercentageTop.constant = 10
        SelectXTop.constant = 50
        percentageTxtFldHeight.constant = 40
        SelectXHeight.constant = 0
        SelectYheight.constant = 0
        PercentageTxtFld.isHidden = false
        SelectX.isHidden = true
        SelectXLineView.isHidden = true
        SelectY.isHidden = true
        SelectYLineView.isHidden = true
        print(DiscountTypeVal)
    }
    
    @IBAction func FreeShippingAct(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender )
        DiscountTypeVal = "shipping"
        
        DiscountBottom.constant = 5
        SelectXTop.constant = 5
        percentageTxtFldHeight.constant = 0
        SelectXHeight.constant = 0
        SelectYheight.constant = 0
        PercentageTxtFld.isHidden = true
        SelectX.isHidden = true
        SelectXLineView.isHidden = true
        SelectY.isHidden = true
        SelectYLineView.isHidden = true
        print(DiscountTypeVal)
    }
    
    @IBAction func BuyXGetYACt(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender )
        
//        DiscountBottom.constant = 5
        SelectXTop.constant = 10
        percentageTxtFldHeight.constant = 0
        SelectXHeight.constant = 40
        SelectYheight.constant = 40
        PercentageTxtFld.isHidden = true
        SelectX.isHidden = false
        SelectXLineView.isHidden = false
        SelectY.isHidden = false
        SelectY.placeholder = "Select Y Product*"
        SelectYLineView.isHidden = false
        
    }
    
    @IBAction func Cbox1Btn(_ sender: UIButton) {
        if(Cbox1.currentImage == UIImage(named: "checkbox Off")){
            Cbox1.setImage(UIImage(named: "checkbox On"), for: .normal)
            UsageTypeVal = "usage_limit"
            print(UsageTypeVal)
            Cbox2.setImage(UIImage(named: "checkbox Off"), for: .normal)
            
            NOUsageHeight.constant = 40
            NoUsageTxtFld.isHidden = false
            
            
        }else{
            Cbox1.setImage(UIImage(named: "checkbox Off"), for: .normal)
            NOUsageHeight.constant = 0
            NoUsageTxtFld.isHidden = true
           
        }
    }
    
    
    @IBAction func Cbox2Btn(_ sender: UIButton) {
        if(Cbox2.currentImage == UIImage(named: "checkbox Off")){
            Cbox2.setImage(UIImage(named: "checkbox On"), for: .normal)
            Cbox1.setImage(UIImage(named: "checkbox Off"), for: .normal)
            NOUsageHeight.constant = 0
            NoUsageTxtFld.isHidden = true
            UsageTypeVal = "per_customer"
            print(UsageTypeVal)
           
        }else{
            Cbox2.setImage(UIImage(named: "checkbox Off"), for: .normal)
            NOUsageHeight.constant = 0
            NoUsageTxtFld.isHidden = true
            
        }
    }
    
    
    
    @IBAction func AllProductBtn(_ sender: UIButton) {
        radioController2.buttonArrayUpdated(buttonSelected: sender )
        toValStr = "all"
        ProductUpContant.constant = 0
        SelectProduct.isHidden = true
        
        SelectproductTxtFldHeight.constant = 0
        print(toValStr)
    }
    
    @IBAction func SpecificCollBtn(_ sender: UIButton) {
        radioController2.buttonArrayUpdated(buttonSelected: sender )
        SelectProduct.text = ""
        ProductIDVal = ""
        CollectionList()
        toValStr = "collection"
        ProductUpContant.constant = 19
        SelectProduct.isHidden = false
        SelectProduct.placeholder = "Select Collection"
        SelectproductTxtFldHeight.constant = 40
        self.SelectProduct.optionArray = self.Collection
        print(toValStr)
        
        SelectProduct.didSelect { (name, index, id) in
            self.CollectionIDVal = self.CollviewModel.CollIDModel?.data[index]?.id ?? ""
            print(self.CollectionIDVal)
        }
    }
    
    @IBAction func SpecificProductBtn(_ sender: UIButton) {
        radioController2.buttonArrayUpdated(buttonSelected: sender )
        SelectProduct.text = ""
        toValStr = "product"
        CollectionIDVal = ""
        AllProfessionals()
        ProductUpContant.constant = 19
        SelectProduct.isHidden = false
        SelectProduct.placeholder = "Select Product"
        SelectproductTxtFldHeight.constant = 40
        self.SelectProduct.optionArray = self.ProductsNames
        print(toValStr)
        SelectProduct.didSelect { (name, index, id) in
            self.ProductIDVal = self.viewModel.ProfessionalModel?.data?[index].id ?? ""
            print(self.ProductIDVal)
        }
    }
    
    
    
    @IBAction func NoneBtnAct(_ sender: UIButton) {
        radioController3.buttonArrayUpdated(buttonSelected: sender )
        requirementval = "none"
        print(requirementval)
        MinAmountHeight.constant = 0
        MinAmountTxtFld.isHidden = true
        
    }
    
    @IBAction func MinPurchaseAct(_ sender: UIButton) {
        radioController3.buttonArrayUpdated(buttonSelected: sender )
        requirementval = "amount"
        print(requirementval)
        
        MinAmountHeight.constant = 40
        MinAmountTxtFld.isHidden = false
        MinAmountTxtFld.placeholder = "Minimum Amount*"
    }
    
    @IBAction func MinQuantityAct(_ sender: UIButton) {
        radioController3.buttonArrayUpdated(buttonSelected: sender )
        requirementval = "item"
        print(requirementval)
        MinAmountHeight.constant = 40
        MinAmountTxtFld.isHidden = false
        MinAmountTxtFld.placeholder = "Minimum Quantity*"
    }
    
    
    
    @IBAction func GenerateCode(_ sender: UIButton) {
        
        let length = 6
        let characters = "0123456789"
        let randomCharacters = (0..<length).map{_ in characters.randomElement()!}
        let randomString = String(randomCharacters)
        
        
        CodeTxtFld.text = "DC\(randomString)"
    }
    
    
    
    
    //MARK: Functions
    
    func SetConstraints(){
        NOUsageHeight.constant = 0
        NoUsageTxtFld.isHidden = true
        
        ProductUpContant.constant = 0
        SelectProduct.isHidden = true
        
        SelectproductTxtFldHeight.constant = 0
        
        DiscountBottom.constant = 5
        SelectXTop.constant = 5
        percentageTxtFldHeight.constant = 0
        SelectXHeight.constant = 0
        SelectYheight.constant = 0
        PercentageTxtFld.isHidden = true
        SelectX.isHidden = true
        SelectXLineView.isHidden = true
        SelectY.isHidden = true
        SelectYLineView.isHidden = true
        
        MinAmountHeight.constant = 0
        MinAmountTxtFld.isHidden = true
    }
    
    
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        if  Choosepicker == "date"{
            
            
            let newDate = Singleton.sharedInstance.dateFormatChangeLocal(date: String(describing: date), oldFormat: "yyyy-MM-dd HH:mm:ss Z", newFormat: "yyyy-MM-dd")
            
            
        self.date = Singleton.sharedInstance.dateFormatChangeLocal(date: String(describing: date), oldFormat: "yyyy-MM-dd HH:mm:ss Z", newFormat: "yyyy-MM-dd")
        
        self.time = Singleton.sharedInstance.dateFormatChangeLocal(date: String(describing: date), oldFormat: "yyyy-MM-dd HH:mm:ss Z", newFormat: "h:mm a")
            if pickerType == "Start Date"{
            self.StartdateTxtFld.text = newDate
            }else{
                
                if StartdateTxtFld.text ?? "" >= newDate{
                showAlert(Title: "Dreeshah", Message: "Please Select Date After Start Date", ButtonTitle: "OK")
                }else{
                self.EndDateTxtFld.text = newDate
                }
            }
        }else{
            let newtime  = Singleton.sharedInstance.dateFormatChangeLocal(date: String(describing: date), oldFormat: "yyyy-MM-dd HH:mm:ss Z", newFormat: "h:mm a")
            
            self.time = Singleton.sharedInstance.dateFormatChangeLocal(date: String(describing: date), oldFormat: "yyyy-MM-dd HH:mm:ss Z", newFormat: "h:mm a")
            if pickerType == "Start Time"{
            self.StartTimeTxtFld.text = newtime
            }else{
                
                self.EndTimeTxtFld.text = newtime
            }
        }
       
    }
    
    
    @IBAction func CreateButton(_ sender: UIButton) {
        if CodeTxtFld.text == "" {
            view.makeToast("Please Enter Discount Code", position : .center)
        }else if DiscountTypeVal == ""{
            view.makeToast("Please Choose Discount Type", position : .center)
        }else if toValStr == ""{
            view.makeToast("Please Choose Applies to Options", position : .center)
        }else if StartdateTxtFld.text == ""{
            view.makeToast("Please Choose Start Date", position : .center)
        }else if EndDateTxtFld.text == ""{
            view.makeToast("Please Choose End Date", position : .center)
        }else{
        CreteDiscount()
    }
}
}
//MARK: API
extension CreateDiscountViewController{
    
    func CreteDiscount(){
        
        viewModel.hitDiscount(discount_coupon: CodeTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", discount_value: Int(String(PercentageTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "")) ?? 0, discount_type: DiscountTypeVal, TO: toValStr, ProductID: ProductIDVal, CollectionID: CollectionIDVal, Requirement: requirementval, Value: MinAmountTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", date_time: StartdateTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", usage_type: UsageTypeVal, usage_value: NoUsageTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", X: ProductIDXVal, Y: ProductIDYVal, expiry_date: EndDateTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "") { (isSuccess, message) in
           
            if isSuccess{
                self.showAlertWithAction(Title: "Dreeshah", Message: "Discount Added!", ButtonTitle: "Ok") {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            else{
                self.showDefaultAlert(Message: message)
            }
        }
    }
    
    func AllProfessionals(){
        
            Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitProfessionalsWithoutPagination(){ (isSuccess, message) in

                Indicator.shared.hideProgressView()
                if isSuccess{
                    self.ProductsNames = self.viewModel.getProfDta()?.data?.map({$0.productTitle ?? ""}) ?? []
                    
                    self.SelectX.optionArray = self.ProductsNames
                    self.SelectY.optionArray = self.ProductsNames
                    
                }else{
                    self.view.makeToast(message , position : .center)
                }
            }
        }
    
    func CollectionList(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        CollviewModel.hitCollectionIDs{ (isSuccess, message) in

            Indicator.shared.hideProgressView()
            if isSuccess{
                self.Collection = self.CollviewModel.CollIDModel?.data.map({$0?.collectionName ?? ""}) ?? []
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
        
    }
    

