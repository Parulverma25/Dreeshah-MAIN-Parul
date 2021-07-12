//
//  OrderTrackingViewController.swift
//  Dreesha User
//
//  Created by Promatics on 12/03/21.
//

import UIKit

class OrderTrackingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  

    //MARK: Outlets
    @IBOutlet weak var ConfirmingOrderDate: UILabel!
    @IBOutlet weak var OrderPlacedDate: UILabel!
    @IBOutlet weak var DispatchedDate: UILabel!
    @IBOutlet weak var ShipppedDate: UILabel!
    
    @IBOutlet weak var OrderIDVal: UILabel!
    @IBOutlet weak var OrdersTableView: UITableView!
    @IBOutlet weak var OrderTableHeight: NSLayoutConstraint!
    
    //MARK: Variables
  
    var ProductTitleArr = [String]()
    var ProductPriceArr = [Int]()
    var ProductQuantityArr = [String]()
    var UrlArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OrdersTableView.delegate = self
        OrdersTableView.dataSource = self
        OrdersTableView.reloadData()
        updateTableHeight(tableName: OrdersTableView, tableHeight: OrderTableHeight)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Orders Detail")
       
    }
    
    //MARK: Actions
    
    @IBAction func InquiryBtn(_ sender: UIButton) {
    }
    
    @IBAction func ChatBtn(_ sender: UIButton) {
    }
    
    
    
    
    
    
}

extension OrderTrackingViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrdersTableView.dequeueReusableCell(withIdentifier: "cell") as! OrderTrackingTableViewCell
        cell.ProductTitle.text = ProductTitleArr[indexPath.row]
        cell.AedVal.text = "AED \(ProductPriceArr[indexPath.row])"
        cell.QuantityLabel.text = "Quantity:\(ProductQuantityArr[indexPath.row]) pcs"
        let url = URLS.productImgUrl(UrlArr[indexPath.row]).getDescription()
        cell.OrderImg1.sd_setImage(with: URL(string: url) , placeholderImage : #imageLiteral(resourceName: "signup_general"))
        return cell
    }
    
    
    
}

