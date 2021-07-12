//
//  MyOrdersDelieveredViewController.swift
//  Dreesha User
//
//  Created by Promatics on 12/03/21.
//

import UIKit

class MyOrdersDelieveredViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var MyOrderstableView: UITableView!
    var viewModel = MyOrdersinProgressViewModel()
    var offset = 0
    var isFetching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        MyOrderstableView.delegate=self
        MyOrderstableView.dataSource=self
//        self.viewModel.model = []
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "My Orders")
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        hitapiInProgressOrdersList()
    }
    @IBAction func ViewDetailbuttonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "OrderDtlsViewController") as! OrderDtlsViewController
        vc.OrderIdStrVal = viewModel.model[sender.tag].id?.orderID ?? ""
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK:- Objc Func
    @objc func tapViewDetails(_ sender : UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "OrderDtlsViewController") as! OrderDtlsViewController
//        vc.OrderIdStrVal = viewModel.()?.result[sender.tag]?.id ?? ""
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrdersDelievered Cell") as! MyOrdersDelieveredTableViewCell
        cell.Order_idVal.text = viewModel.model[indexPath.row].orderData?.first?.orderNo ?? ""
        cell.OrderTitleVal.text = "\(viewModel.model[indexPath.row].professionalData?.first?.firstName  ?? "") \(viewModel.model[indexPath.row].professionalData?.first?.lastName  ?? "")"
        cell.DateVal.text = (viewModel.model[indexPath.row].orderData?.first?.orderHistory?.first?.date ?? "")?.dateFormatStringToUTCString
       
        cell.SarVal.text =  "AED \(viewModel.model[indexPath.row].orderData?.first?.amount  ?? 0)"


        let imageUrl = URLS.profileImageUrl(viewModel.model[indexPath.row].professionalData?.first?.profileImage ?? "").getDescription()
        cell.MyorderImgview.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
        
    
        cell.ViewDetailBtn.tag = indexPath.row
        cell.ViewDetailBtn.addTarget(self, action: #selector(ViewDetailbuttonTapped(_:)), for: .touchUpInside)
        
        cell.ExchangeBtn.tag = indexPath.row
//        cell.ExchangeBtn.addTarget(self, action: #selector(CancelbuttonTapped(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isFetching{
            self.offset += 10
            hitapiInProgressOrdersList()
        }
    }
    
}

//MARK:- API Call
extension MyOrdersDelieveredViewController{
    func hitapiInProgressOrdersList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiinProgressOrderList(Status: "delivered", Limit: "10" , Offset: String(self.offset)){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{

                self.isFetching = true
                self.MyOrderstableView.reloadData()
                if self.viewModel.count == 0 {
                    tableCollectionErrors(view: self.MyOrderstableView, text: "No records found")
                }
            }else{
                
                    self.view.makeToast(message , position : .center)
                }
                
            }
        }
    }

