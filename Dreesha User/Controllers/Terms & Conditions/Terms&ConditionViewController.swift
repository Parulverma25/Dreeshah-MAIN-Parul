//
//  Terms&ConditionViewController.swift
//  Dreesha User
//
//  Created by Promatics on 10/04/21.
//

import UIKit

class Terms_ConditionViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var termsVal: UILabel!
    
    //MARK:  Variable
 var viewModel = TermsViewModel()
    
    //MARK: ViewDid Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Terms and Conditions")
        terms_andConditions()
    }


}
//MARK:- API CALL
extension Terms_ConditionViewController {
func terms_andConditions(){
    viewModel.apiTerms_Conditions(Status: "terms_conditions"){ (isSuccess, message) in
        if isSuccess{
            self.termsVal.attributedText = (self.viewModel.getTermsValData()?.data?.dataDescription ?? "").html2AttributedString
            }else{
            self.view.makeToast(message , position : .center)
        }
    }
}
}
