//
//  OrderManageentDetailsViewController.swift
//  Dreeshah
//
//  Created by Promatics on 18/03/21.
//

import UIKit

class OrderManageentDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout , UIScrollViewDelegate{
    
    

    @IBOutlet weak var ImageCollectionView: UICollectionView!
    @IBOutlet weak var OrderTitleLbl: UILabel!
    @IBOutlet weak var PageControl: UIPageControl!
    
 
    @IBOutlet weak var AedLabel: UILabel!
    @IBOutlet weak var ColorCodeView: SetView!
    
    @IBOutlet weak var lengthLbl: UILabel!
    
    @IBOutlet weak var CustomerLbl: UILabel!
    
    @IBOutlet weak var AdressLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    //MARK: Variables
    
    var OrderIDStr = ""
    var sliderImages = [String]()

    var countval = 0
    var viewModel = OrderDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageCollectionView.dataSource = self
        ImageCollectionView.delegate = self
        ImageCollectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Order Management")
//        setdata()
        OrdersDetail(OrderID: OrderIDStr)
        PageControl.currentPage = 0
        PageControl?.numberOfPages = 4
    }
    
    func setdata(){
        OrderTitleLbl.text = viewModel.getOrderDetailsData()?.result?.productID?.productTitle ?? ""
        AedLabel.text = "AED \(viewModel.getOrderDetailsData()?.result?.productID?.pricing?.price ?? 0)"
        CustomerLbl.text = "\(viewModel.model?.result?.userID?.firstName ?? "") \(viewModel.model?.result?.userID?.lastName ?? "")"
        emailLbl.text = viewModel.getOrderDetailsData()?.result?.userID?.email ?? ""
        AdressLbl.text = "\(viewModel.model?.result?.userID?.state ?? "") \(viewModel.model?.result?.userID?.country ?? "")"
        let string = viewModel.getOrderDetailsData()?.result?.colorCode ?? ""
        let hexValue = UInt32(String(string.suffix(6)), radix: 16)
        if UInt32(String(string.suffix(6)), radix: 16) == nil{
            ColorCodeView.backgroundColor = .black
        }else {
            ColorCodeView.backgroundColor = UIColor(hex: hexValue! , alpha: 1)
        }
        lengthLbl.text = "\(viewModel.getOrderDetailsData()?.result?.size ?? 0)"
        ImageCollectionView.reloadData()

    }
    
    
    
    
    
    
    
    
}


extension OrderManageentDetailsViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getOrderDetailsData()?.result?.productID?.productMedia?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImagesCollectionViewCell
        let url = URLS.productImgUrl(viewModel.getOrderDetailsData()?.result?.productID?.productMedia?[indexPath.row].name ?? "").getDescription()
        cell.ImageView.sd_setImage(with: URL(string: url ),placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
        sliderImages.append(url)
            PageControl.currentPage = indexPath.row
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let pageWidth = self.ImageCollectionView.frame.size.width
        PageControl.currentPage = Int(self.ImageCollectionView.contentOffset.x / pageWidth)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.collectionView.frame.size.width/2 - 20, height: self.collectionView.frame.size.width/2 + 30)
     
            return CGSize(width: self.ImageCollectionView.frame.size.width, height: self.ImageCollectionView.frame.size.height)
        
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePreviewViewController") as! ImagePreviewViewController
        
        vc.sliderImages.append(contentsOf: sliderImages)
        vc.startIndex = indexPath.row
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    
}
    
//MARK: API Call
extension OrderManageentDetailsViewController{
func OrdersDetail(OrderID : String){
    Indicator.shared.showProgressView(self.parent?.view ?? self.view)
    viewModel.apiOrdersDetails(Order_id: OrderID) { (isSuccess, message) in
        if isSuccess{
            self.setdata()
        }else{
            self.view.makeToast(message , position : .center)
        }
    }
    
    
}
}
