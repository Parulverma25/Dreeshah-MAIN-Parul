//
//  OrderDtlsViewController.swift
//  Dreesha User
//
//  Created by Promatics on 17/03/21.
//

import UIKit

class OrderDtlsViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var OrdersIDVAL: UILabel!
    @IBOutlet weak var OrderImageview: UIImageView!
    @IBOutlet weak var OrderTitleVal: UILabel!
    @IBOutlet weak var SAR_Val: UILabel!
    @IBOutlet weak var ProcessLabelVal: UILabel!
    @IBOutlet weak var Date_Val: UILabel!
    
    @IBOutlet weak var SubTotalVal: UILabel!
    @IBOutlet weak var ShippingVal: UILabel!
    @IBOutlet weak var TaxVal: UILabel!
    @IBOutlet weak var TotalVal: UILabel!
    
    @IBOutlet weak var StoreNameVal: UILabel!
    @IBOutlet weak var StoreAddressVal: UILabel!
    
    @IBOutlet weak var PickupStoreName: UILabel!
    @IBOutlet weak var PickUpStoreAddress: UILabel!
    
    @IBOutlet weak var PaymentInfoVal: UILabel!
    
    
    @IBOutlet weak var FstBtn: UIButton!
    
    @IBOutlet weak var ScndBtn: UIButton!
    @IBOutlet weak var ThrdBtn: UIButton!
    @IBOutlet weak var FourBtn: UIButton!
    @IBOutlet weak var FifthBtn: UIButton!
    @IBOutlet weak var fifthView: UILabel!
    
    
    
    //MARK: CollapseViewOutlets
    @IBOutlet weak var FrstView: UIView!
    @IBOutlet weak var ScndView: UIView!
    @IBOutlet weak var ThirdView: UIView!
    @IBOutlet weak var FrthView: UIView!
    
    
    
    //MARK: CollapseHeightOutlets
    @IBOutlet weak var FirstHGt: NSLayoutConstraint!
    
    @IBOutlet weak var ScndHgt: NSLayoutConstraint!
    
    @IBOutlet weak var ThrdHgt: NSLayoutConstraint!
    @IBOutlet weak var FrthHgt: NSLayoutConstraint!
    @IBOutlet weak var FifthHgt: NSLayoutConstraint!
    
    
    //MARK:VARIABLES
        var viewModel = OrderDetailsViewModel()
        var OrderIdStrVal = ""
        var iconClick = true
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        OrdersDetail(OrderID: OrderIdStrVal)
    }
    
    //MARK: ACtions
    
    @IBAction func FirstCollapseBtn(_ sender: UIButton) {
        
        if(iconClick == true) {
            FirstHGt.constant = 160
            FstBtn.setImage(UIImage(named: "Up Arrow") ,for: .normal)
            FrstView.isHidden = false
        } else {
            FirstHGt.constant = 40
            FstBtn.setImage(UIImage(named: "Down Arrow"), for: .normal)
            FrstView.isHidden = true
        }
        iconClick = !iconClick
    }
    
    @IBAction func SecondCollapseBtn(_ sender: UIButton) {
        if(iconClick == true) {
            ScndHgt.constant = 175
            ScndBtn.setImage(UIImage(named: "Up Arrow") ,for: .normal)
            ScndView.isHidden = false
        } else {
            ScndHgt.constant = 40
            ScndBtn.setImage(UIImage(named: "Down Arrow"), for: .normal)
            ScndView.isHidden = true
        }
        iconClick = !iconClick
    }
    
    @IBAction func ThirdCollapseBtn(_ sender: UIButton) {
        if(iconClick == true) {
            ThrdHgt.constant = 125
            ThrdBtn.setImage(UIImage(named: "Up Arrow") ,for: .normal)
            ThirdView.isHidden = false
        } else {
            ThrdHgt.constant = 40
            ThrdBtn.setImage(UIImage(named: "Down Arrow"), for: .normal)
            ThirdView.isHidden = true
        }
        iconClick = !iconClick
    }
    
    @IBAction func FourthCollapseBtn(_ sender: UIButton) {
        if(iconClick == true) {
            FrthHgt.constant = 140
            FourBtn.setImage(UIImage(named: "Up Arrow") ,for: .normal)
            FrthView.isHidden = false
        } else {
            FrthHgt.constant = 40
            FourBtn.setImage(UIImage(named: "Down Arrow"), for: .normal)
            FrthView.isHidden = true
        }
        iconClick = !iconClick
    }
    @IBAction func FifthCollapseBtn(_ sender: UIButton) {
        if(iconClick == true) {
            FifthHgt.constant = 125
            FifthBtn.setImage(UIImage(named: "Up Arrow") ,for: .normal)
            fifthView.isHidden = false
        } else {
            FifthHgt.constant = 40
            FifthBtn.setImage(UIImage(named: "Down Arrow"), for: .normal)
            fifthView.isHidden = true
        }
        iconClick = !iconClick
    }
    
    
    
    
    
    
    //MARK:Functions
    
    func Setdata(){
        OrdersIDVAL.text = viewModel.getOrderDetailsData()?.result?.orderID?.transactionID ?? ""
        
        let imageUrl = URLS.productImgUrl(viewModel.getOrderDetailsData()?.result?.productID?.productMedia?.first?.name ?? "").getDescription()
        OrderImageview.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
        
        OrderTitleVal.text = viewModel.getOrderDetailsData()?.result?.productID?.productTitle ?? ""
        SAR_Val.text = "AED \(viewModel.getOrderDetailsData()?.result?.productID?.pricing?.price ?? 0)"
        ProcessLabelVal.text = viewModel.getOrderDetailsData()?.result?.orderStatus ?? ""
        Date_Val.text = (viewModel.getOrderDetailsData()?.result?.productID?.createdAt ?? "").dateFormatStringToUTCString
        SubTotalVal.text = "\(viewModel.getOrderDetailsData()?.result?.productID?.pricing?.price ?? 0)"
        ShippingVal.text = "200"
        TaxVal.text = "0"
        TotalVal.text =  "\((viewModel.getOrderDetailsData()?.result?.productID?.pricing?.price ?? 0 ) + (200) + (0))"
        
        
        
    }
}

//MARK: API Call
extension OrderDtlsViewController{
func OrdersDetail(OrderID : String){
    
    Indicator.shared.showProgressView(self.parent?.view ?? self.view)
    viewModel.apiOrdersDetails(Order_id: OrderID) { (isSuccess, message) in
        if isSuccess{
            self.Setdata()
        }else{
            self.view.makeToast(message , position : .center)
        }
    }
    
    
}
}
