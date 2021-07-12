//
//  ProfSideBarViewController.swift
//  Dreeshah
//
//  Created by promatics on 12/03/21.
//

import UIKit

class ProfSideBarViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var sideBarOptions: UITableView!
    
    //MARK:- Variable
    var optionsTitle = ["Dashboard" , "My Profile" , "Branches" , "Projects" , "My Membership" , "My Payment Methods" , "Quotation Requests" , "Quotation Management" , "Service Management" , "Product Management" , "Order Management" , "Refund Management" , "Book Appointment" , "Staff & Staff Privilleges" , "Discount" , "Gift Card" , "Logout"]
    var iconImages = [ #imageLiteral(resourceName: "house") , #imageLiteral(resourceName: "myprofile") , #imageLiteral(resourceName: "branches") , #imageLiteral(resourceName: "my-quotation-mgmt") , #imageLiteral(resourceName: "membership 1") , #imageLiteral(resourceName: "my-payments") , #imageLiteral(resourceName: "my quotation") , #imageLiteral(resourceName: "my-quotation-mgmt") , #imageLiteral(resourceName: "cogwheel 1") , #imageLiteral(resourceName: "productManagement") , #imageLiteral(resourceName: "my-orders") , #imageLiteral(resourceName: "cogwheel 1") , #imageLiteral(resourceName: "my-quotation-mgmt-1") , #imageLiteral(resourceName: "diamond 3") , #imageLiteral(resourceName: "price-tag 1") , #imageLiteral(resourceName: "gift-card 1") , #imageLiteral(resourceName: "logout 1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackWithTitle(titleVal: "Professional")
        sideBarOptions.delegate = self
        sideBarOptions.dataSource = self
        sideBarOptions.reloadData()
    }
}

//MARK:- UITableView Delegates
extension ProfSideBarViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfSidebarOptionsTableViewCell", for: indexPath) as! ProfSidebarOptionsTableViewCell
        cell.optionName.text = optionsTitle[indexPath.row]
        cell.iconImage.image = iconImages[indexPath.row]
        return cell
    }
    
    
}


