//
//  ServiceListPopUpViewController.swift
//  Dreesha User
//
//  Created by Apple on 08/04/21.
//

import UIKit


class ServiceListPopUpCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


protocol ServiceDataValue {
    func getValue(name: [String], id: [String])
}

class ServiceListPopUpViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headingLabel: UILabel!
    
    var nameArray: [String] = []
    var selectedName : [String] = []
    var isSelect: [Bool] = []
    var delegate : ServiceDataValue?
    var idArray : [String] = []
    var selectedId : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        for _ in 0..<nameArray.count {
            isSelect.append(false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for i in 0..<nameArray.count {
            if isSelect[i] {
                selectedName.append(nameArray[i])
                selectedId.append(idArray[i])
            }
        }
        
        if !(selectedName.isEmpty) {
            delegate!.getValue(name: selectedName, id: selectedId)
        }
    }
}



//MARK:- Table View Delegates

extension ServiceListPopUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ServiceListPopUpCell
        cell.nameLabel.text = nameArray[indexPath.row]
        cell.accessoryType = isSelect[indexPath.row] ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isSelect[indexPath.row].toggle()
        tableView.reloadData()
    }
}
