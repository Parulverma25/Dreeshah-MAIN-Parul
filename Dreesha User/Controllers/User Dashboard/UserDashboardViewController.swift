//
//  UserDashboardViewController.swift
//  Dreesha User
//
//  Created by Promatics on 09/03/21.
//

import UIKit
class UserDashboardViewController: UIViewController {
    //Mark Outlets
    @IBOutlet weak var dashTableView: UITableView!
   
    @IBOutlet weak var DashHeight: NSLayoutConstraint!
    //Mark Variables
    var arrprocess = ["Cancelled", "Successfull","Shipped"]
    
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        dashTableView.delegate=self
        dashTableView.dataSource=self
        dashTableView.reloadData()
        updateTableHeight(tableName: dashTableView, tableHeight: DashHeight)
        self.hideKeyboardWhenTappedAround()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "Dashboard")
    }
}
//Mark TableView Delegates
extension UserDashboardViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrprocess.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardCell") as! UserDashboardCell
        cell.procLab.text=arrprocess[indexPath.row]
//
//        cell.cellview.layer.shadowColor = UIColor.gray.cgColor
//        cell.cellview.layer.shadowOpacity = 0.3
//        cell.cellview.layer.shadowOffset = CGSize.zero
//        cell.cellview.layer.shadowRadius = 6
        
        switch arrprocess[indexPath.row] {
        case "Cancelled":
           
            cell.procLab.textColor = #colorLiteral(red: 0.8549019608, green: 0.1607843137, blue: 0.1176470588, alpha: 1)
        case "Successfull":
            cell.procLab.textColor = #colorLiteral(red: 0.3215686275, green: 0.5960784314, blue: 0.1098039216, alpha: 1)
        default:
            cell.procLab.textColor = #colorLiteral(red: 0.6470588235, green: 0.5882352941, blue: 0.08235294118, alpha: 1)
        }
        return cell
    }
}


