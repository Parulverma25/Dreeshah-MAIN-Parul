//
//  OrderListDetailViewController.swift
//  Dreesha User
//
//  Created by Promatics on 28/06/21.
//

import UIKit

class OrderListDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
//MARK: Outlets
    @IBOutlet weak var orderlistTableView: UITableView!
    
    //MARK: Variables
    var TitleArr = [String]()
    var UrlArr = [String]()
    var AEDArr = [Int]()
    var QuantityArr = [String]()
    var ID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderlistTableView.dataSource = self
        orderlistTableView.delegate = self
        orderlistTableView.reloadData()
    }

    @IBAction func viewDetails(_ sender: UIButton) {
        let vc = (storyboard?.instantiateViewController(identifier: "OrderManageentDetailsViewController")) as! OrderManageentDetailsViewController
        vc.OrderIDStr = ID

        navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: TableViewDelegates Functions
extension OrderListDetailViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! OrderListDetailTableViewCell
        cell.TitleLabel.text = TitleArr[indexPath.row]
        cell.AEDLabel.text = "AED \(AEDArr[indexPath.row])"
        cell.QuantityLAbel.text = "Quantity: \(QuantityArr[indexPath.row])"
        
        cell.OrderImageView.layer.cornerRadius = 10
        cell.OrderImageView.clipsToBounds = true
        let Url = URLS.productImgUrl(UrlArr[indexPath.row]).getDescription()
        cell.OrderImageView.sd_setImage(with: URL(string: Url), placeholderImage : #imageLiteral(resourceName: "Placed"))
        
        cell.ViewdetailsBtn.tag = indexPath.row
        cell.ViewdetailsBtn.addTarget(self, action: #selector(viewDetails(_:)), for: .touchUpInside)
        return cell
    }
    
}
