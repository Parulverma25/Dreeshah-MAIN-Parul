//
//  CompletedOrdersViewController.swift
//  Dreesha User
//
//  Created by Promatics on 27/05/21.
//

import UIKit

class CompletedOrdersViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var TableViewOrders: UITableView!
    
    
 //Mark Variables
    var ArrLabel1 = ["Designer Bed","Sofa","Italian Lamp"]
    var ArrImg1 = [#imageLiteral(resourceName: "Bed Image 1"),#imageLiteral(resourceName: "Sofa IMG2"),#imageLiteral(resourceName: "Light Img 3")]
    var viewModel = OrderManageViewModel()
    var offset = 0
    var isFetching = false
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewOrders.dataSource = self
        TableViewOrders.delegate = self
        TableViewOrders.reloadData()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Completed Orders")
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        hitApiOrderList()
    }
    
    @IBAction func viewDetails(_ sender: UIButton) {
        let vc = (storyboard?.instantiateViewController(identifier: "OrderListDetailViewController")) as! OrderListDetailViewController
        vc.ID = viewModel.model[sender.tag].professionalData?.first?.orderItemsData?.first?.id ?? ""
        vc.TitleArr = viewModel.model[sender.tag].professionalData?.map({$0.orderItemsData?.first?.productDetails?.first?.productTitle ?? ""}) ?? []
        vc.AEDArr = viewModel.model[sender.tag].professionalData?.map({$0.orderItemsData?.first?.productDetails?.first?.pricing?.price ?? 0}) ?? []
        vc.QuantityArr = viewModel.model[sender.tag].professionalData?.map({$0.orderItemsData?.first?.productQuantity ?? ""}) ?? []
        vc.UrlArr = viewModel.model[sender.tag].professionalData?.map({$0.orderItemsData?.first?.productDetails?.first?.productMedia?.first?.name ?? ""}) ?? []
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isFetching{
            self.offset += 10
            hitApiOrderList()
        }
    }
}

extension CompletedOrdersViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getOrderManageData()?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CompletedOrdersTableViewCell
        cell.titleOrder.text = "\(viewModel.model[indexPath.row].userDetails?.first?.firstName ?? "") \(viewModel.model[indexPath.row].userDetails?.first?.lastName ?? "")"
        cell.AED_Val.text = "AED \(viewModel.model[indexPath.row].orderData?.first?.amount ?? 0)"
        cell.PhoneNoOrders.text = " \(viewModel.model[indexPath.row].userDetails?.first?.phoneNumber ?? "")"
        let url = URLS.profileImageUrl(viewModel.model[indexPath.row].userDetails?.first?.profileImage ?? "").getDescription()
        cell.imageViewOrders.sd_setImage(with: URL(string: url ),placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
        cell.imageViewOrders.layer.cornerRadius = 10
        cell.imageViewOrders.clipsToBounds = true
//        cell.PhoneNoOrders.text = viewModel.getOrderManageData()?[indexPath.row].products?[indexPath.row]. ?? ""
        cell.ViewDetailsBtn.tag = indexPath.row
        cell.ViewDetailsBtn.addTarget(self, action: #selector(viewDetails(_:)), for: .touchUpInside)
        return cell
    }
}

extension CompletedOrdersViewController {

    func hitApiOrderList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiOrderList(Status: "completed" , Limit: "10", Offset: String(self.offset)){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                if ((self.viewModel.getOrderManageData()?.count ?? 0) == 0){
                    tableCollectionErrors(view: self.TableViewOrders, text: "No records found")
                }
                
                self.TableViewOrders.reloadData()
            }else{
                   
                    self.view.makeToast(message , position : .center)
                }
                
            }
        }
    
    
}
