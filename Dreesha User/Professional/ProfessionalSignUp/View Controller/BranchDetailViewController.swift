//
//  BranchDetailViewController.swift
//  Dreeshah
//
//  Created by Apple on 23/03/21.
//

import UIKit
import AnimatedField

class BranchDetailViewController: UIViewController {
    
    var format = AnimatedFieldFormat()
    
    var viewModel = SignupViewModel()
    var dataBranch = ProfessionalSignUpdata()
    
    var viewModelP = PersonalInfoViewModel()
    
    @IBOutlet weak var topImageHeight: NSLayoutConstraint!
    @IBOutlet weak var topImage: UIImageView!
    
    var isEdit: Bool! = false
    var isBranchAdd = false
    @IBOutlet weak var addBranchView: AnimatedField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBranchView.placeholder = "Add Branches"
        format.textColor = .black
        format.lineColor = .black
        format.highlightColor = .black
        format.titleColor = .black
        
        addBranchView.format = format
        addBranchView.keyboardType = .phonePad
        
        if isEdit {
            addBranchView.text = String((viewModelP.dataModel?.data?.noOfBranches)!)
        }else if isBranchAdd{
            topImageHeight.constant = 60
            topImage.isHidden = true
        }
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
    
    @IBAction func submitBtn(_ sender: Any) {
        if CurrentSession.shared.isProfesstionalSignUp {
            if self.addBranchView.text == "" {
                self.view.makeToast("Please Enter Branch")
            } else {
                self.dataBranch.noOfBranches = addBranchView.text
                dump(self.dataBranch)
                SignUpProfesstional()
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}


extension BranchDetailViewController {
    
    func SignUpProfesstional() {
        
        viewModel.hitProfessionalSignup(FirstName: self.dataBranch.firstName ?? "", LastName: self.dataBranch.lastName ?? "", UserType: "professional", Email: self.dataBranch.email!, Password: self.dataBranch.password!, branchNameEn: self.dataBranch.branchNameEn!, branchNameAr: self.dataBranch.branchNameAr!, branchTypeId: self.dataBranch.branchTypeId!, branchCategoryId: self.dataBranch.branchCategoryId!, branchBrief: self.dataBranch.branchBrief!, certificateAward: self.dataBranch.certificateAward, noOfBranches: self.dataBranch.noOfBranches!, country: self.dataBranch.country ?? "", country_ph_code: self.dataBranch.phoneCode ?? "", phoneNumber: self.dataBranch.phoneNumber ?? "", addFirstName: self.dataBranch.addFirstName ?? "", addLastName: self.dataBranch.addLastName ?? "", addLine1: self.dataBranch.addressLine1 ?? "", addLine2: self.dataBranch.addressLine2 ?? "", pincode: self.dataBranch.pincode ?? "", landmark: self.dataBranch.landmark ?? "", state: self.dataBranch.state ?? "", city: self.dataBranch.city ?? "", co_ordinator_eng: self.dataBranch.co_ordinator_eng ?? "", co_ordinator_arabic: self.dataBranch.co_ordinator_arabic ?? "", branchEmail: self.dataBranch.branchEmail ?? "", branchWebsite: self.dataBranch.branchWebsite ?? "", countryCode: self.dataBranch.countryCode ?? "", businessCountryCode: self.dataBranch.BusinessCountryCode ?? "", mobileNumber: self.dataBranch.mobileNumber ?? "", businessMobileNumber: self.dataBranch.businessMobileNumber ?? "", instaAccount: self.dataBranch.instaAccount ?? "", youtubeAccount: self.dataBranch.youtubeAccount ?? "", branchYear: self.dataBranch.branchYear ?? 0, issued_in_countries: self.dataBranch.issued_in_countries, issued_in_cities: self.dataBranch.issued_in_cities, branchLicence: self.dataBranch.branchLicence ?? "", licenceNumber: self.dataBranch.licenceNumber ?? "", no_of_emp: self.dataBranch.no_of_emp ?? "", serviceCategories: self.dataBranch.services_products, serviceSubCate: self.dataBranch.serviceSubCategories, newCategories: self.dataBranch.newServiceCate, serviceCountry: self.dataBranch.serviceCountry, serviceCity: self.dataBranch.serviceCity, serviceCost: self.dataBranch.serviceCost ?? "") { (isSuccess, message) in
            if isSuccess {
                self.showAlertWithAction(Title: "Dreeshah", Message: "Signed Up Successfully!", ButtonTitle: "Ok") {
                    let vc =  UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    vc.userType = "Professional"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else {
                self.showDefaultAlert(Message: message)
            }
        }
        
    }
    
//    func SignUpProfesstional() {
//        viewModel.hitProfessionalSignup(FirstName: self.dataBranch.firstName!, LastName: self.dataBranch.lastName!, UserType: self.dataBranch.userType, Email: self.dataBranch.email!, Password: self.dataBranch.password!, branchNameEn: self.dataBranch.branchNameEn!, branchNameAr: self.dataBranch.branchNameAr!, branchTypeId: self.dataBranch.branchTypeId!, branchCategoryId: self.dataBranch.branchCategoryId!, branchBrief: self.dataBranch.branchBrief!, certificateAward: self.dataBranch.certificateAward, noOfBranches: self.dataBranch.noOfBranches!, pincode: self.dataBranch.pincode!, houseNo: self.dataBranch.houseNo!, area: self.dataBranch.area!, landmark: self.dataBranch.landmark!, state: self.dataBranch.state!, city: self.dataBranch.city!, co_ordinator_eng: self.dataBranch.co_ordinator_eng!, co_ordinator_arabic: self.dataBranch.co_ordinator_arabic!, branchEmail: self.dataBranch.branchEmail!, branchWebsite: self.dataBranch.branchWebsite!, countryCode: self.dataBranch.countryCode!, businessCountryCode: self.dataBranch.BusinessCountryCode!, mobileNumber: self.dataBranch.mobileNumber!, businessMobileNumber: self.dataBranch.businessMobileNumber!, instaAccount: self.dataBranch.instaAccount, youtubeAccount: self.dataBranch.youtubeAccount, branchYear: self.dataBranch.branchYear, issued_in_countries: self.dataBranch.issued_in_countries, issued_in_cities: self.dataBranch.issued_in_cities, branchLicence: self.dataBranch.branchLicence, licenceNumber: self.dataBranch.licenceNumber, no_of_emp: self.dataBranch.no_of_emp, services_products: self.dataBranch.services_products, serviceCountry: self.dataBranch.serviceCountry, serviceCity: self.dataBranch.serviceCity, serviceCost: self.dataBranch.serviceCost) { (isSuccess, message) in
//             print(message)
//                if isSuccess {
//                    self.showAlertWithAction(Title: "Dreeshah", Message: "Signed Up Successfully!", ButtonTitle: "Ok") {
//                    let vc =  UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                    vc.userType = "Professional"
//                    self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                }
//                else {
//                    self.showDefaultAlert(Message: message)
//                }
//        }
//    }
    
}
