//
//  QuotationReqPendingViewController.swift
//  Dreesha User
//
//  Created by Apple on 17/03/21.
//

import UIKit

class QuotationReqPendingViewController: UIViewController{
    
    @IBOutlet weak var requestsTable: UITableView!
   
    @IBOutlet weak var searchBar: UITextField!
    
    
    
    //MARK: VARAIBLES
    
    var viewModel = QuotationViewModel()
    var offset = 0
    var isFetching = false
    var filtervalstr = "service_name,location,name"
    var searchvalStr = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
            self.offset = 0
            self.viewModel.model = []
            self.isFetching = false
            hitApiQuotationsList(Search: "", Filter: "")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.text = ""
    }

    @IBAction func viewDetails(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "QuotationDetailViewController") as! QuotationDetailViewController
        vc.QuotationIDStrVal = viewModel.model[sender.tag].id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
 

    @IBAction func searchAction(_ sender: Any) {
        
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        hitApiQuotationsList(Search: searchBar.text?.replacingOccurrences(of: " ", with: "") ?? "", Filter: filtervalstr)
    }
    

}

extension QuotationReqPendingViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getQuotationListData()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QuotationReqPendingTableViewCell
        cell.titleLbl.text = viewModel.model[indexPath.row].serviceName ?? ""
        cell.dateLbl.text = viewModel.model[indexPath.row].date ?? ""
        cell.descLbl.text = "Service Submission Date: \(viewModel.model[indexPath.row].expectedDate ?? "") "
        cell.refrenceLbl.text = viewModel.model[indexPath.row].quotationRef ?? ""
//      cell.requestStatusLbl.text =  viewModel.model[indexPath.row].status ?? ""
      
        let imageurl = URLS.serviceImageUrl(viewModel.model[indexPath.row].professionalServiceID?.serviceImage ?? "").getDescription()
        cell.ImgView.sd_setImage(with: URL(string: imageurl), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
        cell.viewDetailsBtn.tag = indexPath.row
        cell.viewDetailsBtn.addTarget(self, action: #selector(viewDetails(_:)), for: .touchUpInside)
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isFetching{
            self.offset += 10
            
            hitApiQuotationsList(Search: searchBar.text?.replacingOccurrences(of: " ", with: "") ?? "", Filter: filtervalstr)
        }
    }

}
//MARK:- API Call
extension QuotationReqPendingViewController{
    func hitApiQuotationsList(Search: String , Filter : String){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiQuotationListfunc(limit: "10", offset: String(self.offset) , Status: "pending" ,Search: Search ,Filter: Filter ){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.isFetching = true
                self.requestsTable.reloadData()
            }else{
                if message == "no records"{
                    self.isFetching = false
                    if self.offset == 0{
                        self.viewModel.model = []
                        self.requestsTable.reloadData()
                        tableCollectionErrors(view: self.requestsTable, text: "No records found")
                    }else{
                        
                    }
                    
                }else{
                   
                    self.view.makeToast(message , position : .center)
                }
                
            }
        }
    }
    
}
