//
//  AddressDetailViewController.swift
//  Dreeshah
//
//  Created by Apple on 22/03/21.
//

import UIKit
import AnimatedField
import CountryPickerView

class AddressDetailViewController: UIViewController {
    
    //MARK:- Outlets
    
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
    
//    @IBOutlet weak var pincodeView: AnimatedField!
//    @IBOutlet weak var houseView: AnimatedField!
//    @IBOutlet weak var areaView: AnimatedField!
//    @IBOutlet weak var landmarkView: AnimatedField!
//    @IBOutlet weak var cityView: AnimatedField!
//    @IBOutlet weak var stateView: AnimatedField!
//
//    @IBOutlet weak var home: SetButton!
//    @IBOutlet weak var office: SetButton!
//
    
    @IBOutlet weak var topHeadingLbl: UILabel!
    @IBOutlet weak var topImageHeight: NSLayoutConstraint!
    @IBOutlet weak var topImage: UIImageView!
//    @IBOutlet weak var bottomAddViewHeight: NSLayoutConstraint!
//    @IBOutlet weak var bottomAddView: UIView!
    
    var format = AnimatedFieldFormat()
    
    var dataAddress = ProfessionalSignUpdata()
    var viewModelA = SignupViewModel()

    
    var viewModel = PersonalInfoViewModel()
    var isEdit: Bool! = false
    
    var isBranchAdd = false

    
    let countryPickerView = CountryPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataAddress.certificateAward)
        
//        pincodeView.placeholder = "Pin Code*"
//        houseView.placeholder = "Flat, House no, Building, Company*"
//        areaView.placeholder = "Area, Colony, Street, Scetor*"
//        landmarkView.placeholder = "Nearest Landmark"
//        cityView.placeholder = "City*"
//        stateView.placeholder = "State*"
//
//        pincodeView.keyboardType = .phonePad
        
        format.textColor = .black
        format.lineColor = .black
        format.highlightColor = .black
        //format.alertColor = .red
        //format.counterColor = .blue
        format.titleColor = .black
        
        format.alertTitleActive = true
        
        
//        pincodeView.format = format
//        houseView.format = format
//        areaView.format = format
//        landmarkView.format = format
//        cityView.format = format
//        stateView.format = format
//
        
       
    
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
    
    
    @IBAction func tapShowCountry(_ sender: Any) {
        countryPickerView.delegate = self
        countryPickerView.showCountriesList(from: self)
    }
    
 
    
    @IBAction func contactBtn(_ sender: Any) {
        if CurrentSession.shared.isProfesstionalSignUp || isBranchAdd {
            if self.CountryTxtFld.text == "Select Country" {
                self.view.makeToast("Please Select Country")
            } else if self.StateTxtFld.text == "" {
                self.view.makeToast("Please Enter State")
            }  else if self.PhoneNumTxtFld.text == "" {
                self.view.makeToast("Please Enter Contact number")
            }  else if self.FirstNameTxtFld.text == "" {
                self.view.makeToast("Please Enter First Name")
            }  else if self.LastNameTxtFld.text == "" {
                self.view.makeToast("Please Enter Last Name")
            }  else if self.AddressLine1.text == "" {
                self.view.makeToast("Please Enter Address Line 1")
            }   else if self.AddressLine2.text == "" {
                self.view.makeToast("Please Enter Address Line 2")
            }  else if self.CityTxtFld.text == "" {
                self.view.makeToast("Please Enter City")
            } else {
                self.dataAddress.phoneCode = self.countryCode.selectedCountry.phoneCode
                self.dataAddress.country = self.CountryTxtFld.text ?? ""
                self.dataAddress.pincode = PincodeTxtFld.text ?? ""
                self.dataAddress.state = StateTxtFld.text ?? ""
                self.dataAddress.addFirstName = FirstNameTxtFld.text ?? ""
                self.dataAddress.addLastName = LastNameTxtFld.text ?? ""
                self.dataAddress.city = CityTxtFld.text ?? ""
                self.dataAddress.addressLine1 = AddressLine1.text ?? ""
                self.dataAddress.addressLine2 = AddressLine2.text ?? ""
                self.dataAddress.landmark = landmark.text ?? ""

                let vc = storyboard?.instantiateViewController(identifier: "ContactDetailViewController") as! ContactDetailViewController
                vc.dataContact = dataAddress
                vc.isBranchAdd = self.isBranchAdd
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            
            
          
            self.navigationController?.popViewController(animated: true)
    }
            
        
//        let vc = storyboard?.instantiateViewController(identifier: "ContactDetailViewController") as! ContactDetailViewController
//                vc.dataContact = dataAddress
//                vc.isBranchAdd = self.isBranchAdd
//                self.navigationController?.pushViewController(vc, animated: true)


    }
}
//MARK:- Country Picker delegates
extension AddressDetailViewController : CountryPickerViewDelegate{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.CountryTxtFld.text = country.name
    }
    
    
}
