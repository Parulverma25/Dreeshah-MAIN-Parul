//
//  ContactDetailViewController.swift
//  Dreeshah
//
//  Created by Apple on 22/03/21.
//

import UIKit
import AnimatedField
import FlagPhoneNumber


class ContactDetailViewController: UIViewController {

    @IBOutlet weak var nameInEnglish: AnimatedField!
    @IBOutlet weak var nameInArabic: AnimatedField!
    @IBOutlet weak var branchEmail: AnimatedField!
    @IBOutlet weak var branchWebsite: AnimatedField!
    @IBOutlet weak var intagram: AnimatedField!
    @IBOutlet weak var youtube: AnimatedField!
    @IBOutlet weak var mobileNumber: AnimatedField!
    @IBOutlet weak var businessMobileNumbe: AnimatedField!
    
    @IBOutlet weak var phoneNumberTextField: FPNTextField!
    
    @IBOutlet weak var businessPhoneNumberTF: FPNTextField!
    
    @IBOutlet weak var topImageHeight: NSLayoutConstraint!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var topHeadingLbl: UILabel!
    
    var format = AnimatedFieldFormat()
    var dataContact = ProfessionalSignUpdata()
    
    var viewModel = PersonalInfoViewModel()
    var isEdit: Bool! = false
    
    var countryCode = "+1"
    var businessCountryCode = "+1"
    
    let counListing : FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    let pTf = FPNTextField()
    var isBranchAdd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pTf.displayMode = .list
        counListing.showCountryPhoneCode = true
        
        counListing.setup(repository: pTf.countryRepository)

        
        mobileNumber.keyboardType = .phonePad
        businessMobileNumbe.keyboardType = .phonePad
        branchEmail.keyboardType = .emailAddress
        
        phoneNumberTextField.isUserInteractionEnabled = false
        phoneNumberTextField.placeholder = nil
        businessPhoneNumberTF.isUserInteractionEnabled = false
        businessPhoneNumberTF.placeholder = nil
        
        nameInEnglish.placeholder = "Co-ordinatoor Name in  English*"
        nameInArabic.placeholder = "Co-ordinator Name in Arabic*"
        branchEmail.placeholder = "Branch Email*"
        branchWebsite.placeholder = "Branch Website"
        intagram.placeholder = "Instagram Account"
        youtube.placeholder = "Youtube Channel"
        mobileNumber.placeholder = "Business Mobile Number*"
        businessMobileNumbe.placeholder = "Business Landline Number*"
        
        format.textColor = .black
        format.lineColor = .black
        format.highlightColor = .black
        //format.alertColor = .red
        //format.counterColor = .blue
        format.titleColor = .black
        
        nameInEnglish.format = format
        nameInArabic.format = format
        branchEmail.format = format
        branchWebsite.format = format
        intagram.format = format
        youtube.format = format
        mobileNumber.format = format
        businessMobileNumbe.format = format
        
        if isEdit{
            nameInEnglish.text = viewModel.dataModel?.data?.contactDetails?.coOrdinatorEng
            nameInArabic.text = viewModel.dataModel?.data?.contactDetails?.coOrdinatorArabic
            branchEmail.text = viewModel.dataModel?.data?.contactDetails?.branchEmail
            branchWebsite.text = viewModel.dataModel?.data?.contactDetails?.branchWebsite
            intagram.text = viewModel.dataModel?.data?.contactDetails?.instaAcc
            youtube.text = viewModel.dataModel?.data?.contactDetails?.youtubeChannel
            mobileNumber.text = viewModel.dataModel?.data?.contactDetails?.mobileNumber
            businessMobileNumbe.text = viewModel.dataModel?.data?.contactDetails?.businessMobileNumber
            
//            phoneNumberTextField.text = viewModel.dataModel?.data?.contactDetails?.countryCode
//            businessPhoneNumberTF.text = viewModel.dataModel?.data?.contactDetails?.businessCountryCode
        }else if isBranchAdd{
            topHeadingLbl.isHidden = true
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
        navigationController?.navigationBar.isHidden = false

        setBackWithTitle(titleVal : "Personal Information")
    }
    
    @IBAction func businessBtn(_ sender: Any) {
        
        if CurrentSession.shared.isProfesstionalSignUp || isBranchAdd{
            if self.nameInEnglish.text == "" {
                self.view.makeToast("Please Enter Name")
            } else if self.nameInArabic.text == "" {
                self.view.makeToast("Please Enter Name")
            }  else if !(Validation().validOnlyArabic(arabicTextField: self.nameInArabic.text ?? "")){
                self.view.makeToast("Please Enter Name in Arabic")
            } else if self.branchEmail.text == "" {
                self.view.makeToast("Please Enter Branch Email")
            } else if !(self.branchEmail.text?.isValidEmail() ?? false) {
                self.view.makeToast("Please Enter valid email")
            } else if !(self.branchWebsite.text?.isValidUrl() ?? false) {
                self.view.makeToast("Please Enter valid url")
            } else if self.mobileNumber.text == "" {
                self.view.makeToast("Please Enter Buisness Mobile Number")
            } else if (mobileNumber.text!.count < 7 || mobileNumber.text!.count > 15) {
                self.view.makeToast("Buisness Mobile Number should be between 7-15")
            } else if self.businessMobileNumbe.text == "" {
                self.view.makeToast("Please Enter Business Landline Number")
    //            } else if self.intagram.text == "" {
    //                self.view.makeToast("Please Enter Instagram Account")
    //            } else if self.youtube.text == "" {
    //                self.view.makeToast("Please Enter Youtube Account")
            } else if (businessMobileNumbe.text!.count < 7 || businessMobileNumbe.text!.count > 15) {
                self.view.makeToast("Business Landline Number should be between 7-15")
            } else {

                self.dataContact.co_ordinator_eng = nameInEnglish.text
                self.dataContact.co_ordinator_arabic = nameInArabic.text
                self.dataContact.branchEmail = branchEmail.text
                self.dataContact.branchWebsite = branchWebsite.text
                self.dataContact.mobileNumber = mobileNumber.text
                self.dataContact.businessMobileNumber = businessMobileNumbe.text
                self.dataContact.instaAccount = intagram.text
                self.dataContact.youtubeAccount = youtube.text
                self.dataContact.countryCode = countryCode
                self.dataContact.BusinessCountryCode = businessCountryCode

                let vc = storyboard?.instantiateViewController(identifier: "BusinessDetailViewController") as! BusinessDetailViewController
                vc.dataBusiness = dataContact
                vc.isBranchAdd = self.isBranchAdd
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
       

    }
    
    
    @IBAction func mobilePicker(_ sender: Any) {
       
        counListing.didSelect = {[weak self] country in
            self?.phoneNumberTextField.setFlag(countryCode: country.code)
            self?.phoneNumberTextField.placeholder = nil
            self!.countryCode = country.phoneCode
        }   
    
        self.openPicker()
    }
    
    @IBAction func busniessMobilePicker(_ sender: Any) {
        
        counListing.didSelect = {[weak self] country in
            self?.businessPhoneNumberTF.setFlag(countryCode: country.code)
            self?.businessPhoneNumberTF.placeholder = nil
            self!.businessCountryCode = country.phoneCode
        }
        self.openPicker()
    }
    
    
    @objc func dismissCountries() {
        counListing.dismiss(animated: true, completion: nil)
    }
    
    
    func openPicker() {
        let navController = UINavigationController(rootViewController: counListing)
        counListing.title = "Countries"
        counListing.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissCountries))

        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}
