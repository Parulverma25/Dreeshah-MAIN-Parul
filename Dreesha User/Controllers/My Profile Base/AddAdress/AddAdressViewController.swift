//
//  AddAdressViewController.swift
//  Dreesha User
//
//  Created by Promatics on 10/03/21.
//

import UIKit
import iOSDropDown
import CountryPickerView
class AddAdressViewController: UIViewController {
    
    //MARK: Outlets
  
    @IBOutlet weak var HomeBtn: UIButton!
    @IBOutlet weak var OfficeBtn: UIButton!
    @IBOutlet weak var OthersBtn: UIButton!
    @IBOutlet weak var SaveBtn: SetButton!
    @IBOutlet weak var FirstNameTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var LastNameTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var AddressLine1: SkyFloatingLabelTextField!
    @IBOutlet weak var AddressLine2: SkyFloatingLabelTextField!
//    @IBOutlet weak var StreetNameTxtFld: SkyFloatingLabelTextField!
//
//    @IBOutlet weak var AreaTxtFld: SkyFloatingLabelTextField!
//    @IBOutlet weak var BuildingNameTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var landmark: SkyFloatingLabelTextField!
    @IBOutlet weak var CountryTxtFld: UILabel!
    @IBOutlet weak var StateTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var CityTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var PincodeTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var PhoneNumTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var countryCode: CountryPickerView!
    //MARK: Varaibles
    var viewModel = AddAddressViewModel()
    var viewModelSign = SignupViewModel()
    let radioController: RadioButtonController = RadioButtonController()
    var comefrom = ""
    var FirstNameStr=""
    var LastNameStr=""
    var AddressTitleStr = ""
    var AddressTypeStr = ""
    var countryStr = ""
    var cityStr = ""
    var add_id = ""
    var PincodeStr = ""
    var StateStr=""
    var PhoneNumStr = ""
    var addressLine1 = ""
    var addressLine2 = ""
    var phoneCode = ""
    var landmarkVal = ""
    let countryPickerView = CountryPickerView()
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        radioController.buttonsArray = [HomeBtn,OfficeBtn,OthersBtn]
        radioController.defaultButton = HomeBtn
        self.hideKeyboardWhenTappedAround()
    }
    //MARK: Actions
    
    @IBAction func SaveBtn(_ sender: Any) {
          
            self.view.endEditing(true)
            
        
        if radioController.selectedButton == HomeBtn{
            AddressTypeStr = "home"
        }else if radioController.selectedButton == OfficeBtn{
            AddressTypeStr = "office"
        }else{
            AddressTitleStr = "others"
        }
        
        
        if self.CountryTxtFld.text == "Select Country" {
            self.view.makeToast("Please Select Country" , position : .center)
        } else if self.PhoneNumTxtFld.text == "" {
            self.view.makeToast("Please enter contact" , position : .center)
        }
        else if !(self.PhoneNumTxtFld.text?.isValidPhone() ?? false) {
            self.view.makeToast("Please enter valid contact" , position : .center)
        }else if self.FirstNameTxtFld.text?.replacingOccurrences(of: " ", with: "") == "" {
                self.view.makeToast("Please enter first name" , position : .center)
            }
            else if self.LastNameTxtFld.text == "" {
                self.view.makeToast("Please enter last name" , position : .center)
            }
            
            
            else if self.AddressLine1.text == "" {
                self.view.makeToast("Please add address line 1" , position : .center)
            }else if self.AddressLine2.text == "" {
                self.view.makeToast("Please add address line 2" , position : .center)
            }
            else if self.CityTxtFld.text == "" {
                self.view.makeToast("Please enter City" , position : .center)
            } else if self.landmark.text == "" {
                self.view.makeToast("Please enter Landmark" , position : .center)
            } else if self.PincodeTxtFld.text == "" {
                self.view.makeToast("Please enter PinCode" , position : .center)
            }else{
                if comefrom == "edit"{
                    editAddress()
                }else{
                    addAddress()
                }
            }
       

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        if comefrom == "edit"{
            setdata()
            setBackWithTitle(titleVal : "Edit Address")
            
        }else if comefrom == "new"{
            setBackWithTitle(titleVal : "My Profile")
            
        }else{
            setBackWithTitle(titleVal : "Add Address")
            
        }
    }
    func setdata()  {
            
        if AddressTypeStr == "home"{
            radioController.selectedButton = HomeBtn
        }else if  AddressTypeStr == "office"{
            radioController.selectedButton = OfficeBtn
        }else{
            radioController.selectedButton = OthersBtn
            
        }
        
            self.FirstNameTxtFld.text = FirstNameStr
            self.LastNameTxtFld.text = LastNameStr
            self.AddressLine1.text = addressLine1
            self.AddressLine2.text = addressLine2
            self.CountryTxtFld.text = countryStr
            self.StateTxtFld.text = StateStr
            self.CityTxtFld.text = cityStr
            self.PincodeTxtFld.text = PincodeStr
            self.countryCode.setCountryByPhoneCode(self.phoneCode)
            self.PhoneNumTxtFld.text = PhoneNumStr
            self.landmark.text = landmarkVal
    }
    
    @IBAction func HomeActBtn(_ sender: Any) {
        radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
    }
    
    @IBAction func OfficeActBtn(_ sender: Any)
    {
        radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
    }
    
    @IBAction func OthersActBtn(_ sender: Any)
    {
        
        radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
    }
    
    
    @IBAction func tapShowCountry(_ sender: Any) {
        countryPickerView.delegate = self
        countryPickerView.showCountriesList(from: self)
    }
    
    
    
}

//MARK:- Country Picker delegates
extension AddAdressViewController : CountryPickerViewDelegate{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.CountryTxtFld.text = country.name
    }
    
    
}

//MARK:- API CALL
extension AddAdressViewController {
    func addAddress(){
        

        viewModel.hitaddAddress(FirstName: FirstNameTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", LastName: LastNameTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", AddressLine1: AddressLine1.text?.replacingOccurrences(of: " ", with: "") ?? "", AddressLine2: AddressLine2.text?.replacingOccurrences(of: " ", with: "") ?? "", City: CityTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", State: StateTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", ZipCode: PincodeTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", PhoneNum: PhoneNumTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", landmark: landmark.text?.replacingOccurrences(of: " ", with: "") ?? "", addresstype: self.AddressTypeStr, Country: self.CountryTxtFld.text ?? "", countryCode: countryCode.selectedCountry.phoneCode) { (isSuccess, message) in
            if isSuccess{
                self.showAlertWithAction(Title: "Dreesha", Message: "Address Added!", ButtonTitle: "Ok") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                self.showDefaultAlert(Message: message)
            }

        }
    }
    func editAddress(){
        
        viewModel.hiteditAddress(FirstName: FirstNameTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", LastName: LastNameTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", AddressLine1: AddressLine1.text?.replacingOccurrences(of: " ", with: "") ?? "", AddressLine2: AddressLine2.text?.replacingOccurrences(of: " ", with: "") ?? "", City: CityTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", State: StateTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", ZipCode: PincodeTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", PhoneNum: PhoneNumTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "", landmark: landmark.text?.replacingOccurrences(of: " ", with: "") ?? "", addresstype: self.AddressTypeStr, Country: self.CountryTxtFld.text ?? "", countryCode: countryCode.selectedCountry.phoneCode) { (isSuccess, message) in
            if isSuccess{
                self.showAlertWithAction(Title: "Dreesha", Message: message, ButtonTitle: "Ok") {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            else{
                self.showDefaultAlert(Message: message)
            }
        }
        
        
    }
}
