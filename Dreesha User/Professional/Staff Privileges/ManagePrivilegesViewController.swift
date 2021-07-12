//
//  ManagePrivilegesViewController.swift
//  Dreesha User
//
//  Created by Apple on 31/03/21.
//

import UIKit

class ManagePrivilegesViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var previllageListTable: UITableView!
    @IBOutlet weak var previllageTableHeight: NSLayoutConstraint!
   
    @IBOutlet weak var selectedTableView: UITableView!
    @IBOutlet weak var selectedTableHeight: NSLayoutConstraint!
    
    
    //MARK:- Variables
    var staffId = ""
    var sendPrivillege = ["privilege_id" : String() , "read_permission" : Bool() , "write_permission" : Bool()] as [String : Any]
    var sendParam = [[String : Any]]()
    var viewModel = StaffListViewModel()
    var selectedCell = [String]()
    var selectedPrevlgName = [String]()
    var alreadyPreviledge = [Privilege]()
    var allPermissions = [SelectedPermision]()
    override func viewDidLoad() {
        super.viewDidLoad()
        previllageListTable.delegate = self
        previllageListTable.dataSource = self
        selectedTableView.delegate = self
        selectedTableView.dataSource = self
        getPreviledgeList()
    }

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Privileges")
    }
    
    @objc func selectPrevilage(_ sender : UIButton){
        selectedPrevlgName.removeAll()
        
        if sender.currentImage == UIImage(named: "checkbox Off"){
            selectedCell.insert(viewModel.getPreviledgeList()?[sender.tag].id ?? "", at: sender.tag)
            selectedCell.remove(at: sender.tag + 1)
            var permission = SelectedPermision()
            permission.name = viewModel.getPreviledgeList()?[sender.tag].name ?? ""
            permission.privilegeId = viewModel.getPreviledgeList()?[sender.tag].id ?? ""
            allPermissions.append(permission)
            print(allPermissions)
        }else{
            selectedCell.insert("", at: sender.tag)
            selectedCell.remove(at: sender.tag + 1)
            allPermissions =  allPermissions.filter(){$0.privilegeId != (viewModel.getPreviledgeList()?[sender.tag].id ?? "")}
            
          
        }
        
        print(selectedCell)
        selectedTableView.reloadData()
        updateTableHeight(tableName: self.selectedTableView, tableHeight: self.selectedTableHeight)
        previllageListTable.reloadData()
        
       
    }
    
    @objc func setPermisions(_ sender : UIButton){
        if (allPermissions[sender.tag].readPermission ?? false) && (allPermissions[sender.tag].writePermission ?? false) {
            allPermissions[sender.tag].readPermission = true
            allPermissions[sender.tag].writePermission = false
        }else if allPermissions[sender.tag].readPermission ?? false{
            allPermissions[sender.tag].readPermission = true
            allPermissions[sender.tag].writePermission = true
        }else{
            if sender.accessibilityHint == "read"{
                allPermissions[sender.tag].readPermission = true
                allPermissions[sender.tag].writePermission = false
            }else{
                allPermissions[sender.tag].readPermission = false
                allPermissions[sender.tag].writePermission = true
            }
            
        }
        
        selectedTableView.reloadData()
    }
    
    
    //MARK:- IBActions
    
    @IBAction func tapSubmitBtn(_ sender: Any) {
        hitAddStaffPreviledge()
    }
    
    
}

//MARK:- TableView Delegates
extension ManagePrivilegesViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == selectedTableView{
            
