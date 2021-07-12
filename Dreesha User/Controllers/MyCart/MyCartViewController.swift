//////
//////  MyCartViewController.swift
//////  Dreesha User
//////
//////  Created by Apple on 19/03/21.
////
////
////import UIKit
////
////class MyCartViewController: UIViewController {
////    //MARK: Outlets
////    @IBOutlet weak var Addressview: SetView!
////    @IBOutlet weak var tableViewForMyCart: UITableView!
////    @IBOutlet weak var TblViewHTCons: NSLayoutConstraint!
////    
////    @IBOutlet weak var CheckOutBtn: SetButton!
////    @IBOutlet weak var DisLbl: UILabel!
////    @IBOutlet weak var TaxLbl: UILabel!
////    @IBOutlet weak var SubTotalValue: UILabel!
////    @IBOutlet weak var DiscountVal: UILabel!
////    @IBOutlet weak var TotalValue: UILabel!
////    @IBOutlet weak var ShippingChargeVal: UILabel!
////    @IBOutlet weak var TaxValue: UILabel!
////    @IBOutlet weak var HideView: UIView!
////    
////    //----------------------------------------------------------------------
////    @IBOutlet weak var CustomerNameLbl: UILabel!
////    @IBOutlet weak var AddressLabel: UILabel!
////    @IBOutlet weak var AdressTypeLbl: UILabel!
////    
////    
////    //    MARK: Variables
////    var viewModel = MyCartViewModel()
////    var WishviewModel = ProductViewModel()
////    var counterNumbers : Int = 0
////    var cartItemCount = [Int]()
////    var CartItemPrices = [Int]()
////    var arrProductIds = [String]()
////    var arrProductColorName = [String]()
////    var arrProductSize = [Int]()
////    var arrProductColorCode = [String]()
////    
////    var pricearr = [Int]()
////    
////    
////    var arrAllQuantity = [Int]()
////    var TotalValueS = 0
////    
////    var OrderItems = [[String : String]]()
////    
////    var ProductID = [String]()
////    var ColorID = [String]()
////    var SizeID = [String]()
////    var QuantityArr = [String]()
////    var isFetching = false
////    //MARK: View Did Load
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        self.hideKeyboardWhenTappedAround()
////        setFuncData()
////        // Do any additional setup after loading the view.
////    }
////    
////    //MARK: View Will Appear
////    override func viewWillAppear(_ animated: Bool) {
////        setBackWithTitle(titleVal: "My Cart")
////        hitApiMyCartList()
////        
////        
////        }
////    
////    
////    //MARK: Actions
////    
//// 
////    @IBAction func ChangeAddressBtnAct(_ sender: UIButton) {
////        let vc = storyboard?.instantiateViewController(identifier: "AddressViewController") as! AddressViewController
////        vc.hidesBottomBarWhenPushed = true
////        navigationController?.pushViewController(vc, animated: true)
////    }
////    
////    
//////    @IBAction func ButtonMinus(_ sender: UIButton) {
//////        let newquantity = cartItemCount[sender.tag]
//////        var counter = newquantity - 1
//////        cartItemCount.remove(at: sender.tag)
//////        if counter <= 0 {
//////            counter = 0
//////        }
//////        cartItemCount.insert(counter, at: sender.tag)
//////        print(cartItemCount)
//////        tableViewForMyCart.reloadData()
//////    }
////    
//////    @IBAction func ButtonPlusAct(_ sender: UIButton) {
//////
//////        let newquantity = cartItemCount[sender.tag]
//////        let counter = newquantity+1
//////        cartItemCount.remove(at: sender.tag)
//////        cartItemCount.insert(counter, at: sender.tag)
//////        print(cartItemCount)
//////        tableViewForMyCart.reloadData()
//////
//////    }
////    
//////    @IBAction func AddtoWishlist(_ sender: UIButton) {
////        
//////        AddtoWishlist(ProfessionalID: viewModel.model?.data?.first?.professionalData?.productData[sender.tag].professionalID ?? "" , Product_id: viewModel.model?.data?[sender.tag].products ?? <#default value#> ?? 0 )
//////
//////        }
////    
//////    @IBAction func RemoveFromCartBtnAct(_ sender: UIButton) {
//////
//////        removeFromCartList(ProfessionalID: viewModel.model[sender.tag].professionalData?.productData?[sender.tag].professionalID ?? "" , Product_id: viewModel.model[sender.tag].products?.first ?? "", CartID: viewModel.model[sender.tag]. ?? "" , Quantity: "0" )
//////        }
//////
//////
////    
//////    @IBAction func CheckOutBtn(_ sender: Any) {
//////
//////
//////
//////        if AddressLabel.text == "Please Add Address First"{
//////            self.view.makeToast("Add Address First!" , position: .center)
//////        }else{
//////            for i in 0...arrProductIds.count-1{
//////
//////                let OrderItemsDict: Dictionary = ["product_id": "\(arrProductIds[i])","product_quantity": "\(cartItemCount[i])","color_name": "\(arrProductColorName[i])","color_code": "\(arrProductColorCode[i])","size": "\(arrProductSize[i])","size_unit": "cm"]
//////                OrderItems.append(OrderItemsDict)
//////
//////            }
//////            print(OrderItems)
//////
////////       Checkout()
//////        }
//////    }
////    
////    
////    func convertIntoJSONString(arrayObject: [Any]) -> String? {
////            do {
////                let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
////                if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
////                    return jsonString as String
////                }
////            } catch let error as NSError {
////                print("Array convertIntoJSON - \(error.description)")
////            }
////            return nil
////        }
////    
////    
////   func setFuncData(){
////    SubTotalValue.text = "0"
////    ShippingChargeVal.text = "0"
////    TaxValue.text = "0"
////    DiscountVal.text = "0"
////    TotalValue.text = "0"
////    }
////    
////
////    
////    //MARK: Set AddressData
////    func SetAddressData(){
////        
////        
////        if viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.firstName == nil{
////            CustomerNameLbl.text = ""
////            AdressTypeLbl.text = "Address"
////            AddressLabel.text = "Please Add Address First"
////            AddressLabel.textAlignment = .center
////        }else{
////            
////            CustomerNameLbl.text = "\(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.firstName ?? "") \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.lastName ?? "")"
////        AddressLabel.textAlignment = .left
////            AddressLabel.text = " \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.addressLine1 ?? "") \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.addressLine2 ?? "") \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.city ?? "") \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.state ?? "") \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.country ?? "") \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.zipCode ?? "")"
////            
////        AdressTypeLbl.text = "\(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.addressType ?? "")"
////            }
////        }
////}
////
//////MARK: TAbleView DElegates
////extension MyCartViewController : UITableViewDelegate, UITableViewDataSource {
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        if ( viewModel.model.first?.professionalData?.productData?.count == 0){
////            self.HideView.isHidden = false
////            self.CheckOutBtn.isHidden = true
////            self.Addressview.isHidden = true
////            
////        }else{
////            self.HideView.isHidden = true
////            self.CheckOutBtn.isHidden = false
////            self.Addressview.isHidden = false
////        }
////        print(viewModel.model.first?.professionalData?.productData?.count)
////        
////        return viewModel.model.first?.professionalData?.productData?.count ?? 0
////       
////        
////    }
////    
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableViewForMyCart.dequeueReusableCell(withIdentifier: "cell") as! MyCartTableViewCell
////        cell.TitleLblCart.text = viewModel.model.first?.professionalData?.productData?[indexPath.row].productTitle ?? ""
////        cell.SAR_LblCart.text =  " AED \(viewModel.model.first?.professionalData?.productData?[indexPath.row].pricing?.price ?? 0 )"
//////        cell.CountLblCart.text = String(cartItemCount[indexPath.row])
////        let imageUrl = URLS.productImgUrl(viewModel.model.first?.professionalData?.productData?[indexPath.row].productMedia?.first?.name ?? "").getDescription()
////        cell.ImageViewCart?.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
////        
//////        cell.MinusBtn.tag = indexPath.row
//////        cell.MinusBtn.addTarget(self, action: #selector(self.ButtonMinus(_:)), for: UIControl.Event.touchUpInside)
//////        cell.PlusBtn.tag = indexPath.row
//////        cell.PlusBtn.addTarget(self, action: #selector(self.ButtonPlusAct(_:)), for: UIControl.Event.touchUpInside)
////
//////        cell.MovetoWishListBtn.tag = indexPath.row
//////        cell.MovetoWishListBtn.addTarget(self, action: #selector(self.AddtoWishlist(_:)) , for: .touchUpInside)
//////        let Status = ( viewModel.model?.first?.professionalData. isWishlistItems?.first?.status )
//////        if Status == nil {
//////            cell.MovetoWishListBtn.isHidden = false
//////        }else {
//////            cell.MovetoWishListBtn.isHidden = true
//////        }
////        
////        
//////        cell.RemoveItemBtn.tag = indexPath.row
//////        cell.RemoveItemBtn.addTarget(self, action: #selector(self.RemoveFromCartBtnAct(_:)) , for: .touchUpInside)
////        
//      
//            let c = zip(pricearr, cartItemCount).map { $0 * $1 }
//            print(c)
//            let total = c.reduce(0, +)
//
//        
//        
//        SubTotalValue.text =  "AED \(total)"
//        ShippingChargeVal.text = "AED \( viewModel.Shipping_Charge)"
//        TaxLbl.text = "Tax (\(viewModel.Tax_Percentage)%)"
//        let totaltax = (total * ((viewModel.Tax_Percentage)/100))
//        TaxValue.text = "AED \( totaltax)"
//        DiscountVal.text = "0"
//        DisLbl.text = "Discount (0%)"
//        TotalValueS  = (CartItemPrices.reduce(0, +)) + (totaltax) + (viewModel.Shipping_Charge)
//        TotalValue.text = "AED \(TotalValueS)"
//        
//        
////            
////        return cell
////    }
////    
////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        
////      
////    }
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return 140
////    }
////
////    
////}
////
//////MARK:- API CALL
////extension MyCartViewController{
////    func hitApiMyCartList(){
////
////        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
////
////        viewModel.apiCartList(){(isSuccess , message) in
////            Indicator.shared.hideProgressView()
////            if isSuccess{
////                self.isFetching = true
////                self.updateTableHeight(tableName: self.tableViewForMyCart, tableHeight: self.TblViewHTCons)
////                self.tableViewForMyCart.reloadData()
////            }else{
////                   
////                    self.view.makeToast(message , position : .center)
////                }
////                
////            }
////        }
////    
////    func AddtoWishlist(ProfessionalID: String , Product_id : String){
////        WishviewModel.hitAddtowishlist(Professional_id: ProfessionalID , Product_id: Product_id ){ (isSuccess, message) in
////            if isSuccess{
////                self.showAlertWithAction(Title: "Dreeshah", Message: message, ButtonTitle: "OK") {
////                    self.hitApiMyCartList()
////                    if message == "Removed from wishlist"{
////                        
////                    }
////                }
////               
////            }else{
////                self.view.makeToast(message , position : .center)
////            }
////        }
////    }
////    
////    func removeFromCartList(ProfessionalID: String , Product_id : String , CartID : String , Quantity : String){
////        
////        viewModel.hitRemoveFromCart(Professional_id: ProfessionalID, Product_id: Product_id, Cart_id: CartID, Quantity: Quantity) { (isSuccess, message) in
////            if isSuccess{
////                self.showAlertWithAction(Title: "Dreeshah", Message: "Item Removed!", ButtonTitle: "OK") {
////                    self.hitApiMyCartList()
////            }
////            }else{
////                self.view.makeToast(message , position : .center)
////            }
////        }
////    }
////    
////    func GetDefaultAddrs(){
////        
////        viewModel.hitGetDefaultAddress { (isSuccess, message) in
////            if isSuccess{
////                self.SetAddressData()
////            }else{
////                self.view.makeToast(message , position : .center)
////            }
////        }
////    }
////    
//////    func Checkout(){
//////
//////        viewModel.hitCheckOut(User_id: viewModel.model?.data?.userID ?? "", Amount: TotalValueS, OrderItems: convertIntoJSONString(arrayObject:OrderItems)! , FirstName: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.firstName ?? "", LastName: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.lastName ?? "", AddressLine1: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.addressLine1 ?? "", AddressLine2: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.addressLine2 ?? "", City: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.city ?? "", State: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.state ?? "", ZipCode: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.zipCode ?? "", PhoneNo: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.phoneNumber ?? "", Landmark: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.landmark ?? "", address_type: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.addressType ?? "", country_ph_code: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.countryPhCode ?? "", country: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.country ?? "") { (isSuccess, message) in
//////            if isSuccess{
//////                let vc = self.storyboard?.instantiateViewController(identifier: "PaymentMethodViewController") as! PaymentMethodViewController
//////                self.navigationController?.pushViewController(vc, animated: true)
//////
//////            }else{
//////
//////                self.view.makeToast(message , position : .center)
//////            }
//////        }
//////
//////
//////    }
////    
////    
////    
////}
