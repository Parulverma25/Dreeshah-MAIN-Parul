//
//  GetInstantQuotationViewController.swift
//  Dreesha User
//
//  Created by Promatics on 03/05/21.
//

import UIKit
import SBCardPopup
import CountryPickerView
import WWCalendarTimeSelector
class GetInstantQuotationViewController: UIViewController, WWCalendarTimeSelectorProtocol {

    //MARK: Outlets
    
    
    @IBOutlet weak var QuotationNoVal: UILabel!
    @IBOutlet weak var Datelabelval: UILabel!
    @IBOutlet weak var SubjectVal: UILabel!
    
    @IBOutlet weak var branchListBtn: UIButton!
    
    
    @IBOutlet weak var NameTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var EmailTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var FlagView: CountryPickerView!
    
    @IBOutlet weak var PhNoTxtFld: SkyFloatingLabelTextField!
    
    
    
    @IBOutlet weak var DateTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var SalesRepTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var ServiceNameTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var LocationTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var QuantityTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var ExpectedDateTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var BudgetTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var DescriptionTxtFld: SkyFloatingLabelTextField!
    
    //MARK: VARIABLES
    var viewModel = GetInstantQuotatioinViewModel()
    var Professional_service_idStr = ""
    var quotaionNo = ""
    var Date = ""
    var subject = ""
    var salesRep = ""
    var professionalId = ""
    var branchNames = [String]()
    var isStartDate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Get Instant Quotation")
        setData()
    }
    
    
    func setData(){
        QuotationNoVal.text = "REF\(generatenumber(length: 8))"
        Datelabelval.text = Date
        SubjectVal.text = subject
        //self.SalesRepTxtFld.text = salesRep
        self.ServiceNameTxtFld.text = subject
       // self.QuotaionRefTxtFld.text = "REF\(generatenumber(length: 8))"
        //self.SalesRepTxtFld.isUserInteractionEnabled = false
        self.ServiceNameTxtFld.isUserInteractionEnabled = false
        //self.QuotaionRefTxtFld.isUserInteractionEnabled = false
        FlagView.showCountryCodeInView = false
        
    }
    
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
       dismiss(animated: true, completion: nil)
        let newDate = Singleton.sharedInstance.dateFormatChangeLocal(date: String(describing: date), oldFormat: "yyyy-MM-dd HH:mm:ss Z", newFormat: "yyyy-MM-dd")
        
        if isStartDate{
            self.DateTxtFld.text = newDate
        }else{
            self.ExpectedDateTxtFld.text = newDate
        }
           
        
       
       
    }

    // MARK: - Actions
    
    
    @IBAction func tapChooseExpectedDate(_ sender: Any) {
        
        isStartDate = false
        
        let selector = WWCalendarTimeSelector.instantiate()
        
        showDateCalander(selector: selector)
        
       // selector.optionLayoutTopPanelHeight = 28
        selector.delegate = self
    }
    
    
    @IBAction func tapChooseStartDate(_ sender: Any) {
        isStartDate = true
        
        let selector = WWCalendarTimeSelector.instantiate()
        
        showDateCalander(selector: selector)
        
       // selector.optionLayoutTopPanelHeight = 28
        selector.delegate = self
        
    }
    
    
    @IBAction func SubmitAct(_ sender: UIButton) {
        if self.NameTxtFld.text?.replacingOccurrences(of: " ", with: "") == "" {
            self.view.makeToast("Please enter Name" , position : .center)
        }
        else if self.EmailTxtFld.text == "" {
            self.view.makeToast("Please enter Email" , position : .center)
        }else if !((self.EmailTxtFld.text ?? "").isValidEmail()){
            self.view.makeToast("Please enter valid Email" , position : .center)
        }else if self.PhNoTxtFld.text == "" {
            self.view.makeToast("Please enter Phone Number" , position : .center)
        }else if !((self.PhNoTxtFld.text ?? "").isValidPhone()){
            self.view.makeToast("Please enter valid Phone Number" , position : .center)
        }else if self.DateTxtFld.text == "" {
            self.view.makeToast("Please enter Start Date" , position : .center)
        }else if self.ExpectedDateTxtFld.text == "" {
            self.view.makeToast("Please enter Expected Date" , position : .center)
        }else if self.SalesRepTxtFld.text == "" {
            self.view.makeToast("Please enter Branch of Service" , position : .center)
        }else if self.ServiceNameTxtFld.text == "" {
            self.view.makeToast("Please enter Service Name" , position : .center)
        }else if self.LocationTxtFld.text == "" {
            self.view.makeToast("Please enter Location" , position : .center)
        }else if self.BudgetTxtFld.text == "" {
            self.view.makeToast("Please enter Budget" , position : .center)
        }
        else if self.DescriptionTxtFld.text == "" {
            self.view.makeToast("Please enter Description" , position : .center)
        }else{
            AddQuotation()
        }
        
       
        
    }
    
    @IBAction func cancelAct(_ sender: UIButton) {
    }
    
    
    @IBAction func showListOfBranch(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(identifier: "ServiceListPopUpViewController") as! ServiceListPopUpViewController
       vc.nameArray = branchNames
       vc.idArray = branchNames
        vc.delegate = self
        let card = SBCardPopupViewController(contentViewController: vc)
        card.show(onViewController: self)
    }
    

}
//MARK:- API CALL
extension GetInstantQuotationViewController {
    func AddQuotation(){
        viewModel.hitaddQuotation(professional_service_id: Professional_service_idStr , Name: NameTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", Email: EmailTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", Phno: PhNoTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", QuotaionRef: QuotationNoVal.text ?? "", Date: self.DateTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", Time: "", SalesRep: SalesRepTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", ServiceName: ServiceNameTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", Location: LocationTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", Quantity: QuantityTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", ExpectedDate: ExpectedDateTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", EstimatedBudget: BudgetTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", Description: DescriptionTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", country_code: FlagView.selectedCountry.phoneCode, quotation_no: QuotationNoVal.text ?? "", subject: SubjectVal.text ?? "", professionalId: self.professionalId)
            { (isSucess, message) in
            if isSucess{
                self.showAlertWithAction(Title: "Dreeshah", Message: "Quotation Submitted Sucessfully!", ButtonTitle: "OK") {
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
            else{
                self.showDefaultAlert(Message: message)
            }
        }
    }
}


//MARK:- List Delegates
extension GetInstantQuotationViewController : ServiceDataValue{
    func getValue(name: [String], id: [String]) {
        print(name)
        SalesRepTxtFld.text = name.first
    }
    
    
}
