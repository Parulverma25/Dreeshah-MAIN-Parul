//
//  ProductDetailViewController.swift
//  Dreesha User
//
//  Created by promatics on 3/24/21.
//
import PageMenu
import UIKit

class ProductDetailViewController: UIViewController {
    var pageMenu : CAPSPageMenu?
    //MARK:- Outlets
    @IBOutlet weak var ViewForAddPageMenu: UIView!
    @IBOutlet weak var collectonViewForColors: UICollectionView!
    @IBOutlet weak var tableViewForPriceRange: UITableView!
    @IBOutlet weak var collectionViewForSizes: UICollectionView!
    @IBOutlet weak var collectionViewOfSliders: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var ProductTitleVal: UILabel!
    @IBOutlet weak var ItemSoldVal: UILabel!
    @IBOutlet weak var SarVAL: UILabel!
    @IBOutlet weak var CounterValLabel: UILabel!
    @IBOutlet weak var Description_Val: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    
    @IBOutlet weak var QuantityLabel: UILabel!
    @IBOutlet weak var QuantityHeight: NSLayoutConstraint!
    @IBOutlet weak var ColorHeight: NSLayoutConstraint!
    
    @IBOutlet weak var SizeLabel: UILabel!
    @IBOutlet weak var ColorLabel: UILabel!
    @IBOutlet weak var SizeHeight: NSLayoutConstraint!
    
    @IBOutlet weak var PriceRangeLabel: UILabel!
    
    
    //MARK: HeightConstraints
    
    @IBOutlet weak var PriceRangeTop: NSLayoutConstraint!
    
    @IBOutlet weak var QuantityTp: NSLayoutConstraint!
    
    @IBOutlet weak var QuantityBottom: NSLayoutConstraint!
    
    @IBOutlet weak var SizeTop: NSLayoutConstraint!
    
    @IBOutlet weak var ShippingTop: NSLayoutConstraint!
    
    //MARK: Variables
    var viewModel = ProductsDetailViewModel()
    var counterNumbers : Int = 1
    var ProductIdStr : String = ""
    var Professional_IDStr : String = ""
    var QuantityValStr : Int = 0
    var iconClick = true
    var selectedIndex = 1212
    var selectedIndexColor = 1212
    var sizeval = ""
    var colorname = ""
    var colorval = ""
    var Colorbool = false
    var sizebool = false
    var colorcode = ""
    var colorsArray = [String]()
    var sliderImages = [String]()

    //MARK: View DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackWithTitle(titleVal: "Product Detail")
        pageMenuSetUp()
        
        CounterValLabel.text = "\(counterNumbers)"
        tabBarController?.tabBar.isHidden=true
//        let angle = CGFloat.pi/2
//            pageControl.transform = CGAffineTransform(rotationAngle: angle)
        pageControl.currentPage = 0
        pageControl?.numberOfPages = 3
        
       }
    
    //MARK: View Will APPEAR
    override func viewWillAppear(_ animated: Bool) {
        hitApiProductsDetailsList()
    }
    
    //MARK:- Functions
    @IBAction func ButtonMinus(_ sender: Any) {
        if counterNumbers > 0 {
            self.counterNumbers -= 1
            self.CounterValLabel.text = String(self.counterNumbers)
        }
    }
    
    @IBAction func ButtonPlusAct(_ sender: Any) {
        self.counterNumbers += 1
        self.CounterValLabel.text = String(self.counterNumbers)
    }
    
    @IBAction func BuyNoewBtnACt(_ sender: Any) {
        QuantityValStr = Int(CounterValLabel.text ?? "") ?? 0
        
        if QuantityValStr == 0{
            self.view.makeToast("Please Select Quantity")
        }else if colorval == "" && Colorbool == false {
            self.view.makeToast("Choose Color First" , position: .center)}
        else if sizeval == "" && sizebool == false {
            self.view.makeToast("Choose Size First" , position: .center)
    }else{
            AddtoCart()
        }
}
    
    
    @IBAction func ColorBtnACt(_ sender: UIButton) {
        
    }
    
    func pageMenuSetUp(){
        var controllerArray : [UIViewController] = []
        let vc = storyboard?.instantiateViewController(identifier: "SummaryProductDetailViewController") as! SummaryProductDetailViewController
        let vc1 = storyboard?.instantiateViewController(identifier: "RatingReviewViewController") as! RatingReviewViewController
        let vc2 = storyboard?.instantiateViewController(identifier: "FAQofProductDetailsViewController") as! FAQofProductDetailsViewController
        vc.title = "SUMMARY"
        controllerArray.append(vc)
        vc.ProductIdStr = ProductIdStr
        
        vc1.title = "RATING & REVIEWS"
        controllerArray.append(vc1)
        
        vc2.title = "FAQ"
        controllerArray.append(vc2)
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1)
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 8, y: 8, width: self.ViewForAddPageMenu.frame.width - 10, height: self.ViewForAddPageMenu.frame.height), pageMenuOptions: parameters)
        self.ViewForAddPageMenu.addSubview((pageMenu?.view)!)
    }
}


