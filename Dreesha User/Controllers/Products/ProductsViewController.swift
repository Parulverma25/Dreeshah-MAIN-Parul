//
//  ProductsViewController.swift
//  Dreesha User
//
//  Created by Apple on 19/03/21.
//

import UIKit

class ProductsViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var collectionViewForProducts: UICollectionView!
    @IBOutlet weak var TotalResultLabel: UILabel!
    
    @IBOutlet weak var SearchTxtfld: UITextField!
    //MARK: VARAIBLES
    
    var viewModel = ProductViewModel()
    var offset = 0
    var iconClick = true
    var isFetching = false
    //MARK: View DID Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Products")
        if CurrentSession.shared.isUser {
            self.offset = 0
            self.viewModel.model = []
            self.isFetching = false
            hitApiProductsList()
        } else if CurrentSession.shared.isProfesstional {
//            hitApiProductsListPro()
            self.offset = 0
            self.viewModel.model = []
            self.isFetching = false
            hitApiProductsList()
        }
}
    
    @IBAction func clearSearchBtn(_ sender: UIButton) {
        SearchTxtfld.text = ""
    }
    
    
    
    
    @IBAction func AddtoWishlist(_ sender: UIButton) {
        
        AddtoWishlist(ProfessionalID: viewModel.getProductListData()?[sender.tag].professionalID ?? "" , Product_id: viewModel.getProductListData()?[sender.tag].id ?? "" )
        
        }
    
    
    @IBAction func tapSortPopUp(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SortByPopUpViewController") as! SortByPopUpViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.completionBlock = {
            value in
            print(value)
            self.offset = 0
            self.viewModel.model = []
            self.isFetching = false
            
            self.sortByProducts(sort: "price", sortBy: value, offset: String(self.offset))
        }
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    }




extension ProductsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getProductListData()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionViewForProducts.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductsShowCollectionViewCell
        let imageUrl = URLS.productImgUrl(viewModel.getProductListData()?[indexPath.row].productMedia?.first?.name ?? "").getDescription()
        cell.ImageView.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
        cell.TitleLable.text = (viewModel.getProductListData()?[indexPath.row].productTitle ?? "")
        cell.SarLabel.text = " AED \(viewModel.getProductListData()?[indexPath.row].pricing?.costPerItem ?? 0 ) "
        cell.AddtoWishlistBtn.tag = indexPath.row
        cell.AddtoWishlistBtn.addTarget(self, action: #selector(self.AddtoWishlist(_:)), for: UIControl.Event.touchUpInside)
        
        
        let Color = (			 viewModel.getProductListData()?[indexPath.row].isWishListProduct?.first?.status )
        if Color == nil {
            cell.AddtoWishlistBtn.setImage(UIImage(named: "Wish Off"), for: .normal)
        }else {
            cell.AddtoWishlistBtn.setImage(UIImage(named: "Wish On"), for: .normal)
        }
          return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch (indexPath.row) {
        case 0:
           let  vc1 = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
            vc1.hidesBottomBarWhenPushed = true
            vc1.ProductIdStr = viewModel.getProductListData()?[indexPath.row].id ?? ""
            vc1.Professional_IDStr = viewModel.getProductListData()?[indexPath.row].professionalID ?? ""
            navigationController?.pushViewController(vc1 , animated: true)
        default:
            let  vc1 = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
             vc1.hidesBottomBarWhenPushed = true
            vc1.ProductIdStr = viewModel.getProductListData()?[indexPath.row].id ?? ""
            vc1.Professional_IDStr = viewModel.getProductListData()?[indexPath.row].professionalID ?? ""
             navigationController?.pushViewController(vc1 , animated: true)
        }
    }
    
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isFetching{
            self.offset += 10
            hitApiProductsList()
        }
        
        
        
    }
}

//MARK:- API Call
extension ProductsViewController{
    func hitApiProductsList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiProductList(limit: "10", offset: String(self.offset)){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.isFetching = true
                self.TotalResultLabel.text = "\(self.viewModel.totalcount ) results found"
                self.collectionViewForProducts.reloadData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    
    func sortByProducts(sort : String , sortBy : String , offset : String){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.sortByProductList(limit: "10", offset: offset, sort: sort, sortBy: sortBy) {(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.isFetching = true
                self.TotalResultLabel.text = "\(self.viewModel.totalcount ) results found"
                self.collectionViewForProducts.reloadData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func AddtoWishlist(ProfessionalID: String , Product_id : String){
        viewModel.hitAddtowishlist(Professional_id: ProfessionalID , Product_id: Product_id ){ (isSuccess, message) in
            if isSuccess{
                
                self.showAlertWithAction(Title: "Dreeshah", Message: message, ButtonTitle: "OK") {
                    self.offset = 0
                    self.viewModel.model = []
                    self.isFetching = false
                    self.hitApiProductsList()
                    if message == "Removed from wishlist"{
                        
                    }
                }
               
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    
    // --------------------------------------------------------------------------------- Below Professional Side Work
    
    func hitApiProductsListPro() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiProductListProfesstional { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess {
                print(self.viewModel.totalcount)
                self.collectionViewForProducts.reloadData()
            } else {
                self.view.makeToast(message , position : .center)
            }
        }
    }
}
