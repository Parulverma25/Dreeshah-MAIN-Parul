//
//  MyOrderinProgressViewController.swift
//  Dreesha User
//
//  Created by Promatics on 12/03/21.
//

import UIKit

class MyOrderinProgressViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    

    var viewModel = MyOrdersinProgressViewModel()
    var offset = 0
    var isFetching = false
    @IBOutlet weak var progtableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        progtableview.dataSource=self
        progtableview.delegate=self
        progtableview.reloadData()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "My Orders")
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        hitapiInProgressOrdersList()
    }
    

    @IBAction func ViewDetailbuttonTapped(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(identifier: "OrderTrackingViewController") as! OrderTrackingViewController
        vc.ProductTitleArr = viewModel.model[sender.tag].professionalData?.first?.orderItemsData?.map({$0.productDetails?.first?.productTitle ?? ""}) ?? []
        vc.ProductPriceArr = viewModel.model[sender.tag].professionalData?.first?.orderItemsData?.map({$0.productDetails?.first?.pricing?.price  ?? 0}) ?? []
        vc.ProductQuantityArr = viewModel.model[sender.tag].professionalData?.first?.orderItemsData?.map({$0.productQuantity  ?? ""}) ?? []
        vc.UrlArr = viewModel.model[sender.tag].professionalData?.first?.orderItemsData?.map({$0.productDetails?.first?.productMedia?.first?.name  ?? ""}) ?? []
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func CancelbuttonTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "CancelOrderPopupViewController") as! CancelOrderPopupViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.completionBlock = {
            confirm , reason in
                if confirm
                {
                    self.cancelOrderItems(OrderID: self.viewModel.model[sender.tag].id?.orderID ?? "" , reason: reason)
                }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"MyOrder in Progress Cell") as! MyOrderinProgressTableViewCell
        cell.Order_idVal.text = viewModel.model[indexPath.row].orderData?.first?.orderNo ?? ""
        cell.OrderTitleVal.text = "\(viewModel.model[indexPath.row].professionalData?.first?.firstName  ?? "") \(viewModel.model[indexPath.row].professionalData?.first?.lastName  ?? "")"
        cell.DateVal.text = (viewModel.model[indexPath.row].orderData?.first?.orderHistory?.first?.date ?? "")?.dateFormatStringToUTCString
        cell.processlbl.text = viewModel.model[indexPath.row].orderData?.first?.orderStatus ?? ""
        cell.SARVal.text = "AED \(viewModel.model[indexPath.row].orderData?.first?.amount  ?? 0)"


        let imageUrl = URLS.profileImageUrl(viewModel.model[indexPath.row].professionalData?.first?.profileImage ?? "").getDescription()
        cell.imgviewprocess.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
        
        
        if cell.processlbl.text == "pending" {
            cell.processview.backgroundColor = #colorLiteral(red: 0.5097572803, green: 0.5098338723, blue: 0.5097404718, alpha: 1)
        }else{
            cell.processview.backgroundColor = #colorLiteral(red: 0.7175258994, green: 0.9020048976, blue: 0.5136614442, alpha: 1)
            cell.processlbl.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        cell.ViewDtlBtn.tag = indexPath.row
        cell.ViewDtlBtn.addTarget(self, action: #selector(ViewDetailbuttonTapped(_:)), for: .touchUpInside)
        
        cell.CancellOrderBtn.tag = indexPath.row
        cell.CancellOrderBtn.addTarget(self, action: #selector(CancelbuttonTapped(_:)), for: .touchUpInside)
        
        
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
extension MyOrderinProgressViewController{
    func hitapiInProgressOrdersList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiinProgressOrderList(Status: "pending", Limit: "10" , Offset: String(self.offset)){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.isFetching = true
         
                self.progtableview.reloadData()
                if self.viewModel.count == 0 {
                    tableCollectionErrors(view: self.progtableview, text: "No records found")
                }
            }else{
                   
                    self.view.makeToast(message , position : .center)
                }
                
            }
        }

    
    
    func cancelOrderItems(OrderID : String ,reason : String){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.hitCancellOrder(OrderId: OrderID , Cancel_reason: reason) { (isSuccess, message) in
            if isSuccess{
                self.showAlertWithAction(Title: "Dreeshah", Message: message, ButtonTitle: "OK") {
                    self.offset = 0
                    self.viewModel.model = []
                    self.isFetching = false
                    self.hitapiInProgressOrdersList()
                    
                }
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
}
