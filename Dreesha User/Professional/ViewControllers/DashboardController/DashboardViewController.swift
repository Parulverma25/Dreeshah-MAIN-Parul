//
//  DashboardViewController.swift
//  Dreeshah
//
//  Created by promatics on 23/02/21.
//

import UIKit

class DashboardViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var dashboardListTable: UITableView!
    @IBOutlet weak var dashBoardTableHeight: NSLayoutConstraint!
    @IBOutlet weak var photographyDealsTable: UITableView!
    @IBOutlet weak var ProfessioanlTable: UITableView!
    @IBOutlet weak var professionalTableHeight: NSLayoutConstraint!
    @IBOutlet weak var photographyTableHeight: NSLayoutConstraint!
    
    
    //MARK:- Variables
    var titleArray = ["Customers" , "Services" , "Products" , "Orders" , "Sales" , "Store Sessions" , "Quotation Request" , "Latest Orders"  , "Rate"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dashboardListTable.delegate = self
        dashboardListTable.dataSource = self
        dashboardListTable.reloadData()
        updateTableHeight(tableName: dashboardListTable, tableHeight: dashBoardTableHeight)
        
        ProfessioanlTable.delegate = self
        ProfessioanlTable.dataSource = self
        ProfessioanlTable.reloadData()
        updateTableHeight(tableName: ProfessioanlTable, tableHeight: professionalTableHeight)
        
        photographyDealsTable.delegate = self
        photographyDealsTable.dataSource = self
        photographyDealsTable.reloadData()
        updateTableHeight(tableName: photographyDealsTable, tableHeight: photographyTableHeight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "Dashboard")
    }
    
//    func updateTableHeight(tableName : UITableView , tableHeight : NSLayoutConstraint){
//        var frame = tableName.frame
//        frame.size.height = tableName.contentSize.height
//        tableName.frame = frame
//        tableName.reloadData()
//        tableName.layoutIfNeeded()
//        tableHeight.constant = CGFloat(tableName.contentSize.height + 10)
//    }

}

//MARK:- TableView delegates
extension DashboardViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == ProfessioanlTable{
            return 3
        }else if tableView == photographyDealsTable{
            return 3
        }else{
            return titleArray.count
        }
        
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == ProfessioanlTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "professionalListTableViewCell", for: indexPath) as! professionalListTableViewCell
         
            return cell
        }else if tableView == photographyDealsTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "photographyListTableViewCell", for: indexPath) as! photographyListTableViewCell
         
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardListTableViewCell", for: indexPath) as! dashboardListTableViewCell
            cell.firstViewTitle.text = titleArray[indexPath.row]
            return cell
        }
        
        
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == dashboardListTable {
            
        }
    }
    
}
