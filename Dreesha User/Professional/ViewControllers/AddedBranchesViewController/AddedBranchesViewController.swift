//
//  AddedBranchesViewController.swift
//  Dreeshah
//
//  Created by promatics on 12/03/21.
//

import UIKit

class AddedBranchesViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var branchesTableView: UITableView!
    
    //MARK:- Variables
    var viewModel = AddedBranchesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        branchesTableView.delegate = self
        branchesTableView.dataSource = self
        branchesTableView.reloadData()
       
    }

    
    override func viewWillAppear(_ animated: Bool) {
        getBranchList()
        setBackWithTitle(titleVal: "Branches")
    }
    
    @objc func tapViewDetails(_ sender : UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsOfBranchViewController") as! DetailsOfBranchViewController
        vc.branchId = viewModel.model[sender.tag].id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func viewAddBranch(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "GeneralDetailViewController") as! GeneralDetailViewController
        vc.isBranchAdd = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK:- TableView Delegates
extension AddedBranchesViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "branchesTableViewCell", for: indexPath) as! branchesTableViewCell
        cell.pointOfContact.text = (viewModel.model[indexPath.row].firstName ?? "") + " \(viewModel.model[indexPath.row].lastName ?? "")"
        cell.branchDesc.text = viewModel.model[indexPath.row].branchBrief ?? ""
        cell.creationDate.text = Singleton.sharedInstance.dateFormatChange(date: viewModel.model[indexPath.row].createdAt ?? "", oldFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", newFormat: "dd-MM-yyyy")
        let url = URLS.profileImageUrl(viewModel.model[indexPath.row].branchProfile ?? "").getDescription()
        cell.branchImage.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "Placehold"))
        cell.branchName.text = viewModel.model[indexPath.row].branchNameEn ?? ""
        cell.viewDetailsBtn.tag = indexPath.row
        cell.viewDetailsBtn.addTarget(self, action: #selector(tapViewDetails(_:)), for: .touchUpInside)
        return cell
    }
    
    
}

//MARK:- API
extension AddedBranchesViewController{
    func getBranchList(){
        viewModel.apiGetBranchList { (isSuccess, message) in
            if isSuccess{
                tableCollectionErrors(view: self.branchesTableView, text: "")
                self.branchesTableView.reloadData()
            }else{
                
                if message == "no records"{
                    tableCollectionErrors(view: self.branchesTableView, text: "No Branches Added")
                }else{
                    self.showDefaultAlert(Message: message)
                }
                
               
            }
        }
    }
}
