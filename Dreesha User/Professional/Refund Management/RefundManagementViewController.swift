//
//  RefundManagementViewController.swift
//  Dreesha User
//
//  Created by Apple on 30/03/21.
//

import UIKit
import SBCardPopup


class RefundManagementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderCancelLabel: SetLabel!
    
    var onViewMore: (() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
   
    
    
    @IBAction func viewMoreBtn(_ sender: Any) {
        onViewMore()
    }
}


class RefundManagementViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Refund Management")
    }
    
    @IBAction func filterBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterPopUpViewController") as! FilterPopUpViewController
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    
}


//Mark Table View Delegate Functions
extension RefundManagementViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RefundManagementTableViewCell
        cell.onViewMore = {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RefundDetailViewController") as! RefundDetailViewController
            self.navigationController?.pushViewController(vc, animated: true)
            print("hello")
        }
        return cell
    }

}
