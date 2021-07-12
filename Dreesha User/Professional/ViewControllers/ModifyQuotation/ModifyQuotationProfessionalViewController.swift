//
//  ModifyQuotationProfessionalViewController.swift
//  Dreeshah
//
//  Created by promatics on 20/02/21.
//

import UIKit

class ModifyQuotationProfessionalViewController: UIViewController {
    
    //MARK:- OUTLETs
    
    @IBOutlet weak var termsListTable: UITableView!
    @IBOutlet weak var termsListTableHeight: NSLayoutConstraint!
    @IBOutlet weak var issueQuotationBtn: SetButton!
    
    //MARK:- Variables
    var titleArray = ["SCOPE OF WORK" , "EXCLUSION" , "DREESHAH TERMS AND CONDITIONS" , "TERMS AND CONDITIONS OF PROFESSIONAL" , "PAYMENT TERMS" , "WORK SCHEDULE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termsListTable.delegate = self
        termsListTable.dataSource = self
        termsListTable.reloadData()
        updateTableHeight(tableName: termsListTable, tableHeight: termsListTableHeight)
        issueQuotationBtn.layer.borderWidth = 1
        issueQuotationBtn.layer.borderColor = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "VIew Quotation")
    }
    
    //MARK:- Custom Functions
    
    func navigation(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.title = "Modify Quotation"
        setBackBtn()
        
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

//MARK:- TableView Delegate
extension ModifyQuotationProfessionalViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "termsListTableViewCell", for: indexPath) as! termsListTableViewCell
        cell.titleLbl.text = titleArray[indexPath.row]
        return cell
    }
    
    
}
