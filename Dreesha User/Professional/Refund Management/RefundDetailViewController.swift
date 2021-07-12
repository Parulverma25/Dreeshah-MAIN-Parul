//
//  RefundDetailViewController.swift
//  Dreesha User
//
//  Created by Apple on 30/03/21.
//

import UIKit
import SBCardPopup


class RefundDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


class RefundDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var titleArray = ["Order No", "Username", "Seller Name", "Store Name", "Payment Mode", "Quantity Delivered"]
    var valueArray = ["464649", "Charles", "Grace Lawerence", "The Modern Store", "Card", "200pcs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Refund Management")
    }
    
    @IBAction func makeRefundBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectReasonPopUpViewController") as! SelectReasonPopUpViewController
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    
}


//Mark Table View Delegate Functions
extension RefundDetailViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RefundDetailTableViewCell
        cell.nameLabel.text = titleArray[indexPath.row]
        cell.valueLabel.text = valueArray[indexPath.row]
        return cell
    }

}
