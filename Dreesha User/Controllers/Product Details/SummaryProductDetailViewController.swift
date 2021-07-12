//
//  SummaryProductDetailViewController.swift
//  Dreesha User
//
//  Created by promatics on 3/24/21.
//

import UIKit

class SummaryProductDetailViewController: UIViewController {
    @IBOutlet weak var tableViewForSummary: UITableView!
    
    
    var arySummaaryLeft = ["Product:","Manufactured By:","Sold By:","Color:","Category:"]
    var arySummaaryRight = [String]()
    var ProductIdStr = ""
    var viewModel = ProductsDetailViewModel()
    var colors = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        hitApiProductsDetailsList()
    }
    
}
extension SummaryProductDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arySummaaryLeft.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewForSummary.dequeueReusableCell(withIdentifier: "cell") as! SummaryOfProductDetailTableViewCell
        cell.leftSideLbl.text = arySummaaryLeft[indexPath.row]
        switch (indexPath.row) {
        case 0:
            cell.rightSideLbl.text = viewModel.getProductDetailsData()?.details?.productUniqueID  ?? ""
        case 1:
            cell.rightSideLbl.text = viewModel.getProductDetailsData()?.details?.productDetails?.vendor?.vendorName ?? ""
        case 2:
            cell.rightSideLbl.text = "\((viewModel.getProductDetailsData()?.details?.professionalID?.firstName ?? "") + " " + (viewModel.getProductDetailsData()?.details?.professionalID?.lastName ?? ""))"
        case 3:
            
            
            cell.rightSideLbl.text = colors.joined(separator: ",")
        
       
        default:
            cell.rightSideLbl.text = viewModel.getProductDetailsData()?.details?.categoryID?.name ?? ""
        }
        
        return cell
    }
   
}
extension SummaryProductDetailViewController{
    func hitApiProductsDetailsList(){

        Indicator.shared.showProgressView(self.parent?.view ?? self.view)

        viewModel.apiProductDetails(Product_id: ProductIdStr ){(isSuccess , message) in
            self.tableViewForSummary.reloadData()
            if isSuccess{
                self.colors = self.viewModel.model?.details?.availableColor.map({$0?.colorName ?? ""}) ?? []
                
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
}
