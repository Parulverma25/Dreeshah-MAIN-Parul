//
//  AllInProgressRequestsViewController.swift
//  Dreeshah
//
//  Created by promatics on 20/02/21.
//

import UIKit

class AllInProgressRequestsViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var InProgressListTable: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK: VARAIBLES
    
    var viewModel = QuotationProfessionalViewModel()
    var offset = 0
    var isFetching = false
    var viewController : UINavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InProgressListTable.delegate = self
        InProgressListTable.dataSource = self
        InProgressListTable.reloadData()
    }
    
    @IBAction func viewDetails(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "QuotDetailsViewController") as! QuotDetailsViewController
        vc.QuotationIDStrVal = viewModel.model[sender.tag].id ?? ""
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        hitApiQuotationsList(search: "", filter: "")
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        searchTextField.text = ""
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        hitApiQuotationsList(search: searchTextField.text?.replacingOccurrences(of: " ", with: "") ?? "", filter: "service_name,location,name")
    }
    
}

extension AllInProgressRequestsViewController: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel.getQuotationListData()?.count ?? 0) == 0 {
            tableCollectionErrors(view: InProgressListTable, text: "No Records Found")
        }else{
            tableCollectionErrors(view: InProgressListTable, text: "")
        }
        return viewModel.getQuotationListData()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! InProgressListTableViewCell
        if(viewModel.model.count != 0){
        cell.titleLbl.text = viewModel.model[indexPath.row].serviceName ?? ""
        cell.dateLbl.text = viewModel.model[indexPath.row].date ?? ""
        cell.descLbl.text = "Service Submission Date: \(viewModel.model[indexPath.row].expectedDate ?? "") "
        cell.refrenceLbl.text = "Quotation Ref: \(viewModel.model[indexPath.row].quotationRef ?? "")"
      cell.requestStatusLbl.text =  viewModel.model[indexPath.row].status ?? ""
        let imageurl = URLS.serviceImageUrl(viewModel.model[indexPath.row].professionalServiceID?.serviceImage ?? "").getDescription()
        cell.imgView.sd_setImage(with: URL(string: imageurl), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
        cell.viewDetailsBtn.tag = indexPath.row
        cell.viewDetailsBtn.addTarget(self, action: #selector(viewDetails(_:)), for: .touchUpInside)
        cell.ProcessViewColor.backgroundColor = #colorLiteral(red: 0.2038936317, green: 0.2274665534, blue: 0.2509453297, alpha: 1)
        }
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isFetching{
            self.offset += 10
            hitApiQuotationsList(search: searchTextField.text?.replacingOccurrences(of: " ", with: "") ?? "", filter: "")
        }
    }

}

//MARK:- API Call
extension AllInProgressRequestsViewController{
    func hitApiQuotationsList(search : String , filter : String){
        
        Indicator.shared.showProgressView(self.parent?.parent?.view ?? self.view)
        
        viewModel.apiQuotationListfunc(limit: "10", offset: String(self.offset), Status: "inprogress", searchKey: search, filter: filter) {(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.isFetching = true
                self.InProgressListTable.reloadData()
            }else{
                if message == "no records"{
                    self.isFetching = false
                    if self.offset == 0{
                        self.viewModel.model = []
                        self.InProgressListTable.reloadData()
                        tableCollectionErrors(view: self.InProgressListTable, text: "No records found")
                    }else{
                        
                    }
                    
                }else{
                   
                    self.view.makeToast(message , position : .center)
                }
                
            }
        }
        
    }
    
}
