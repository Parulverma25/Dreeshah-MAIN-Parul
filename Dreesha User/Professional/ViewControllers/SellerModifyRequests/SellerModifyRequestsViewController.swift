//
//  SellerModifyRequestsViewController.swift
//  Dreeshah
//
//  Created by promatics on 20/02/21.
//

import UIKit

class SellerModifyRequestsViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var modifyRequestTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyRequestTable.delegate = self
        modifyRequestTable.dataSource = self
        modifyRequestTable.reloadData()
        navigationItem.title = "Seller Modify Requests"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        setBackBtn()
    }

}

//MARK:- TableView Delegates
extension SellerModifyRequestsViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "modifyRequestListTableViewCell", for: indexPath) as! modifyRequestListTableViewCell
        return cell
    }
    
    
}
