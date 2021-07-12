//
//  PaymentMethodViewController.swift
//  Dreesha User
//
//  Created by Apple on 16/03/21.
//

import UIKit

class PaymentMethodViewController: UIViewController {

    //Mark Outlets
    @IBOutlet weak var paymentTable: UITableView!
    
    //Mark Variables
    var titleArr = ["**** **** **** 3456","**** **** **** 4526","peter_stark@papypal.com"]
    var subtitleArr = ["Expires 9/24","Expires 9/24",""]
    
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Payment Method")
    }

    @IBAction func addPaymentMethod(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddCardViewController") as! AddCardViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
//Mark TableView Delegates
extension PaymentMethodViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 40
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        if section == 1 {
            headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
            headerView.backgroundColor = UIColor.white
            let lbl1 = UILabel()
            lbl1.frame = CGRect(x: headerView.frame.origin.x + 15, y: headerView.frame.origin.y + 10, width: headerView.frame.size.width - 30, height: headerView.frame.size.height - 10)
            lbl1.backgroundColor = UIColor.clear
            lbl1.text = "Current Method"
            lbl1.textColor = UIColor.black
//            lbl1.font = lbl1.font.withSize(16)
            let boldfont = UIFont.boldSystemFont(ofSize: 16)
            lbl1.font = boldfont
            headerView.addSubview(lbl1)
        }
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = paymentTable.dequeueReusableCell(withIdentifier: "cell") as! PaymentMethodTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.titleLbl.text = self.titleArr[indexPath.row]
            cell.subtitleLbl.text = self.subtitleArr[indexPath.row]
        case 1:
            cell.titleLbl.text = "Debit Card"
            cell.subtitleLbl.text = "Default Method"
        default:
            print("none")
        }
        return cell
    }

}
