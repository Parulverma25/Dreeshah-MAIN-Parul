//
//  AddPaymentMethodViewController.swift
//  Dreeshah
//
//  Created by promatics on 19/02/21.
//

import UIKit

class AddPaymentMethodViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var paymentOptionsTable: UITableView!
    
    //MARK:- Variables
    var imageArr = [#imageLiteral(resourceName: "sbi") , #imageLiteral(resourceName: "visa") , #imageLiteral(resourceName: "paypal")]
    var getIndex: Int!
    var cardNo = ["**** **** **** 3456" , "**** **** **** 3456" , "peter_spark@paypal.com"]
    var expire = ["Expires 9/24" , "Expires 9/24" , " "]

    override func viewDidLoad() {
        super.viewDidLoad()

        paymentOptionsTable.delegate = self
        paymentOptionsTable.dataSource = self
        paymentOptionsTable.reloadData()
        navigationItem.title = "Payment Method"
        setBackBtn()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Payment Method")
    }
    
    @IBAction func addPaymentBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "AddDebitCardViewController") as! AddDebitCardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK:- TableView Delegates
extension AddPaymentMethodViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentOptionsTableViewCell", for: indexPath) as! PaymentOptionsTableViewCell
        cell.paymentImage.image = imageArr[indexPath.row]
        cell.cardNo.text = cardNo[indexPath.row]
        cell.expiry.text = expire[indexPath.row]
        if indexPath.row == getIndex {
            cell.outerView.layer.borderWidth = 2.5
            cell.outerView.layer.borderColor = #colorLiteral(red: 0.01287793275, green: 0.3780495524, blue: 0.6077892184, alpha: 1)
        } else {
            cell.outerView.layer.borderWidth = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getIndex = indexPath.row
        paymentOptionsTable.reloadData()
    }
}
