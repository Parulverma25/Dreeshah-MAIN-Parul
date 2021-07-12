//
//  LoginViewController.swift
//  Dreesha User
//
//  Created by Promatics on 22/03/21.
//

import UIKit

class LoginViewController: UIViewController {
//MARK: OUTLETS
    @IBOutlet weak var LoginButton: SetButton!
    @IBOutlet weak var EmailTxtField: SkyFloatingLabelTextField!
    @IBOutlet weak var PassTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var ForgotPassBtn: UIButton!
    @IBOutlet weak var LoginBtn: SetButton!
    @IBOutlet weak var ContinueBtn: SetButton!
    @IBOutlet weak var PassEyeBtn: UIButton!
    
    //MARK: Variables
    var userType = ""
    var iconClick = true
    let viewmodel = LoginViewModel()
    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customerAutoLogin()
//        ProfessionalAutoLogin()
    }
    
    //MARK: ACTIONS
    
    func customerAutoLogin(){
        EmailTxtField.text = "Aujla@mailinator.com"
        PassTextField.text = "Abc@1234"
    }
    func ProfessionalAutoLogin(){
        EmailTxtField.text = "singh@mailinator.com"
        PassTextField.text = "Abc@1234"
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        if userType == "Professional" {
            CurrentSession.shared.isProfesstionalSignUp = true
            let vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "GeneralDetailViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc =  UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func PassEyeAction(_ sender: Any) {
        if(iconClick == true) {
           PassTextField.isSecureTextEntry = false
            PassEyeBtn.setImage(UIImage(named: "Pass On") ,for: .normal)
        } else {
            PassTextField.isSecureTextEntry = true
            PassEyeBtn.setImage(UIImage(named: "Pass Off"), for: .normal)
        }
        iconClick = !iconClick
    }
    
    
    @IBAction func LoginAct(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if self.EmailTxtField.text == "" {
            self.view.makeToast("Please Enter email" , position : .center)
        } else if !(self.EmailTxtField.text?.isValidEmail() ?? false) {
            self.view.makeToast("Please Enter valid email" , position : .center)
        } else if self.PassTextField.text == "" {
            self.view.makeToast("Please enter password" , position : .center)
        } else {
            Login()
        }

        
//        if CurrentSession.shared.isProfesstional {
//            let vc = storyboard?.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
//            navigationController?.pushViewController(vc, animated: true)
//        } else {
//            self.view.endEditing(true)
//
//            if self.EmailTxtField.text == "" {
//                self.view.makeToast("Please Enter email" , position : .center)
//            } else if !(self.EmailTxtField.text?.isValidEmail() ?? false) {
//                self.view.makeToast("Please Enter valid email" , position : .center)
//            } else if self.PassTextField.text == "" {
//                self.view.makeToast("Please enter password" , position : .center)
//            } else {
//                Login()
//            }
//        }
    }
}

//MARK:- API CALL
extension LoginViewController
{
    func Login(){
        viewmodel.hitUserLogin( Email: EmailTxtField.text?.replacingOccurrences(of: " ", with: "") ?? "", Password: PassTextField.text?.replacingOccurrences(of: " ", with: "") ?? "", UserType: userType.lowercased() )
        { (isSucess, message) in
            if isSucess
            {
                
                self.showAlertWithAction(Title: "Dreeshah", Message: message, ButtonTitle: "Ok") {
                    let vc = self.storyboard?.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                self.showDefaultAlert(Message: message)
            }
        }
    }
}
