//
//  CollectionsListViewController.swift
//  Dreesha User
//
//  Created by Promatics on 17/06/21.
//

import UIKit

class CollectionsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Outlets
    
    @IBOutlet weak var CollectionsTableView: UITableView!
    
    //MARK: Variable
    var viewModel = CollectionProductsViewModel()
    var offset = 0
    var iconClick = true
    var isFetching = false
    var CollectionIDStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionsTableView.delegate = self
        CollectionsTableView.dataSource = self
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Collection Products")
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        hitApiCollectionProductsList()
        
    }
    
    @IBAction func tapRemove(_ sender : UIButton){
        RemoveProduct(ID : viewModel.model[sender.tag].id ?? "")
        
    }
    @IBAction func viewDetailsProduct(_ sender: UIButton) {
        
            let vc = self.storyboard?.instantiateViewController(identifier: "ProfProductDetailsViewController") as! ProfProductDetailsViewController
        vc.productID = self.viewModel.model[sender.tag].productID?.id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension CollectionsListViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CollectionsListTableViewCell
        cell.titleLbl.text = viewModel.model[indexPath.row].productID?.productTitle ?? ""
        cell.AEDLabel.text = "AED \(viewModel.model[indexPath.row].productID?.pricing?.price ?? 0)"
        cell.DescriptionLbl.text = viewModel.model[indexPath.row].productID?.productDescription ?? ""
        cell.DiscountLbl.text = "\(viewModel.model[indexPath.row].productID?.pricing?.comprice ?? 0)"
        let url = URLS.productImgUrl(viewModel.model[indexPath.row].productID?.productMedia.first??.name ?? "").getDescription()
        cell.CollectionImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
        cell.CollectionImageView.layer.cornerRadius = 10
        cell.CollectionImageView.clipsToBounds = true
        cell.ViewDetailsBtn.tag = indexPath.row
        cell.ViewDetailsBtn.addTarget(self, action: #selector(viewDetailsProduct(_:)), for: .touchUpInside)
        cell.RemoveFromCollectionBtn.tag = indexPath.row
        cell.RemoveFromCollectionBtn.addTarget(self, action: #selector(tapRemove(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
}


//MARK:- API Call
extension CollectionsListViewController{
    func hitApiCollectionProductsList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiCollectionList(limit: "10", offset: String(self.offset),collection_id: CollectionIDStr ){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.isFetching = true
//                self.TotalResultLabel.text = "\(self.viewModel.totalcount ) results found"
                self.CollectionsTableView.reloadData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func RemoveProduct(ID : String){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.hitRemoveProduct(_id: ID ){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.offset = 0
                self.viewModel.model = []
                self.isFetching = false
                self.hitApiCollectionProductsList()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    
    
    
}
