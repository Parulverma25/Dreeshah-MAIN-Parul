//
//  MyOrdersCancelledViewController.swift
//  Dreesha User
//
//  Created by Promatics on 12/03/21.
//

import UIKit

class MyOrdersCancelledViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    //MARK: OUTLETS
    @IBOutlet weak var OrdercnclTableView: UITableView!
    
    
    //MARK: VARAIBLES
    var viewModel = MyOrdersinProgressViewModel()
    var OrderviewModel = ProductsDetailViewModel()
    var offset = 0
    var isFetching = false
    
    //MARK: View DID Load
    override func viewDidLoad() {
        super.viewDidLoad()
        OrdercnclTableView.delegate=self
        OrdercnclTableView.dataSource=self
        OrdercnclTableView.reloadData()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "My Orders")
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        hitApiCancelledOrdersList()
    }
 
    @objc func tapViewDetails(_ sender : UIButton){
        let vc = storyboard?.instantiateViewController(identifier: "OrderTrackingViewController") as! OrderTrackingViewController
//        vc.OrderIdStrVal = viewModel.getinProgressOrderListData()?[sender.tag].id ?? ""
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func OrderAgainbuttonTapped(_ sender : UIButton){
        hitapiOrderAgain(User_id: viewModel.model[sender.tag].id?.orderID ?? "" )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Order Cancelled Cell") as! MyOrdersCancellTableViewCell
        cell.OrderIdVal.text = viewModel.model[indexPath.row].orderData?.first?.orderNo ?? ""
        cell.OrderTitle.text = "\(viewModel.model[indexPath.row].professionalData?.first?.firstName  ?? "") \(viewModel.model[indexPath.row].professionalData?.first?.lastName  ?? "")"
        cell.Date.text = (viewModel.model[indexPath.row].orderData?.first?.orderHistory?.first?.date ?? "")?.dateFormatStringToUTCString
        cell.CancelLbl.text = viewModel.model[indexPath.row].orderData?.first?.orderStatus ?? ""
        cell.SarLAbel.text = "AED \(viewModel.model[indexPath.row].orderData?.first?.amount  ?? 0)"
        cell.ReasonLabel.text = "Reason: \(viewModel.model[indexPath.row].orderData?.first?.cancelReason ?? "")"
        let imageUrl = URLS.profileImageUrl(viewModel.model[indexPath.row].professionalData?.first?.profileImage ?? "").getDescription()
        cell.CancelImgView.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placehold"))

        cell.ViewDtlBtn.tag = indexPath.row
        cell.ViewDtlBtn.addTarget(self, action: #selector(tapViewDetails(_:)), for: .touchUpInside)

        cell.OrderAgainBtn.tag = indexPath.row
        cell.OrderAgainBtn.addTarget(self, action: #selector(OrderAgainbuttonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isFetching{
            self.offset += 10
            hitApiCancelledOrdersList()
        }
    }
    
}

//MARK:- API Call
extension MyOrdersCancelledViewController{
    func hitApiCancelledOrdersList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiinProgressOrderList(Status: "cancelled", Limit: "10" , Offset: String(self.offset)){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.isFetching = true
                self.OrdercnclTableView.reloadData()
                if self.viewModel.count == 0 {
                    tableCollectionErrors(view: self.OrdercnclTableView, text: "No records found")
                }
            }else{
                   
                    self.view.makeToast(message , position : .center)
                }
                
            }
        }
    
    func hitapiOrderAgain(User_id : String){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)

        OrderviewModel.hitAddtoCartAgain(User_id: User_id) {(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.showAlertWithAction(Title: "Dreeshah", Message: message, ButtonTitle: "OK") {
                    let vc = self.storyboard?.instantiateViewController(identifier: "CartNewViewController") as! CartNewViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    }