extension ProductDetailViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectonViewForColors{
            return viewModel.getProductDetailsData()?.details?.availableColor.count ?? 0
        }else if collectionView == collectionViewForSizes {
            return viewModel.getProductDetailsData()?.details?.availableSize.count ?? 0
        }else{
        return viewModel.getProductDetailsData()?.details?.productMedia.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if collectionView == collectionViewOfSliders
        {
            let cell = collectionViewOfSliders.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SliderOfProductDetailsCollectionViewCell
            let imageUrl = URLS.productImgUrl(viewModel.model?.details?.productMedia[indexPath.row]?.name ?? "").getDescription()
            cell.ImageView.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
            sliderImages.append(imageUrl)
            pageControl.currentPage = indexPath.row
            print(indexPath.row)
                     return cell
        }else if collectionView == collectonViewForColors
        {
            let cell = collectonViewForColors.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorsOfProductDetailsCollectionViewCell
            let string = viewModel.getProductDetailsData()?.details?.availableColor[indexPath.row]?.colorCode ?? ""

            let hexValue = UInt32(String(string.suffix(6)), radix: 16)
            if UInt32(String(string.suffix(6)), radix: 16) == nil{
                cell.ColorView.backgroundColor = .black
            }else {
                cell.ColorView.backgroundColor = UIColor(hex: hexValue! , alpha: 1)
            }
            
            if selectedIndexColor == indexPath.row
            {
                cell.ColorView.layer.cornerRadius = 15
                cell.colorviewWidth.constant = 30
                cell.colorviewheight.constant = 30
                colorval = viewModel.model?.details?.availableColor[indexPath.row]?.colorName ?? ""
                colorcode = viewModel.model?.details?.availableColor[indexPath.row]?.colorCode ?? ""
                print(colorval)
            }
            else
            {
                cell.ColorView.layer.cornerRadius = 10
                cell.colorviewWidth.constant = 20
                cell.colorviewheight.constant = 20
                
                
            }

            return cell
        }
        else
        {
            let cell = collectionViewForSizes.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SizeOfProductDetailCollectionViewCell
            cell.SizeLabelVal.text = "\(viewModel.model?.details?.availableSize[indexPath.row]?.size ?? "") "
            if selectedIndex == indexPath.row
            {
                cell.sizeView.backgroundColor = #colorLiteral(red: 0.04291177541, green: 0.298066318, blue: 0.5371850729, alpha: 1)
                
                sizeval = viewModel.model?.details?.availableSize[indexPath.row]?.size ?? ""
                print(sizeval)
            }
            else
            {
                cell.sizeView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
                     return cell
        }
            
        }
    
 
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.collectionView.frame.size.width/2 - 20, height: self.collectionView.frame.size.width/2 + 30)
        if collectionView == collectionViewOfSliders
        {
            return CGSize(width: self.collectionViewOfSliders.frame.size.width, height: self.collectionViewOfSliders.frame.size.height)
        }else if collectionView == collectonViewForColors
        {
            if selectedIndexColor == indexPath.row
            {
                return CGSize(width: 40 , height: 40 )}
            else{
                return CGSize(width: 30 , height: 30 )
            }
        }else
        {
            return CGSize(width: 30, height: 40)
        }
        }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        switch collectionView {
        case collectonViewForColors:
            selectedIndexColor = indexPath.row
            
            self.collectonViewForColors.reloadData()
        case collectionViewForSizes:
            selectedIndex = indexPath.row
            
            self.collectionViewForSizes.reloadData()
        case collectionViewOfSliders:
            let vc = self.storyboard?.instantiateViewController(identifier: "ImagePreviewViewController") as! ImagePreviewViewController
            
       
            
            vc.sliderImages.append(contentsOf: sliderImages)
            vc.startIndex = indexPath.row
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
            
        default:
            print(collectionView)
        }
    
    }
    
    
    
}


