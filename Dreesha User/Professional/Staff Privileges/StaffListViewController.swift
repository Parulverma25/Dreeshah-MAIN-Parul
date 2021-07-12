//
//  StaffListViewController.swift
//  Dreesha User
//
//  Created by Apple on 31/03/21.
//

import UIKit
import SBCardPopup

class StaffListTableViewCell: UITableViewCell {
    
    //MARK:- Cell Outlets
    @IBOutlet weak var staffNameLbl: UILabel!
    @IBOutlet weak var contactNoLbl: UILabel!
    @IBOutlet weak var branchNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var previllageLbl: UILabel!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var designationVal: UILabel!
    
    
    var onGrant: (() -> Void)!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func grantBtn(_ sender: Any) {
        onGrant()
    }
    
}



class StaffListViewController: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variables
    var viewModel = StaffListViewModel()
    var offset = 0
    var isFetching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        print("View Appeared")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.offset = 0
        print("View Appeared")
        viewModel.model = []
        self.isFetching = false
        self.getStaffList()
        setBackWithTitle(titleVal: "Staff")
    }
    
    //MARK:- Objc Func
    
    @objc func tapEditCell(_ sender : UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddStaffDetailPopUpViewController") as! AddStaffDetailPopUpViewController
        vc.isEdit = true
        vc.data = viewModel.getStaffDetails()?[sender.tag]
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddStaffDetailPopUpViewController") as! AddStaffDetailPopUpViewController
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    

}


//MARK:- TableView Delegates

extension StaffListViewController: UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getStaffDetails()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StaffListTableViewCell
        
        cell.sideView.backgroundColor = .random()
       // print(viewModel.getStaffDetails())
        cell.staffNameLbl.text = viewModel.getStaffDetails()?[indexPath.row].fullName ?? ""
        cell.branchNameLbl.text = viewModel.getStaffDetails()?[indexPath.row].branchID?.branchNameEn ?? ""
        cell.contactNoLbl.text = "\(viewModel.getStaffDetails()?[indexPath.row].countryCode ?? "")-" + (viewModel.getStaffDetails()?[indexPath.row].phoneNumber ?? "")
        
        cell.previllageLbl.text = (viewModel.getStaffDetails()?[indexPath.row].staffPrivilege?.privilege?.map({$0.privilegeID?.name ?? ""}))?.joined(separator: ",")
        cell.emailLbl.text = viewModel.getStaffDetails()?[indexPath.row].email ?? ""
        cell.designationVal.text = viewModel.getStaffDetails()?[indexPath.row].designation?.name ?? ""
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(tapEditCell(_:)), for: .touchUpInside)
        
        cell.onGrant = {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivilegesViewController") as! PrivilegesViewController
//            self.navigationController?.pushViewController(vc, animated: true)
            
        let vc = self.storyboard?.instantiateViewController(identifier: "ManagePrivilegesViewController") as! ManagePrivilegesViewController
        vc.alreadyPreviledge = self.viewModel.getStaffDetails()?[indexPath.row].staffPrivilege?.privilege ?? []
        vc.staffId = self.viewModel.getStaffDetails()?[indexPath.row].staffListModelID ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        print("hello")
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if isFetching{
            self.offset += 10
            self.getStaffList()
        }
    }
    

}


//MARK:- API CALL
extension StaffListViewController{
    func getStaffList(){
        viewModel.apiGetStaffList(limit: "10", offset: String(self.offset)) { (isSuccess, message) in
            if isSuccess{
                self.isFetching = true
                self.tableView.reloadData()
            }else{
                self.isFetching = false
                self.view.makeToast(message)
            }
        }
    }
}


//MARK:- Color Extension
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
