//
//  DiscountsExpiredViewController.swift
//  Dreeshah
//
//  Created by Promatics on 20/03/21.
//

import UIKit

class DiscountsExpiredViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    
    var childNavigationController : UINavigationController?

    
    //Mark Outlets
    @IBOutlet weak var DiscountExpiredTableView: UITableView!
    
    //Mark Variables
    var ArrLabel1 = ["40% off on Abaya Sets","100 Discount over 1000 Purchase ","Buy 1 Body Scrub & Get 1 Banana Hand Scrub with 20% off " ,"Buy 1 Body Scrub & Get 1 Banana Hand Scrub with 20% off "]
    var ArrLabel2 = [ "40% off 45 Products on Minimum Purchase of Dhs 200.00", "Dhs 100.00 off on all products on minimum purchase of Dhs 10000.00", "Dhs 100.00 off on all products on minimum purchase of Dhs 20000.00", "Dhs 100.00 off on all products on minimum purchase of Dhs 30000.00"]
    var ArrButtonLabel = ["Expired","Expired","Expired","Expired"]
    var ArrImg = [ #imageLiteral(resourceName: "40%"), #imageLiteral(resourceName: "100%"), #imageLiteral(resourceName: "20%"), #imageLiteral(resourceName: "20%") ]
    
    var viewModel = DiscountsViewModel()
    var offset = 0
    var isFetching = false
    
    //Mark View Did Load
        override func viewDidLoad() {
        super.viewDidLoad()
            DiscountExpiredTableView.delegate=self
            DiscountExpiredTableView.dataSource=self
            DiscountExpiredTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        DiscountsList()
    }
    
    
    
    
    
    @IBAction func addBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CreateDiscountViewController") as! CreateDiscountViewController
        self.childNavigationController?.pushViewController(vc, animated: true)
        
    }
    
}
//Mark Table View Delegate Functions

extension DiscountsExpiredViewController{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.model.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DiscountsExpireTableViewCell
            if (viewModel.model[indexPath.row].discountApply?.to == "product"){
                if viewModel.model[indexPath.row].discountType == "shipping"{
                    let title = "Free Shipping on  \(viewModel.model[indexPath.row].discountApply?.productID?.productTitle ?? "" )"
                        cell.Label1.text = title
                        cell.Label2.text = "On minimum purchase of AED \(viewModel.model[indexPath.row].minimumRequirement?.value ?? 0)"
                        cell.ImageLabel.text = "AED \(viewModel.model[indexPath.row].discountValue ?? "")"
                    cell.ImageLabel.text = "Free Shipping"
                        cell.OffLabel.isHidden = true
                        cell.OffView.isHidden = true
                
            
                }else{
                    let title = "AED \(viewModel.model[indexPath.row].discountValue ?? "" ) off on \(viewModel.model[indexPath.row].discountApply?.productID?.productTitle ?? "" )"
                        cell.Label1.text = title
                        cell.Label2.text = "On minimum purchase of AED \(viewModel.model[indexPath.row].minimumRequirement?.value ?? 0)"
                        cell.ImageLabel.text = "AED \(viewModel.model[indexPath.row].discountValue ?? "")"
                        cell.OffLabel.isHidden = false
                        cell.OffView.isHidden = false
                }
            }else{
                let title = "\(viewModel.model[indexPath.row].discountValue ?? "" )% off on \(viewModel.model[indexPath.row].discountApply?.to ?? "") products "
                cell.Label1.text = title
                cell.Label2.text = title
                if (viewModel.model[indexPath.row].discountValue ?? "") == ""{
                    cell.ImageLabel.text = "BUY 1 And Get 1"
                    cell.OffLabel.isHidden = true
                    cell.OffView.isHidden = true
                }else{
                cell.ImageLabel.text = "\(viewModel.model[indexPath.row].discountValue ?? "")% "
                    cell.OffLabel.isHidden = false
                    cell.OffView.isHidden = false
                    
                    
                    
                }
            }
            
            
            
            cell.ButtonLabel.text = viewModel.model[indexPath.row].status ?? ""
            cell.Label4.text = (viewModel.model[indexPath.row].dateTime)?.dateFormatStringToUTCString
           
            switch (viewModel.model[indexPath.row].status ?? "") {
            case "active":
                cell.ButtView.backgroundColor = #colorLiteral(red: 0.1564441919, green: 0.6549337506, blue: 0.2705431581, alpha: 1)
            case "expired":
                cell.ButtView.backgroundColor =  #colorLiteral(red: 0.4234801531, green: 0.4588515162, blue: 0.490133822, alpha: 1)
            case "scheduled":
                cell.ButtView.backgroundColor =  #colorLiteral(red: 0.9921236634, green: 0.7490544319, blue: 0.02763858065, alpha: 1)
            default:
                cell.ButtView.backgroundColor = .black
            }
            
            return cell
        }
    
}



//MARK:- API Call
extension DiscountsExpiredViewController{
    func DiscountsList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiDiscountsList(Status: "expired"){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.isFetching = true
                tableCollectionErrors(view: self.DiscountExpiredTableView, text: "")
                self.DiscountExpiredTableView.reloadData()
            }else{
                if message == "not found"{
                    self.isFetching = false
                    if self.offset == 0{
                        self.viewModel.model = []
                        self.DiscountExpiredTableView.reloadData()
                        tableCollectionErrors(view: self.DiscountExpiredTableView, text: "No records found")
                    }else{
                        
                    }
                    
                }else{
                   
                    self.view.makeToast(message , position : .center)
                }
                
            }
        }
    }
    
}
