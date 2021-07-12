//
//  SignUpViewController.swift
//  Dreesha User
//
//  Created by Promatics on 23/03/21.
//
import UIKit
import iOSDropDown
import Toast_Swift
class SignUpViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var FirstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var LastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var PhoneNoTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var EmailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var CnfrmPassTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var PassTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var CountryTextField: DropDown!
    @IBOutlet weak var City: DropDown!
    @IBOutlet weak var SMSBtn: UIButton!
    @IBOutlet weak var MobileBtn: UIButton!
    @IBOutlet weak var PassEyeBtn: UIButton!
    @IBOutlet weak var CnfrmPassEyeBtn: UIButton!
    @IBOutlet weak var SignupButton: SetButton!
    
    @IBOutlet weak var actualCity: UITextField!
    
    //MARK: Variables
    var iconClick = true
    let radioController: RadioButtonController = RadioButtonController()
    var validation = Validation()
    var viewModel = SignupViewModel()
    var isChecked = false
    
    
    //MARK: VIEW DID LOAD
    override func viewDidLoad()
    {
        super.viewDidLoad()
        radioController.buttonsArray = [SMSBtn,MobileBtn]
        radioController.defaultButton = SMSBtn
        navigationController?.navigationBar.isHidden = true
        self.hideKeyboardWhenTappedAround()
        CountryTextField.inputView=UIView()
        City.inputView=UIView()
        CountryTextField.didSelect { (name, index, id) in
            self.City.optionArray = []
            self.singleCity(countryCode: self.viewModel.countryModel?.data?[index].isoCode ?? "")
        
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        country()
//        autoSignupDataSet()
    }
    
    
    func autoSignupDataSet(){
        FirstNameTextField.text="Iam"
        LastNameTextField.text="Varjeet"
        PhoneNoTextField.text="9876543210"
        EmailTextField.text="IamVarjeet@mailinator.com"
        PassTextField.text="Varjeet@7"
        CnfrmPassTextField.text="Varjeet@7"
        CountryTextField.text = "India"
        City.text = "Punjab"
    }
    
    //MARK: Actions
    @IBAction func PassEyeBtn(_ sender: UIButton) {
        if(iconClick == true) {
            PassTextField.isSecureTextEntry = false
            PassEyeBtn.setImage(UIImage(named: "Pass On") ,for: .normal)
        } else {
            PassTextField.isSecureTextEntry = true
            PassEyeBtn.setImage(UIImage(named: "Pass Off"), for: .normal)
        }
        iconClick = !iconClick
    }
    
    @IBAction func CnfrmPassEyeBtn(_ sender: UIButton) {
        if(iconClick == true) {
            CnfrmPassTextField.isSecureTextEntry = false
            CnfrmPassEyeBtn.setImage(UIImage(named: "Pass On") ,for: .normal)
        } else {
            CnfrmPassTextField.isSecureTextEntry = true
            CnfrmPassEyeBtn.setImage(UIImage(named: "Pass Off"), for: .normal)
        }
        iconClick = !iconClick
    }
    
    @IBAction func SMSActBtn(_ sender: Any) {
        radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
    }
    
    @IBAction func MobileActBtn(_ sender: Any)
    {
        radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
    }
    
    @IBAction func SignupAction(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        if self.FirstNameTextField.text?.replacingOccurrences(of: " ", with: "") == "" {
            self.view.makeToast("Please enter first name" , position : .center)
        }
        else if self.LastNameTextField.text == "" {
            self.view.makeToast("Please enter last name" , position : .center)
        }
        else if self.EmailTextField.text == "" {
            self.view.makeToast("Please enter email" , position : .center)
        }
        else if !(self.EmailTextField.text?.isValidEmail() ?? false) {
            self.view.makeToast("Please enter valid email" , position : .center)
        }
        else if self.PhoneNoTextField.text == "" {
            self.view.makeToast("Please enter contact" , position : .center)
        }
        else if !(self.PhoneNoTextField.text?.isValidPhone() ?? false) {
            self.view.makeToast("Please enter valid contact" , position : .center)
        }
        else if self.PassTextField.text == "" {
            self.view.makeToast("Please enter password" , position : .center)
        }else if !(self.PassTextField.text?.isValidPassword() ?? false) {
            self.view.makeToast("Please enter valid Password" , position : .center)
        }
        else if self.PassTextField.text?.count ?? 0 < 8 {
            self.view.makeToast("Password cannot be less than 8 characters" , position : .center)
        }
        else if self.CnfrmPassTextField.text == "" {
            self.view.makeToast("Please confirm your password" , position : .center)
        }
        else if (self.PassTextField.text != self.CnfrmPassTextField.text) {
            self.view.makeToast("Password confirmation does not match" , position : .center)
        }
        else if self.CountryTextField.text == "" {
            self.view.makeToast("Please enter Country" , position : .center)
        }
        else if self.City.text == "" {
            self.view.makeToast("Please enter City" , position : .center)
        }
     else{
   checkAvailablity()
    }
}
    @IBAction func LoginBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func TermsConditionsBtnAct(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "Terms_ConditionViewController") as! Terms_ConditionViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
        
    }
    //MARK:- API CALL
    extension SignUpViewController {
        
        func checkAvailablity(){
            
            viewModel.apiCheckExist(email: EmailTextField.text?.replacingOccurrences(of: " ", with: "") ?? "", contact: PhoneNoTextField.text?.replacingOccurrences(of: " ", with: "") ?? "" ){ (isSucess,message) in
                if isSucess{
                    self.signup()
                   
                }else{
                    self.view.makeToast(message , position : .center)
                }
            }
            
        }
        
        func signup(){
      
            viewModel.hitUserSignup(FirstName: FirstNameTextField.text?.replacingOccurrences(of: " ", with: "") ?? "", LastName: LastNameTextField.text?.replacingOccurrences(of: " ", with:"") ?? "", UserType: "customer", Country:CountryTextField.text?.replacingOccurrences(of: " ", with: "") ?? "",
                                    State: City.text?.replacingOccurrences(of: " ", with: "") ?? "", city: actualCity.text?.replacingOccurrences(of: " ", with: "") ?? "",
                                    Email: EmailTextField.text?.replacingOccurrences(of: " ", with: "") ?? "",
                                    Password: PassTextField.text?.replacingOccurrences(of: " ", with: "") ?? "",
                                    Phoneno: PhoneNoTextField.text?.replacingOccurrences(of: " ", with: "") ?? "")
            { (isSucess, message) in
                if isSucess{
                    self.showAlertWithAction(Title: "Dreeshah", Message: message, ButtonTitle: "Ok") {
                        let vc = self.storyboard?.instantiateViewController(identifier: "OtpVerificationViewController") as! OtpVerificationViewController
                        vc.token = UserDefaults.standard.value(forKey: "token") as? String ?? ""
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                else{
                    
                    self.showDefaultAlert(Message: message)
                    
                }
            }
        }
        
        func country(){
            Indicator.shared.showProgressView(self.parent?.view ?? self.view)
            viewModel.hitUserCountry(){(isSuccess , message) in
                
                Indicator.shared.hideProgressView()
                if isSuccess{
                    
                    let countryNames = self.viewModel.countryModel?.data?.map({$0.name ?? ""})
                    
                    self.CountryTextField.optionArray = countryNames ?? []
                }else{
                    self.view.makeToast(message , position : .center)
                }
            }
        }
        
        
        func singleCity(countryCode : String){
            Indicator.shared.showProgressView(self.parent?.view ?? self.view)
            viewModel.hitUserSingleCity(CountryCode: countryCode){(isSuccess , message) in
                
                Indicator.shared.hideProgressView()
                if isSuccess{
                    
                    let cityNames = self.viewModel.cityModel?.data?.map({$0.name ?? ""})
                    
                    self.City.optionArray = cityNames ?? []
                }else{
                    self.view.makeToast(message , position : .center)
                }
            }
        }
        
        func city(countryCode : [String]){
            Indicator.shared.showProgressView(self.parent?.view ?? self.view)
            viewModel.hitUserCity(CountryCode: countryCode){(isSuccess , message) in
                
                Indicator.shared.hideProgressView()
                if isSuccess{
                    
                    let cityNames = self.viewModel.cityModel?.data?.map({$0.name ?? ""})
                    
                    self.City.optionArray = cityNames ?? []
                }else{
                    self.view.makeToast(message , position : .center)
                }
            }
        }
    }

