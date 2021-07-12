//
//  ForgotPasswordViewController.swift
//  Dreesha User
//
//  Created by Promatics on 19/04/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//MARK: Actions
    
    @IBAction func VerifyBtnAct(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "OtpVerificationViewController") as! OtpVerificationViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.comefrom = "Forgot Password"
    }
    
}
