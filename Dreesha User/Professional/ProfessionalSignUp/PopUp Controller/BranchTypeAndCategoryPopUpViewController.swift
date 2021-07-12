//
//  BranchTypeAndCategoryPopUpViewController.swift
//  Dreesha User
//
//  Created by Apple on 07/04/21.
//

import UIKit


class BranchTypeAndCategoryPopUpCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}


protocol TypeAndCategoryList {
    func listData(name: String, isType: Bool, id: String?)
    func listData(name: String, ListType: String, id: String?)
}


class BranchTypeAndCategoryPopUpViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headingLabel: UILabel!
    
    var isType: Bool! = false
    var ListType = ""
    var name: [String] = []
    var id: [String] = []
    var delegate: TypeAndCategoryList?

    var nameValue: String!
    var idValue: String!
    
    var isSelect: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLabel.text = isType ? "Branch Type" : "Branch Category"
        if(ListType != ""){
            headingLabel.text = ListType
        }
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        for i in 0..<name.count {
            if isSelect == i {
                nameValue = name[i]
                idValue = id[i]
            }
        }
        if(ListType == ""){
            if let s = nameValue {
                delegate?.listData(name: s, isType: isType, id: idValue)
            }
        }else{
            if let s = nameValue {
                delegate?.listData(name: s, ListType: ListType, id: idValue)
            }
        }
        

    }

}




//MARK:- Table View Delegates

extension BranchTypeAndCategoryPopUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BranchTypeAndCategoryPopUpCell
        cell.nameLabel.text = name[indexPath.row]
        cell.accessoryType = (self.isSelect == indexPath.row) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isSelect = indexPath.row
        tableView.reloadData()
    }
}
