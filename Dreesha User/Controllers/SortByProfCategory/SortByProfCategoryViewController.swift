//
//  SortByProfCategoryViewController.swift
//  Dreesha User
//
//  Created by promatics on 3/1/1400 AP.
//

import UIKit

class SortByProfCategoryViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var categoryListTable: UITableView!
    
    //MARK:- Varibales
    var ServiceViewModel = SignupViewModel()
    
    var isSelect: Int!
    var comefrom = ""
    var CategoryId = ""
    
    typealias sortBy = (_ infoToReturn :String) ->()
    var completionBlock : sortBy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryListTable.delegate = self
        categoryListTable.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getcategory()
    }
    
    //MARK:- IBActions
    
    @IBAction func tapDismiss(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}


//MARK:- TableView Delegate

extension SortByProfCategoryViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceViewModel.serviceModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryListTableViewCell", for: indexPath) as! categoryListTableViewCell
        cell.categoryNameLbl.text = ServiceViewModel.serviceModel[indexPath.row].name ?? ""
        
        switch (indexPath.row) {
        case isSelect:
            cell.radiobtn.setImage(UIImage(named: "Radio On"),for: .normal)
        default:
            cell.radiobtn.setImage(UIImage(named: "Radio Off"),for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isSelect = indexPath.row
        guard let cb = completionBlock else {return}
        cb("\(ServiceViewModel.serviceModel[indexPath.row].id ?? "")")
        categoryListTable.reloadData()
        
    }
    
    
}

//MARK:- API CALL
extension SortByProfCategoryViewController{
func getcategory(){
    
    ServiceViewModel.hitServiceList(search: " ") {
        (isSuccess , message) in
        if isSuccess {
            self.categoryListTable.reloadData()
        }
        else{
            self.view.makeToast(message)
        }
    }
}
}
