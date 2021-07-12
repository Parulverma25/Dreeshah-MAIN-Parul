//
//  QuotationDetailProfesstionalViewController.swift
//  Dreeshah
//
//  Created by promatics on 20/02/21.
//

import UIKit

class QuotationDetailProfesstionalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func viewQuatiotion(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ModifyQuotationProfessionalViewController") as! ModifyQuotationProfessionalViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func issueQuatation(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ModifyQuotationProfessionalViewController") as! ModifyQuotationProfessionalViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