extension ProductDetailViewController : UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let pageWidth = self.collectionViewOfSliders.frame.size.width
        pageControl.currentPage = Int(self.collectionViewOfSliders.contentOffset.x / pageWidth)
    }
}




//MARK:- TableView for Price Range
extension ProductDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model?.details?.quantity.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewForPriceRange.dequeueReusableCell(withIdentifier: "cell") as! PriceRangeOfProductDetailsTableViewControllerCell
        cell.QuantityVal.text = "\(viewModel.model?.details?.quantity[indexPath.row]?.branchQuantity ?? 0) Pcs"
        cell.PriceSarVal.text = "AED \( (viewModel.model?.details?.quantity[indexPath.row]?.branchQuantity ?? 0) * (viewModel.getProductDetailsData()?.details?.pricing?.costPerItem ?? 0 )) "
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    
    
}

//MARK:- API Call
extension ProductDetailViewController{
    func hitApiProductsDetailsList(){

        Indicator.shared.showProgressView(self.parent?.view ?? self.view)

        viewModel.apiProductDetails(Product_id: ProductIdStr ){(isSuccess , message) in
            
            if isSuccess{
                self.ProductTitleVal.text = self.viewModel.model?.details?.productTitle ?? ""
                self.ItemSoldVal.text = "Items sold: 0"
                self.SarVAL.text = " AED \(self.viewModel.model?.details?.pricing?.price ?? 0  )"
                self.Description_Val.text = (self.viewModel.model?.details?.productDescription ?? "").html2String
                self.colorsArray = self.viewModel.model?.details?.availableColor.map({$0?.colorName ?? ""}) ?? []
                
                self.collectionViewOfSliders.reloadData()
                self.tableViewForPriceRange.reloadData()
                self.collectionViewForSizes.reloadData()
                self.collectonViewForColors.reloadData()
                
                
                
                let colorArr = self.viewModel.model?.details?.availableColor.map({$0?.colorName ?? ""})
                if colorArr?.count == 0{
                    self.ColorHeight.constant = 0
                    self.Colorbool = true
                    self.ColorLabel.isHidden = true
                }else{
                    self.ColorHeight.constant = 50
                    self.Colorbool = false
                    self.ColorLabel.isHidden = false
                }
                
                let SizeArr = self.viewModel.model?.details?.availableSize.map({$0?.size ?? ""})
                if SizeArr?.count == 0{
                    self.SizeHeight.constant = 0
                    self.SizeLabel.isHidden = true
                    self.sizebool = true
                    self.SizeTop.constant = 0
                    self.ShippingTop.constant = 0
                }else{
                    self.SizeHeight.constant = 40
                    self.SizeLabel.isHidden = false
                    self.sizebool = false
                    self.SizeTop.constant =  10
                    self.ShippingTop.constant = 25
                }
                
                let QuantArr = self.viewModel.model?.details?.quantity.map({$0?.branchQuantity ?? 0})
                if QuantArr?.count == 0{
                    self.QuantityHeight.constant = 0
                    self.SizeLabel.isHidden = true
                    self.PriceLabel.isHidden = true
                    self.QuantityLabel.isHidden = true
                    self.PriceRangeLabel.isHidden = true
                    
                    self.PriceRangeTop.constant = 0
                    self.QuantityTp.constant = 0
                    self.QuantityBottom.constant = 0
                    
                    
                    
                }else{
                    self.QuantityHeight.constant = 120
                    self.updateTableHeight(tableName: self.tableViewForPriceRange, tableHeight: self.QuantityHeight)
                    self.SizeLabel.isHidden = false
                    self.PriceLabel.isHidden = false
                    self.QuantityLabel.isHidden = false
                    self.PriceRangeLabel.isHidden = false
                    self.PriceRangeTop.constant = 10
                    self.QuantityTp.constant = 10
                    self.QuantityBottom.constant = 10
                }
                
                
                
                
                
                
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func AddtoCart(){
        
        viewModel.hitAddtoCart(User_id: AppUser.shared.user_id, Professional_id: Professional_IDStr, Product_id: ProductIdStr, Quantity_Id: QuantityValStr ,ColorName: colorval ,color_code: colorcode,size_unit: "cm",size: Int(sizeval) ?? 0){ (isSuccess, message) in
            
            if isSuccess{
                self.showAlertWithAction(Title: "Dreeshah", Message: message, ButtonTitle: "OK") {
                    let vc = self.storyboard?.instantiateViewController(identifier: "CartNewViewController") as!  CartNewViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
               
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
}

