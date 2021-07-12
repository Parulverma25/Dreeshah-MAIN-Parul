//
//  ProfProductDetailsViewController.swift
//  Dreeshah
//
//  Created by Promatics on 19/03/21.
//

import UIKit

class ProfProductDetailsViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource {
    
    
  //Mark Outlets
    @IBOutlet weak var QuanityTableView: UITableView!
    @IBOutlet weak var collectionViewOfSliders : UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var productCostSmall: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var productCost: UILabel!
    @IBOutlet weak var costPerItem: UILabel!
    @IBOutlet weak var harmonisedCode: UILabel!
    @IBOutlet weak var descriptionssss: UILabel!
    @IBOutlet weak var stockKeepingUnit: UILabel!
    @IBOutlet weak var visibleTo: UILabel!
    
    @IBOutlet weak var inventry: UILabel!
    @IBOutlet weak var countryRegion: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var barCode: UILabel!
    @IBOutlet weak var profit: UILabel!
    @IBOutlet weak var margin: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var variant: UILabel!
    //MArk Variables
    var Arr1 = ["Mumbai" ,"Delhi","Punjab"]
    var Arr2 = ["12" ,"20" ,"100"]
    var productID = ""
    var viewModel = ProductDetailARViewModel()
    //MArk View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        QuanityTableView.delegate=self
        QuanityTableView.dataSource=self
        QuanityTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Product Detail")
        navigationController?.navigationBar.tintColor = .clear
        hitProductDetails()
       
    }
}
//MARK:- tableView Delegate
extension ProfProductDetailsViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.viewModel.model?.details?.quantity.count ?? 0) == 0
        {
            return 0
        }else
        {
            return (self.viewModel.model?.details?.quantity.count)!
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProfProductTableViewCell
        cell.Label1.text = (self.viewModel.model?.details?.quantity[indexPath.row]?.branchName)!
        cell.Label2.text = "\((self.viewModel.model?.details?.quantity[indexPath.row]?.branchQuantity)!)"
        return cell
    }
    
}
//MARK:- CollectionView Delegate
extension ProfProductDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("DFGHJKKLXJKHZKHKCBHJSBCJHGFGJFSG{{{{}{}{{}{}{{}{}{}\((viewModel.model?.details?.productMedia.count ?? 0)!)")
        return (viewModel.model?.details?.productMedia.count ?? 0)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            let cell = collectionViewOfSliders.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfProductCollectionViewCell
        let imageUrl = URLS.productImgUrl((viewModel.model?.details?.productMedia[indexPath.row]?.name ?? "")).getDescription()
        cell.images.sd_setImage(with: URL(string : imageUrl), placeholderImage: #imageLiteral(resourceName: "Placeholding"))
           
               return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.collectionView.frame.size.width/2 - 20, height: self.collectionView.frame.size.width/2 + 30)
       
            return CGSize(width: self.collectionViewOfSliders.frame.size.width, height: self.collectionViewOfSliders.frame.size.height)
    
}
}

//MARK:- API CALL
extension ProfProductDetailsViewController
{
   
    func hitProductDetails(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.hitApiProductDetails(productID: self.productID, completion: { [self](isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.productName.text = (self.viewModel.model?.details?.productTitle)!
                self.productCost.text = "AED \((self.viewModel.model?.details?.pricing?.price)!)"
                self.productCostSmall.text = "AED \((self.viewModel.model?.details?.pricing?.comprice)!)"
                self.costPerItem.text = "AED \((self.viewModel.model?.details?.pricing?.costPerItem)!)"
                self.margin.text = "AED \((self.viewModel.model?.details?.pricing?.margin)!)"
                self.profit.text = "AED \((self.viewModel.model?.details?.pricing?.profit)!)"
                self.inventry.text = (self.viewModel.model?.details?.inventory?.inventory.inventoryName)!
                self.stockKeepingUnit.text = (self.viewModel.model?.details?.inventory?.sku)!
                self.barCode.text = (self.viewModel.model?.details?.inventory?.barcode)!
                self.weight.text = (self.viewModel.model?.details?.weightDetails?.weight)!
                
                pageControl?.numberOfPages = (viewModel.model?.details?.productMedia.count)!
                
                self.countryRegion.text = (self.viewModel.model?.details?.customsInformation?.region)!
                self.harmonisedCode.text = (self.viewModel.model?.details?.customsInformation?.code)!
                
                self.variant.text = (self.viewModel.model?.details?.variant)!
                if (self.viewModel.model?.details?.visibleToProfessinal)!{
                    self.visibleTo.text = "Professional"

                }
                self.descriptionssss.text = (self.viewModel.model?.details?.productDescription)
                self.collectionViewOfSliders.reloadData()
                self.QuanityTableView.reloadData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        })
    }
    
}
//MARK:- Scrollview Delegate
extension ProfProductDetailsViewController : UIScrollViewDelegate{
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
            let pageWidth = self.collectionViewOfSliders.frame.size.width
            pageControl.currentPage = Int(self.collectionViewOfSliders.contentOffset.x / pageWidth)
        }
    }
