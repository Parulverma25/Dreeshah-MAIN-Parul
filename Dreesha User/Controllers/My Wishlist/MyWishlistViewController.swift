//
//  MyWishlistViewController.swift
//  Dreesha User
//
//  Created by Promatics on 11/03/21.
//

import UIKit

class MyWishlistViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    //MARK: Outlets
    @IBOutlet weak var Wishtableview: UITableView!

//        MARK: Variables
    var viewModel = MyWishlistViewModel()
    var removemodel = ProductViewModel()
    var arrlbl1=["Macro Steel Pipes","Whitehill iron rods","Concrete Bricks","Designer Tiles"]

    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden=true
        Wishtableview.delegate=self
        Wishtableview.dataSource=self
        Wishtableview.reloadData()
        Wishtableview.tableFooterView = UIView()
        self.hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "My Wishlist")

        hitApiWishList()
    }
    
    @IBAction func RemoveWishItem(_ sender: UIButton) {
        remove_wishitem(Pro_Id: viewModel.getWishlistListData()?.data[sender.tag]?.professionalID ?? "", ProductId_: viewModel.getWishlistListData()?.data[sender.tag]?.productID?.productIDID ?? "")
        
    }
    
    
    
    
}
//Mark TableView Delegates
extension MyWishlistViewController{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel.getWishlistListData()?.data.count ?? 0) == 0 {
            tableCollectionErrors(view: Wishtableview, text: "No Records!")
        }else{
            tableCollectionErrors(view: Wishtableview, text: " ")
        }
        return viewModel.getWishlistListData()?.data.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyWishlistTableViewCell
        cell.ProductTitle.text = viewModel.getWishlistListData()?.data[indexPath.row]?.productID?.productTitle ?? ""
        cell.SarVal.text = " AED \(viewModel.getWishlistListData()?.data[indexPath.row]?.productID?.pricing?.price ?? 0 )"
        cell.YearVal.text = viewModel.getWishlistListData()?.data[indexPath.row]?.createdAt ?? ""
        let imageUrl = URLS.productImgUrl(viewModel.getWishlistListData()?.data[indexPath.row]?.productID?.productMedia.first??.name ?? "" ).getDescription()
        cell.Wishlistimgview?.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
        cell.RemoveBtn.tag = indexPath.row
        cell.RemoveBtn.addTarget(self, action: #selector(RemoveWishItem(_:)), for: .touchUpInside)
        

        return cell
    }

}


//MARK:- API CALL
extension MyWishlistViewController{
    func hitApiWishList(){

        Indicator.shared.showProgressView(self.parent?.view ?? self.view)

        viewModel.apiWishList(UserId: AppUser.shared.user_id){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.Wishtableview.reloadData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func  remove_wishitem(Pro_Id : String,ProductId_ : String){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        removemodel.hitAddtowishlist(Professional_id: Pro_Id , Product_id: ProductId_) { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.showAlertWithAction(Title: "Dreeshah", Message: message, ButtonTitle: "OK") {
                    
                    self.hitApiWishList()
                    if message == "Removed from wishlist"{
                        
                    }
                }
               
            }else{
                self.view.makeToast(message , position : .center)
                
            }
        }
    }
    
    
}
