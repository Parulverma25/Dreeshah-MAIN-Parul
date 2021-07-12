//
//  AllCompletedViewController.swift
//  Dreeshah
//
//  Created by promatics on 20/02/21.
//

import UIKit

class AllCompletedViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var completedListTable: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var parentNavigationController : UINavigationController?

    //MARK: VARAIBLES
    
    var viewModel = QuotationProfessionalViewModel()
    var offset = 0
    var isFetching = false
    var viewController : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completedListTable.delegate = self
        completedListTable.dataSource = self
        completedListTable.reloadData()
       
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

extension AllCompletedViewController: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel.getQuotationListData()?.count ?? 0) == 0 {
            tableCollectionErrors(view: completedListTable, text: "No Records Found")
        }else{
            tableCollectionErrors(view: completedListTable, text: "")
        }
        return viewModel.getQuotationListData()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! completedListTableViewCell
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
        cell.ProcessViewColor.backgroundColor = #colorLiteral(red: 0, green: 0.4824024439, blue: 0.9998757243, alpha: 1)
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
extension AllCompletedViewController{
    func hitApiQuotationsList(search : String , filter : String){
        
        Indicator.shared.showProgressView(self.parent?.parent?.view ?? self.view)
        
        viewModel.apiQuotationListfunc(limit: "10", offset: String(self.offset), Status: "completed", searchKey: search, filter: filter) {(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.isFetching = true
                self.completedListTable.reloadData()
            }else{
                if message == "no records"{
                    self.isFetching = false
                    if self.offset == 0{
                        self.viewModel.model = []
                        self.completedListTable.reloadData()
                        tableCollectionErrors(view: self.completedListTable, text: "No records found")
                    }else{
                        
                    }
                    
                }else{
                   
                    self.view.makeToast(message , position : .center)
                }
                
            }
        }
        
    }
    
}
