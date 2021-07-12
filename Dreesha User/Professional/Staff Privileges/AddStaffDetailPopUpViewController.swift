//
//  AddStaffDetailPopUpViewController.swift
//  Dreesha User
//
//  Created by Apple on 31/03/21.
//

import UIKit
import CountryPickerView

class branchListTableCell : UITableViewCell{
    
    @IBOutlet weak var branchName: UILabel!
    
}

class AddStaffDetailPopUpViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var nameTxtfld: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTxtfld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var phoneCodeView: CountryPickerView!
    @IBOutlet weak var phoneTxtfld: SkyFloatingLabelTextField!
    @IBOutlet weak var branchNameTxtfld: SkyFloatingLabelTextField!
    @IBOutlet weak var branchBtn: UIButton!
    @IBOutlet weak var branchTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var branchTable: UITableView!
    @IBOutlet weak var topLabl: UILabel!
    
    @IBOutlet weak var designationTxtFld: SkyFloatingLabelTextField!
    
    @IBOutlet weak var designationTable: UITableView!
    
    @IBOutlet weak var designationHeight: NSLayoutConstraint!
    
    var branchVM = AddedBranchesViewModel()
    var viewModel = AddStaffDetailsViewModel()
    var data : StaffListModelElement?
    var branchId = ""
    var designationID = ""
    var isEdit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        branchTable.delegate = self
        branchTable.dataSource = self
        branchTable.isHidden = true
        designationTxtFld.inputView = UIView()
        branchNameTxtfld.inputView = UIView()
        branchTableHeight.constant = 0
        designationTable.delegate = self
        designationTable.dataSource = self
        designationTable.isHidden = true
        designationHeight.constant = 0
        getDesinationList()
        getBranchList()
        if isEdit{
            setData()
            topLabl.text = "Edit Staff Details"
        }else{
            topLabl.text = "Add Staff Details"
        }
    }
    
    func setData(){
        nameTxtfld.text = data?.fullName ?? ""
        emailTxtfld.text = data?.email ?? ""
        phoneTxtfld.text = data?.phoneNumber ?? ""
        branchNameTxtfld.text = data?.branchID?.branchNameEn ?? ""
        self.branchId = data?.branchID?.id ?? ""
        self.designationID = data?.designation?.id ?? ""
        designationTxtFld.text = data?.designation?.name ?? ""
        phoneCodeView.setCountryByCode((data?.countryCode)!)
    }
    
    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapBranchBtn(_ sender: Any) {
        if branchTable.isHidden{
            branchTable.isHidden = false
            branchTableHeight.constant = 100
        }else{
            branchTable.isHidden = true
            branchTableHeight.constant = 0
        }
    }
    
    
    @IBAction func tapDesignationBtn(_ sender: Any) {
        if designationTable.isHidden{
            designationTable.isHidden = false
            designationHeight.constant = 100
        }else{
            designationTable.isHidden = true
            designationHeight.constant = 0
        }
    }
    
    @IBAction func tapAddStaff(_ sender: Any) {
        if nameTxtfld.text ?? "" == ""{
            self.parent?.view.makeToast("Please Enter Name")
        }else if designationTxtFld.text ?? "" == ""{
            self.parent?.view.makeToast("Please Choose Designation")
        }else if emailTxtfld.text ?? "" == ""{
            self.parent?.view.makeToast("Please Enter Email")
        }else if phoneTxtfld.text ?? "" == ""{
            self.parent?.view.makeToast("Please Enter Phone Number")
        }else if branchNameTxtfld.text ?? "" == ""{
            self.parent?.view.makeToast("Please Select Branch")
        }else{
            if(!isEdit){
            hitAddStaff()
            }else{
                hitEditStaff()
            }
        }
    }
}

//MARK:- Tableview Delegates
extension AddStaffDetailPopUpViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == designationTable{
            return viewModel.designationModel.count
        }else{
            return branchVM.model.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "branchListTableCell", for: indexPath) as! branchListTableCell
        if tableView == designationTable{
            cell.branchName.text = viewModel.designationModel[indexPath.row].name
        }else{
            cell.branchName.text = branchVM.model[indexPath.row].branchNameEn ?? ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == designationTable{
            designationTxtFld.text = viewModel.designationModel[indexPath.row].name
            designationID = viewModel.designationModel[indexPath.row].id
            designationTable.isHidden = true
            designationHeight.constant = 0
        }else{
            branchNameTxtfld.text = branchVM.model[indexPath.row].branchNameEn ?? ""
            branchId = branchVM.model[indexPath.row].id ?? ""
            branchTable.isHidden = true
            branchTableHeight.constant = 0
        }
        
      
    }
    
    
}

//MARK:- API CALL

extension AddStaffDetailPopUpViewController{
    func getBranchList(){
        branchVM.apiGetBranchList { (isSuccess, message) in
            if isSuccess{
                self.branchTable.reloadData()
            }else{
                
            }
        }
    }
    
    func getDesinationList(){
        viewModel.apiGetDesignationList { (isSuccess, message) in
            if isSuccess{
                self.designationTable.reloadData()
            }else{
                
            }
        }
    }
    
    
    func hitAddStaff(){
        viewModel.apiAddStaff(BranchId: self.branchId, Name: nameTxtfld.text?.replacingOccurrences(of: " ", with: "") ?? "", Email: emailTxtfld.text?.replacingOccurrences(of: " ", with: "") ?? "", CountryCode: phoneCodeView.selectedCountry.phoneCode, PhoneNumber: phoneTxtfld.text?.replacingOccurrences(of: " ", with: "") ?? "", designation: self.designationID) { (isSuccess, message) in
            if isSuccess{
                self.dismiss(animated: true, completion: nil)
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    func hitEditStaff(){
        print("Code: \(phoneCodeView.selectedCountry.code)")
        print("PhoneCode: \(phoneCodeView.selectedCountry.phoneCode)")
        viewModel.apiEditStaff(BranchId: self.branchId, Name: nameTxtfld.text?.replacingOccurrences(of: " ", with: "") ?? "", Email: emailTxtfld.text?.replacingOccurrences(of: " ", with: "") ?? "", CountryCode: phoneCodeView.selectedCountry.phoneCode, PhoneNumber: phoneTxtfld.text?.replacingOccurrences(of: " ", with: "") ?? "", StaffId: (data?.id)!, designation: self.designationID) { (isSuccess, message) in
            if isSuccess{
                self.dismiss(animated: true, completion: nil)
            }else{
                self.view.makeToast(message)
            }
        }
    }
}