            return allPermissions.count
        }else{
            
            return viewModel.getPreviledgeList()?.count ?? 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == selectedTableView{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectedPrevillageTableViewCell", for:   indexPath) as! selectedPrevillageTableViewCell
            cell.selectedName.text = allPermissions[indexPath.row].name ?? ""
            cell.readPermission.tag = indexPath.row
            cell.writePermission.tag = indexPath.row
            if (allPermissions[indexPath.row].readPermission ?? false) && (allPermissions[indexPath.row].writePermission ?? false){
                cell.writePermission.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
                cell.readPermission.setImage(UIImage(named: "checkbox Off"), for: .normal)
            }else if allPermissions[indexPath.row].readPermission ?? false{
                cell.readPermission.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
                cell.writePermission.setImage(UIImage(named: "checkbox Off"), for: .normal)
            }else{
                cell.writePermission.setImage(UIImage(named: "checkbox Off"), for: .normal)
                cell.readPermission.setImage(UIImage(named: "checkbox Off"), for: .normal)
            }
            cell.readPermission.addTarget(self, action: #selector(setPermisions(_:)), for: .touchUpInside)
            cell.readPermission.accessibilityHint = "read"
            cell.writePermission.accessibilityHint = "write"
            cell.writePermission.addTarget(self, action: #selector(setPermisions(_:)), for: .touchUpInside)
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreviledgeListTableViewCell", for:   indexPath) as! PreviledgeListTableViewCell
            cell.previledgeName.text = viewModel.getPreviledgeList()?[indexPath.row].name ?? ""
            
            if selectedCell.contains(viewModel.getPreviledgeList()?[indexPath.row].id ?? ""){
                cell.selectionBtn.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
               
                selectedPrevlgName.append(viewModel.getPreviledgeList()?[indexPath.row].name ?? "")
                
                print(allPermissions)
            }else{
                cell.selectionBtn.setImage(UIImage(named: "checkbox Off"), for: .normal)
                
            }
            
            cell.selectionBtn.tag = indexPath.row
            cell.selectionBtn.addTarget(self, action: #selector(selectPrevilage(_:)), for: .touchUpInside)
           
            return cell
        }
    
    }
    
   
}

//MARK:- API CALL

extension ManagePrivilegesViewController{
    func getPreviledgeList(){
        viewModel.apiPrevilegeList { (isSuccess, message) in
            if isSuccess{
                self.selectedCell = Array(repeating: "", count: self.viewModel.getPreviledgeList()?.count ?? 0)
               
                print(self.selectedCell)
                print(self.alreadyPreviledge)
                for allPrevilidge in (self.viewModel.getPreviledgeList() ?? []).enumerated(){
                    for previlege in self.alreadyPreviledge.enumerated(){
                        if (allPrevilidge.element.id ?? "") == (previlege.element.privilegeID?.id ?? ""){
                            print("Id matched \(previlege.element) at index \(previlege.offset)")
                            self.selectedCell.insert(previlege.element.privilegeID?.id ?? "", at: allPrevilidge.offset)
                            self.selectedCell.remove(at: allPrevilidge.offset + 1)
                            var permission = SelectedPermision()
                            permission.name = previlege.element.privilegeID?.name ?? ""
                            permission.privilegeId = previlege.element.privilegeID?.id ?? ""
                            permission.readPermission = previlege.element.readPermission ?? false
                            permission.writePermission = previlege.element.writePermission ?? false
                            self.allPermissions.append(permission)
                        }
                    }
                }
                self.selectedTableView.reloadData()
                self.updateTableHeight(tableName: self.selectedTableView, tableHeight: self.selectedTableHeight)
                self.previllageListTable.reloadData()
                self.updateTableHeight(tableName: self.previllageListTable, tableHeight: self.previllageTableHeight)
            }else{
                
            }
        }
    }
    
    func hitAddStaffPreviledge(){
        
        for i in 0..<(allPermissions.count){
            sendPrivillege["privilege_id"] = allPermissions[i].privilegeId ?? ""
            sendPrivillege["read_permission"] = allPermissions[i].readPermission ?? false
            sendPrivillege["write_permission"] = allPermissions[i].writePermission ?? false
            
            sendParam.append(sendPrivillege)
        }
        
        viewModel.apiAddPreledge(staffId: self.staffId, privilege: sendParam) { (isSuccess, message) in
            if isSuccess{
                self.navigationController?.popViewController(animated: true)
            }else{
                self.view.makeToast(message)
            }
        }
    }
}

//MARK:- Selected Permision Struct

struct SelectedPermision {
    var privilegeId : String?
    var readPermission : Bool?
    var writePermission : Bool?
    var name : String?
    
}
