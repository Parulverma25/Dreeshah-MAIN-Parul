//
//  OtpVerificationViewController.swift
//  Dreesha User
//
//  Created by Promatics on 07/04/21.
//

import UIKit

class OtpVerificationViewController: UIViewController, UITextFieldDelegate {
//MARK: Outlets
    @IBOutlet weak var first: SkyFloatingLabelTextField!
    @IBOutlet weak var second: SkyFloatingLabelTextField!
    @IBOutlet weak var third: SkyFloatingLabelTextField!
    @IBOutlet weak var fourth: SkyFloatingLabelTextField!
    @IBOutlet weak var fifth: SkyFloatingLabelTextField!
    @IBOutlet weak var sixth: SkyFloatingLabelTextField!
//MARK: Variables
    var viewModel = OtpViewModel()
    var token = ""
    var comefrom = ""
    override func viewDidLoad() {
            super.viewDidLoad()
        first.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        second.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        third.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        fourth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        fifth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        sixth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        TextOtpAlignment()
        }
    //MARK: Actions
    
    @IBAction func VerifyBtn(_ sender: Any) {
        if comefrom == "Forgot Password" {
            let vc = storyboard?.instantiateViewController(identifier: "CreateNewPasswordsViewController") as! CreateNewPasswordsViewController
            navigationController?.pushViewController(vc, animated: true)
        }else{
        let firstHalfCode = ((first.text ?? "") + (second.text ?? ""))
        let secondHalfCode = (third.text ?? "") + (fourth.text ?? "")
        let thirdHalfCode =  (fifth.text ?? "") + (sixth.text ?? "")
        let otp =  (firstHalfCode + (secondHalfCode) + (thirdHalfCode))
        
        if otp == ""{
            self.view.makeToast("Please enter OTP" , position : .center)
        }else{
            VerifyOtp(otp: otp)
        }
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField){
            let text = textField.text
            if  text?.count == 1 {
                switch textField{
                case first:
                    second.becomeFirstResponder()
                case second:
                    third.becomeFirstResponder()
                case third:
                    fourth.becomeFirstResponder()
                case fourth:
                    fifth.becomeFirstResponder()
                case fifth:
                    sixth.becomeFirstResponder()
                case sixth:
                    sixth.resignFirstResponder()
                default:
                    break
                }
            }
            if  text?.count == 0 {
                switch textField{
                case first:
                    first.becomeFirstResponder()
                case second:
                    first.becomeFirstResponder()
                case third:
                    second.becomeFirstResponder()
                case fourth:
                    third.becomeFirstResponder()
                case fifth:
                    fourth.becomeFirstResponder()
                case sixth:
                    fifth.becomeFirstResponder()
                default:
                    break
                }
            }
            else{
            }
        }
    
    func TextOtpAlignment() {
        first.textAlignment = .center
        second.textAlignment = .center
        third.textAlignment = .center
        fourth.textAlignment = .center
        fifth.textAlignment = .center
        sixth.textAlignment = .center
    }
    
}
//MARK: API CALL
extension OtpVerificationViewController{
    func VerifyOtp(otp : String){
        let firstHalfCode = ((first.text ?? "") + (second.text ?? ""))
        let secondHalfCode = (third.text ?? "") + (fourth.text ?? "")
        let thirdHalfCode =  (fifth.text ?? "") + (sixth.text ?? "")
        Indicator.shared.showProgressView(self.view)
        viewModel.hitUserLogin(OTP: otp, tokenVal: self.token){ (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                if message ==  "Wrong Otp"{
                    
                    self.view.makeToast(message  , position : .center)
                }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.userType = "Customer"
                self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }else{
                self.view.makeToast(message  , position : .center)
            }
        }
    }
}
