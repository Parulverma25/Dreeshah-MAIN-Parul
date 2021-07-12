//
//  AllQuotationRequestsViewController.swift
//  Dreeshah
//
//  Created by promatics on 20/02/21.
//

import UIKit

class AllQuotationRequestsViewController: UIViewController {
        @IBOutlet weak var quotationalltableview: UITableView!
        
    @IBOutlet weak var searchTextField: UITextField!
    
        //MARK: VARAIBLES
        var viewModel = QuotationProfessionalViewModel()
        var offset = 0
        var isFetching = false
        var viewController : UINavigationController?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.hideKeyboardWhenTappedAround()
            quotationalltableview.dataSource=self
            quotationalltableview.delegate = self
            quotationalltableview.reloadData()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        //self.searchTextField.text = ""
        hitApiQuotationsList(search: "", filter: "")
    }

override func viewWillDisappear(_ animated: Bool) {
    
    searchTextField.text = ""
}
        
    
    //MARK:- IBActions
    
        @IBAction func viewDetails(_ sender: UIButton) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "QuotDetailsViewController") as! QuotDetailsViewController
            vc.QuotationIDStrVal = viewModel.model[sender.tag].id ?? ""
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    
    @IBAction func tapAccept(_ sender: UIButton) {
        hitAcceptReject(status: "accepted", quoto_id: viewModel.getQuotationListData()?[sender.tag].proffQuoutationListingModelID ?? "", reason: "")
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

  
    
    
    @IBAction func searchAction(_ sender: Any) {
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        hitApiQuotationsList(search: searchTextField.text?.replacingOccurrences(of: " ", with: "") ?? "", filter: "service_name,location,name")
    }
    
    
  
}



extension AllQuotationRequestsViewController: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate{
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if (viewModel.getQuotationListData()?.count ?? 0) == 0 {
                tableCollectionErrors(view: quotationalltableview, text: "No Records Found")
            }else{
                tableCollectionErrors(view: quotationalltableview, text: "")
            }
            
            return viewModel.getQuotationListData()?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! quotationRequestListTableViewCell
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
                
                cell.rejectReasonLbl.text = "Reason : \(viewModel.model[indexPath.row].rejectReason ?? "")"
            
            switch (cell.requestStatusLbl.text) {
            case "pending":
                cell.ProcessViewColor.isHidden = false
                cell.PendingbtnView.isHidden = false
                cell.CreateOrderBtnView.isHidden = true
                cell.horizontalView.isHidden = false
                cell.verticalView.isHidden = false
            case "completed":
                cell.ProcessViewColor.isHidden = false
                cell.PendingbtnView.isHidden = true
                cell.horizontalView.isHidden = true
                cell.verticalView.isHidden = true
                cell.CreateOrderBtnView.isHidden = true
                cell.ProcessViewColor.backgroundColor = #colorLiteral(red: 0, green: 0.4824024439, blue: 0.9998757243, alpha: 1)
            case "modified":
                cell.ProcessViewColor.isHidden = false
                cell.CreateOrderBtnView.isHidden = true
                cell.horizontalView.isHidden = true
                cell.verticalView.isHidden = true
                cell.CreateOrderBtnView.isHidden = true
                cell.ProcessViewColor.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            case "rejected":
                cell.ProcessViewColor.isHidden = false
                cell.PendingbtnView.isHidden = true
                cell.horizontalView.isHidden = true
                cell.verticalView.isHidden = true
                cell.CreateOrderBtnView.isHidden = true
                cell.ProcessViewColor.backgroundColor = #colorLiteral(red: 0.8627645373, green: 0.2078584731, blue: 0.2705822289, alpha: 1)
            case "cancelled":
                cell.ProcessViewColor.isHidden = false
                cell.CreateOrderBtnView.isHidden = true
                cell.ProcessViewColor.backgroundColor = #colorLiteral(red: 0.8627645373, green: 0.2078584731, blue: 0.2705822289, alpha: 1)
            case "approved":
                cell.ProcessViewColor.isHidden = true
                cell.PendingbtnView.isHidden = true
                cell.horizontalView.isHidden = false
                cell.verticalView.isHidden = false
                cell.CreateOrderBtnView.isHidden = false
                cell.ProcessViewColor.backgroundColor = #colorLiteral(red: 0.1564441919, green: 0.6549337506, blue: 0.2705431581, alpha: 1)
            case "inprogress":
                cell.ProcessViewColor.isHidden = false
                cell.PendingbtnView.isHidden = true
                cell.horizontalView.isHidden = true
                cell.verticalView.isHidden = true
                cell.CreateOrderBtnView.isHidden = true
                cell.ProcessViewColor.backgroundColor = #colorLiteral(red: 0.2038936317, green: 0.2274665534, blue: 0.2509453297, alpha: 1)
            case "closed":
                cell.ProcessViewColor.isHidden = false
                cell.PendingbtnView.isHidden = true
                cell.horizontalView.isHidden = true
                cell.verticalView.isHidden = true
                cell.CreateOrderBtnView.isHidden = true
                cell.ProcessViewColor.backgroundColor = #colorLiteral(red: 0.2038936317, green: 0.2274665534, blue: 0.2509453297, alpha: 1)
            default:
                cell.ProcessViewColor.isHidden = false
                cell.PendingbtnView.isHidden = false
                cell.PendingbtnView.isHidden = true
                cell.horizontalView.isHidden = true
                cell.verticalView.isHidden = true
                cell.CreateOrderBtnView.isHidden = true
                cell.ProcessViewColor.backgroundColor = #colorLiteral(red: 0.8627645373, green: 0.2078584731, blue: 0.2705822289, alpha: 1)
            }
            
            
            }
            
            return cell
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if isFetching{
                self.offset += 10
                hitApiQuotationsList(search: "", filter: "service_name,location,name")
            }
        }

    }

    //MARK:- API Call
    extension AllQuotationRequestsViewController{
        
        
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
        
        func hitApiQuotationsList(search : String , filter : String){
            
            Indicator.shared.showProgressView(self.parent?.parent?.view ?? self.view)
            
            viewModel.apiQuotationListfunc(limit: "10", offset: String(self.offset), Status: "all", searchKey: search, filter: filter) {(isSuccess , message) in
                Indicator.shared.hideProgressView()
                if isSuccess{
                    self.isFetching = true
                    self.quotationalltableview.reloadData()
                    tableCollectionErrors(view: self.quotationalltableview, text: "")
                }else{
                    if message == "no records"{
                        self.isFetching = false
                        if self.offset == 0{
                            self.viewModel.model = []
                            self.quotationalltableview.reloadData()
                            tableCollectionErrors(view: self.quotationalltableview, text: "No records found")
                        }else{
                            
                        }
                        
                    }else{
                       
                        self.view.makeToast(message , position : .center)
                    }
                    
                }
            }
            
           
        }
        
    }
