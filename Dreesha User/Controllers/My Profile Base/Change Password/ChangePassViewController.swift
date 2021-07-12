//
//  ChangePassViewController.swift
//  Dreesha User
//
//  Created by Promatics on 11/03/21.
//

import UIKit

class ChangePassViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var passEye1: UIButton!
    @IBOutlet weak var OldPassTXTfld: SkyFloatingLabelTextField!
    @IBOutlet weak var NewPassTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var CnfrmPassTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var passEye2: UIButton!
    
    @IBOutlet weak var PassEye3: UIButton!
    
    //MARK: VARIABLES
    var iconClick = true
    var viewModel=ChangePassViewModel()
    
    
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "My Profile")
//        SetAutoPassData()
    }
    
    func SetAutoPassData(){
        OldPassTXTfld.text = "Bond@007"
        NewPassTxtFld.text = "Bond@007"
        CnfrmPassTxtFld.text = "Bond@007"
        
    }
    
    
    //MARK: Actions
    @IBAction func PassEyeAct1(_ sender: Any) {
        if(iconClick == true) {
           OldPassTXTfld.isSecureTextEntry = false
            passEye1.setImage(UIImage(named: "Pass On") ,for: .normal)
        } else {
            OldPassTXTfld.isSecureTextEntry = true
            passEye1.setImage(UIImage(named: "Pass Off"), for: .normal)
        }
        iconClick = !iconClick
    }
    
    @IBAction func PassEyeAct2(_ sender: Any) {
        if(iconClick == true) {
           NewPassTxtFld.isSecureTextEntry = false
            passEye2.setImage(UIImage(named: "Pass On") ,for: .normal)
        } else {
            NewPassTxtFld.isSecureTextEntry = true
            passEye2.setImage(UIImage(named: "Pass Off"), for: .normal)
        }
        iconClick = !iconClick
    }
    
    @IBAction func PassEyeAct3(_ sender: Any) {
        if(iconClick == true) {
           CnfrmPassTxtFld.isSecureTextEntry = false
            PassEye3.setImage(UIImage(named: "Pass On") ,for: .normal)
        } else {
            CnfrmPassTxtFld.isSecureTextEntry = true
            PassEye3.setImage(UIImage(named: "Pass Off"), for: .normal)
        }
        iconClick = !iconClick
    }
    
    
    @IBAction func submitPass(_ sender: SetButton) {
        if (OldPassTXTfld.text?.replacingOccurrences(of: " ", with: "") == ""){
            self.view.makeToast("Please Enter Old Password" , position : .center)
        }else if (NewPassTxtFld.text?.replacingOccurrences(of: " ", with: "") == ""){
            self.view.makeToast("Please Enter New Password", position : .center)
        }else if (NewPassTxtFld.text?.isValidPassword() == false){
            self.view.makeToast("Please Enter Valid Password", position : .center)
        }else if (self.NewPassTxtFld.text == self.OldPassTXTfld.text) {
            self.view.makeToast("Can't Use Old Password", position : .center)
        }else if(CnfrmPassTxtFld.text?.replacingOccurrences(of: " ", with: "") == ""){
            self.view.makeToast("Please Re Enter New Password", position : .center)
        }else if (self.CnfrmPassTxtFld.text != self.NewPassTxtFld.text) {
            self.view.makeToast("Password confirmation does not match", position : .center)
        }else{
            hitAPI()
        }
     
    }
    
}


//MARK:- API CAll
extension ChangePassViewController{
    func hitAPI(){
        viewModel.apiChangePassword(oldPass: OldPassTXTfld.text ?? "", NewPass: NewPassTxtFld.text ?? "") { (isSuccess, message) in
            if isSuccess{
                self.view.makeToast(message, position : .center )
                self.navigationController?.popViewController(animated: true)
            }else{
                self.view.makeToast(message, position: .center)
            }
        }
    }
}
