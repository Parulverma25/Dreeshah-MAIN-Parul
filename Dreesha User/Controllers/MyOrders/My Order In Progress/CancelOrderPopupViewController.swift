//
//  CancelOrderPopupViewController.swift
//  Dreesha User
//
//  Created by Promatics on 12/06/21.
//

import UIKit

class CancelOrderPopupViewController: UIViewController {
    
    @IBOutlet weak var reasonTextField: SkyFloatingLabelTextField!
    
    //MARK:- Variable
    typealias sendBack = (_ confirm :Bool , _ reason : String) ->()
    var completionBlock : sendBack?

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    //MARK:- IBACtions
    
    @IBAction func tapNo(_ sender: Any) {
        guard let cb = completionBlock else {return}
        cb(false, "")
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func tapYes(_ sender: Any) {
        
        if reasonTextField.text ?? "" == ""{
            self.parent?.view.makeToast("Please Enter Reason For Cancellation")
        }else{
            
            
            guard let cb = completionBlock else {return}
            cb(true, reasonTextField.text ?? "")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
