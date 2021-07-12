//
//  AllPendingRequestsViewController.swift
//  Dreeshah
//
//  Created by promatics on 20/02/21.
//

import UIKit

class AllPendingRequestsViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var pendingRequestsTable: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    //MARK: VARAIBLES
    
    var viewModel = QuotationProfessionalViewModel()
    var offset = 0
    var isFetching = false
    var viewController : UINavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pendingRequestsTable.delegate = self
        pendingRequestsTable.dataSource = self
        pendingRequestsTable.reloadData()
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
    
    @IBAction func tapAccept(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AddIssueQuotationViewController") as! AddIssueQuotationViewController
        vc.customerId = viewModel.model[sender.tag].customerID ?? ""
        vc.quotationId = viewModel.model[sender.tag].id ?? ""
        vc.name = viewModel.getQuotationListData()?[sender.tag].subject ?? ""
        viewController?.navigationController?.pushViewController(vc, animated: true)
        // hitAcceptReject(status: "accepted", quoto_id: viewModel.getQuotationListData()?[sender.tag].proffQuoutationListingModelID ?? "", reason: "")
    }
    
    @IBAction func tapReject(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "RejectReasonPopup") as! RejectReasonPopup
        vc.modalPresentationStyle = .overFullScreen
        vc.completionBlock = {
            confirm , reason in
                if confirm{
                    self.hitAcceptReject(status: "rejected", quoto_id: self.viewModel.getQuotationListData()?[sender.tag].proffQuoutationListingModelID ?? "", reason: reason)
                }
            
        }
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
}

extension AllPendingRequestsViewController: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (viewModel.getQuotationListData()?.count ?? 0) == 0 {
            tableCollectionErrors(view: pendingRequestsTable, text: "No Records Found")
        }else{
            tableCollectionErrors(view: pendingRequestsTable, text: "")
        }
        
        return viewModel.getQuotationListData()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! pendingRequestListTableViewCell
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
        cell.acceptBtn.tag = indexPath.row
        cell.rejectBtn.tag = indexPath.row
        cell.ProcessViewColor.isHidden = true
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
extension AllPendingRequestsViewController{
    func hitApiQuotationsList(search : String , filter : String){
        
        Indicator.shared.showProgressView(self.parent?.parent?.view ?? self.view)
        
        viewModel.apiQuotationListfunc(limit: "10", offset: String(self.offset), Status: "pending", searchKey: search, filter: filter) {(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.isFetching = true
                self.pendingRequestsTable.reloadData()
            }else{
                if message == "no records"{
                    self.isFetching = false
                    if self.offset == 0{
                        self.viewModel.model = []
                        self.pendingRequestsTable.reloadData()
                        tableCollectionErrors(view: self.pendingRequestsTable, text: "No records found")
                    }else{
                        
                    }
                    
                }else{
                   
                    self.view.makeToast(message , position : .center)
                }
                
            }
        }
        
      
    }
    
    
    func hitAcceptReject(status : String , quoto_id : String , reason : String){
        viewModel.acceptRejectQuotationRqst(quotation_Id: quoto_id, status: status, rejectReason: reason) { (isSuccess, message) in
            if isSuccess{
                self.offset = 0
                self.viewModel.model = []
                self.isFetching = false
                self.hitApiQuotationsList(search: "", filter: "")
            }else{
                
            }
        }
    }
    
}
