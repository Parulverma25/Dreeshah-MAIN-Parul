//
//  ModifyQuotationViewController.swift
//  Dreesha User
//
//  Created by Apple on 17/03/21.
//

import UIKit

class ModifyQuotationViewController: UIViewController {
   
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var warrantyval: UILabel!
    @IBOutlet weak var offerValidityVal: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    @IBOutlet weak var vatValue: UILabel!
    @IBOutlet weak var quantityValue: UILabel!
    
    @IBOutlet weak var QunatityDetailTab: UITableView!
    @IBOutlet weak var scopeOfWorkValue: UILabel!
    @IBOutlet weak var exclusuionValue: UILabel!
    @IBOutlet weak var DreeshshConditionsVal: UILabel!
    @IBOutlet weak var SellerConditionsValue: UILabel!
    @IBOutlet weak var paymentTermValue: UILabel!
    
    @IBOutlet weak var modifytitleName: UITextView!
    @IBOutlet weak var modifywarrantyval: UILabel!
    @IBOutlet weak var modifyofferValidityVal: UITextView!
    @IBOutlet weak var modifypriceValue: UITextView!
    @IBOutlet weak var modifyvatValue: UITextView!
    @IBOutlet weak var modifyquantityValue: UITextView!
        @IBOutlet weak var modifyscopeOfWorkValue: UITextView!
    @IBOutlet weak var modifyexclusuionValue: UITextView!
    @IBOutlet weak var modifyDreeshshConditionsVal: UITextView!
    @IBOutlet weak var modifySellerConditionsValue: UITextView!
    @IBOutlet weak var modifypaymentTermValue: UITextView!
    @IBOutlet weak var modifyworkScheduleValue: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "View Quotation")
    }

   

}
//extension ModifyQuotationViewController: UITableViewDelegate,UITableViewDataSource{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//
//            return 3
//
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//
//        }
//
//}

