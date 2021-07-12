//
//  CartNewViewController.swift
//  Dreesha User
//
//  Created by Promatics on 21/06/21.
//

import UIKit

class CartNewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   

    //MARK: Outlets
    @IBOutlet weak var CustomerName: UILabel!
    @IBOutlet weak var AdressLabel: UILabel!
    @IBOutlet weak var AddressType: UILabel!
    
    @IBOutlet weak var CartEmptyLabel: UILabel!
    @IBOutlet weak var HideView: UIView!
    @IBOutlet weak var ProffTableView: UITableView!
    @IBOutlet weak var ProffTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var CouponCodeTxtFld: UITextField!
    @IBOutlet weak var GrandTotalVal: UILabel!
    
    //    MARK: Variables
    var viewModel = MyCartViewModel()
    var WishviewModel = ProductViewModel()
    var counterNumbers : Int = 0
    var cartItemCount = [Int]()
    var CartItemPrices = [Int]()
    var arrProductIds = [[String]]()
    var arrProductColorName = [String]()
    var arrProductSize = [Int]()
    var arrProductColorCode = [String]()
    var arrProductUnit = [String]()
    var arrProfessionalIds = [String]()
    var pricearr = [Int]()
    var GrandTotal = [Int]()
    var Totall = 0
    var arrAllQuantity = [Int]()
    var TotalValueS = 0
    
    var ProductsforCheck = [[String : String]]()
    
    var ProductID = [String]()
    var ColorName = [String]()
    var Size = [Int]()
    var ColorCode = [String]()
    var SizeUnit = [String]()
    var QuantityArr = [Int]()
    var isFetching = false
    var isRemove = false
    var AP = false
    var OK = false
    var mainProduct = [[String:Any]]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProffTableView.dataSource = self
        ProffTableView.delegate = self
//        setFuncData()
        
        
    }
    
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "My Cart")
        self.ColorCode = []
        self.Size = []
        self.SizeUnit = []
        self.ColorName = []
        self.QuantityArr = []
        self.GrandTotal = []
        viewModel.model = []
        hitApiMyCartListNew()
        GetDefaultAddrs()
        }
    
    
    //MARK: Actions
    
 
       @IBAction func ChangeAddressBtnAct(_ sender: UIButton) {
           let vc = storyboard?.instantiateViewController(identifier: "AddressViewController") as! AddressViewController
           vc.hidesBottomBarWhenPushed = true
           navigationController?.pushViewController(vc, animated: true)
       }
    
    //MARK: Set AddressData
    func SetAddressData(){
        
        
        if viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.firstName == nil{
            CustomerName.text = ""
            AddressType.text = "Address"
            AdressLabel.text = "Please Add Address First"
            AdressLabel.textAlignment = .center
        }else{
            
            CustomerName.text = "\(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.firstName ?? "") \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.lastName ?? "")"
        AdressLabel.textAlignment = .left
            AdressLabel.text = " \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.addressLine1 ?? "") \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.addressLine2 ?? "") \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.city ?? "") \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.state ?? "") \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.country ?? "") \(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.zipCode ?? "")"
            
        AddressType.text = "\(viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.addressType ?? "")"
            }
        }
    
        func convertIntoJSONString(arrayObject: [Any]) -> String? {
                do {
                    let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
                    if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                        return jsonString as String
                    }
                } catch let error as NSError {
                    print("Array convertIntoJSON - \(error.description)")
                }
                return nil
            }
    
    @IBAction func CheckoutBtn(_ sender: UIButton) {
        
        if AdressLabel.text == "Please Add Address First"{
            self.view.makeToast("Add Address First!" , position: .center)
        }
        else{
            
            var subProduct = [String:Any]()
            var innerProducts = [String:Any]()
            var innerProductsArray = [[String:Any]]()
            
            for i in self.viewModel.model.enumerated(){
                subProduct["professional_id"] = i.element.professionalData?.id ?? ""
                let cell = self.ProffTableView.cellForRow(at: IndexPath(row: i.offset, section: 0)) as! ProffNamesTableViewCell
                
                let moduleName = cell.TotalLabelVal.text ?? ""
                let first = moduleName.components(separatedBy: " ")
                subProduct["amount"] = Int(first[1]) ?? 0
                
                innerProducts.removeAll()
                innerProductsArray.removeAll()
                
                for j in (i.element.professionalData?.productData ?? []){
                    innerProducts["product_id"] = j.cartData?.productID ?? ""
                    innerProducts["product_quantity"] = j.cartData?.quantity ?? 0
                    innerProducts["color_name"] = j.cartData?.colorName ?? ""
                    innerProducts["color_code"] = j.cartData?.colorCode ?? ""
                    innerProducts["size"] = j.cartData?.size ?? 0
                    innerProducts["size_unit"] = j.cartData?.sizeUnit ?? ""
                    
                    innerProductsArray.append(innerProducts)
                }
                
                subProduct["products"] = innerProductsArray
                
                mainProduct.append(subProduct)
            }
            
            print("Final Params to send \(mainProduct)")
            
            
            
        Checkout()
        }
    }
}

extension CartNewViewController {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProffNamesTableViewCell
        
        cell.ProfessionalNameLabel.text = "\(viewModel.model[indexPath.row].professionalData?.firstName ?? "") \(viewModel.model[indexPath.row].professionalData?.lastName ?? "")"
        cell.ProductTitle =  viewModel.model[indexPath.row].professionalData?.productData?.map({$0.productTitle ?? ""}) ?? []
        cell.ProductPrice = viewModel.model[indexPath.row].professionalData?.productData?.map({$0.pricing?.price ?? 0}) ?? []
        
        cell.ProductQuantity = viewModel.model[indexPath.row].professionalData?.productData?.map({$0.cartData?.quantity ?? 0}) ?? []
        cartItemCount = viewModel.model[indexPath.row].professionalData?.productData?.map({$0.cartData?.quantity ?? 0}) ?? []
       
       
        arrProductColorName = viewModel.model[indexPath.row].professionalData?.productData?.map({$0.cartData?.colorName ?? ""}) ?? []
        arrProductColorCode = viewModel.model[indexPath.row].professionalData?.productData?.map({$0.cartData?.colorCode ?? ""}) ?? []
        arrProductSize =  viewModel.model[indexPath.row].professionalData?.productData?.map({$0.cartData?.size ?? 0 }) ?? []
        arrProductUnit = viewModel.model[indexPath.row].professionalData?.productData?.map({$0.cartData?.sizeUnit ?? "" }) ?? []
        cell.ProductTax = viewModel.model.map({$0.charges?.taxPercentage ?? 0})
        cell.ShippingChargesARR = viewModel.model.map({$0.charges?.shippingCharges ?? 0})
        let c = zip(cell.ProductPrice, cell.ProductQuantity).map { $0 * $1 }
        print(c)
        let total = c.reduce(0, +)
        
        
        cell.SubtotalLabelVal.text = ("AED \(total)")
        print(cell.SubtotalLabelVal.text ?? "")
        
        let totaltax = (total * ((cell.ProductTax[indexPath.row])/100))
        cell.TaxLabelVal.text  = "AED \( totaltax)"
        print((cell.ProductTax[indexPath.row]))
        print("TAXX")
        cell.ShippingChargesVal.text = "AED \(cell.ShippingChargesARR[indexPath.row])"
        
        cell.TotalLabelVal.text = "AED \( (total) + (cell.ShippingChargesARR[indexPath.row]) + (totaltax)) "
        Totall =  (total) + (cell.ShippingChargesARR[indexPath.row]) + (totaltax)
        
        if GrandTotal.count > (viewModel.model.count - 1) {
            print("GrandTotal \(GrandTotal.count)")
        }else{
        GrandTotal.insert(Totall, at: indexPath.row)
        print("(Full\(GrandTotal))")
        print(GrandTotal[GrandTotal.count-1])
        }
        
        QuantityArr.append(contentsOf: cartItemCount)
        print("Cart Quantity is \(QuantityArr)")
        
        ColorName.append(contentsOf: arrProductColorName)
        print("Color Name is \(ColorName)")
        
        ColorCode.append(contentsOf: arrProductColorCode)
        print("Color Code is \(ColorCode)")
        
        Size.append(contentsOf: arrProductSize)
        print("Size is \(Size)")
        
        SizeUnit.append(contentsOf: arrProductUnit)
        print("Size Unit is \(SizeUnit)")
        
        let Gtotal = GrandTotal.reduce(0, +)
        GrandTotalVal.text = "AED \(Gtotal)"
        TotalValueS = Gtotal
        
        cell.viewContrlr = self
        cell.PresentLabel.text = "(\(cell.ProductTax[indexPath.row]))%"
        
        cell.URLArr = viewModel.model[indexPath.row].professionalData?.productData?.map({$0.productMedia?.first?.name ?? ""}) ?? []
        
        cell.productIDarr = viewModel.model[indexPath.row].professionalData?.productData?.map({$0.cartData?.productID ?? ""}) ?? []
        arrProductIds = viewModel.model.map({($0.products ?? [])})
        cell.professionalIDarr = viewModel.model[indexPath.row].professionalData?.productData?.map({$0.cartData?.professionalID ?? ""}) ?? []
        arrProfessionalIds = viewModel.model.map({$0.professionalData?.id ?? ""})
        cell.cartIDarr = viewModel.model[indexPath.row].professionalData?.productData?.map({$0.cartData?.cartID ?? ""}) ?? []
        cell.CartListTableView.reloadData()
        cell.callback = {
                text in

            self.ProffTableView.reloadData()
            
        }
        
        cell.callbackPLUS  = {
             
            text in
            self.ProffTableView.reloadData()
        }
        
        cell.callbackMinus  = {
             
            text in
            self.ProffTableView.reloadData()
        }
        
        if cell.plus == true{
            QuantityArr = []
            print("Product ID \(cell.productid)")
            print("Professional ID \(cell.professionalID)")
            print("Cart ID \(cell.cartID)")
            cell.plus = false
            cell.removedone = true
            removeFromCartListNew(ProfessionalID: cell.professionalID, Product_id: cell.productid, CartID: cell.cartID, Quantity: "\(cell.quant + 1)")
            
            self.ProffTableView.reloadData()
            
        }
        
        if cell.minus == true{
            QuantityArr = []
            print("Product ID \(cell.productid)")
            print("Professional ID \(cell.professionalID)")
            print("Cart ID \(cell.cartID)")
            cell.minus = false
            cell.removedone = true
            removeFromCartListNew(ProfessionalID: cell.professionalID, Product_id: cell.productid, CartID: cell.cartID, Quantity: "\(cell.quant - 1)")
            self.ProffTableView.reloadData()
            
        }
        
        if cell.arr == true{
            print("Product ID \(cell.productid)")
            print("Professional ID \(cell.professionalID)")
            print("Cart ID \(cell.cartID)")
            cell.arr = false
            cell.removedone = true
            isRemove = true
            removeFromCartListNew(ProfessionalID: cell.professionalID, Product_id: cell.productid, CartID: cell.cartID, Quantity: "0")
            self.ProffTableView.reloadData()
            
        }
        
        if cell.Wish == true{
            print("Product ID \(cell.productid)")
            print("Professional ID \(cell.professionalID)")
            cell.Wish = false
            cell.removedone = true
            AddtoWishlist(ProfessionalID: cell.professionalID, Product_id: cell.productid)
            self.ProffTableView.reloadData()
            
        }
        
        
        
        return cell
    }
    
 
    
    
}

//MARK:- API CALL
extension CartNewViewController{
    func hitApiMyCartListNew(){

        Indicator.shared.showProgressView(self.parent?.view ?? self.view)

        viewModel.apiCartList(){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                
                self.HideView.isHidden = true
                self.CartEmptyLabel.isHidden = true
                self.isFetching = true
                self.updateTableHeight(tableName: self.ProffTableView, tableHeight: self.ProffTableHeight)
                self.ProffTableView.reloadData()
                self.updateTableHeight(tableName: self.ProffTableView, tableHeight: self.ProffTableHeight)
                
            }else{
                self.ProffTableView.reloadData()
                if message == "Cart is empty" || message == "Cart not found"{
                    self.HideView.isHidden = false
                    self.CartEmptyLabel.isHidden = false
                    tableCollectionErrors(view: self.ProffTableView, text: "Cart is Empty")
                    
                    self.ProffTableHeight.constant = 200
                    self.GrandTotalVal.text = "AED 0"
                }
                else{
                    print(message)
                }
                
            }
        }
    }
    
    func AddtoWishlist(ProfessionalID: String , Product_id : String){
        WishviewModel.hitAddtowishlist(Professional_id: ProfessionalID , Product_id: Product_id ){ (isSuccess, message) in
            if isSuccess{
                self.showAlertWithAction(Title: "Dreeshah", Message: message, ButtonTitle: "OK") {
                    self.ColorCode = []
                    self.Size = []
                    self.SizeUnit = []
                    self.ColorName = []
                    self.QuantityArr = []
                    self.GrandTotal = []
                    self.viewModel.model = []
                    self.hitApiMyCartListNew()
                    if message == "Removed from wishlist"{
                        
                    }
                }
               
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func removeFromCartListNew(ProfessionalID: String , Product_id : String , CartID : String , Quantity : String){
        
        viewModel.hitRemoveFromCart(Professional_id: ProfessionalID, Product_id: Product_id, Cart_id: CartID, Quantity: Quantity) { (isSuccess, message) in
            if isSuccess{
                if self.isRemove == true{
                self.showAlertWithAction(Title: "Dreeshah", Message: "Item Removed!", ButtonTitle: "OK") {
                    self.isRemove = false
                    self.ColorCode = []
                    self.Size = []
                    self.SizeUnit = []
                    self.ColorName = []
                    self.QuantityArr = []
                    self.GrandTotal = []
                    self.viewModel.model = []
                    self.hitApiMyCartListNew()
            }
        }
                else{
                    self.ColorCode = []
                    self.Size = []
                    self.SizeUnit = []
                    self.ColorName = []
                    self.QuantityArr = []
                    self.GrandTotal = []
                    self.viewModel.model = []
                    self.hitApiMyCartListNew()
                }
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func GetDefaultAddrs(){
        
        viewModel.hitGetDefaultAddress { (isSuccess, message) in
            if isSuccess{
                self.SetAddressData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func Checkout(){

        viewModel.hitCheckOut(User_id: viewModel.UserID , Amount: TotalValueS, OrderItems: mainProduct , FirstName: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.firstName ?? "", LastName: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.lastName ?? "", AddressLine1: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.addressLine1 ?? "", AddressLine2: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.addressLine2 ?? "", City: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.city ?? "", State: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.state ?? "", ZipCode: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.zipCode ?? "", PhoneNo: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.phoneNumber ?? "", Landmark: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.landmark ?? "", address_type: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.addressType ?? "", country_ph_code: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.countryPhCode ?? "", country: viewModel.getDefaultAddressDara()?.result?.addressDetails?.first?.country ?? "") { (isSuccess, message) in
            if isSuccess{
                
                
                self.showAlertWithAction(Title: "DREESHAH", Message: "ORDER SUCCESS", ButtonTitle: "OK") {
                    self.ColorCode = []
                    self.Size = []
                    self.SizeUnit = []
                    self.ColorName = []
                    self.QuantityArr = []
                    self.GrandTotal = []
                    self.viewModel.model = []
                    self.hitApiMyCartListNew()
                }
//
//                let vc = self.storyboard?.instantiateViewController(identifier: "PaymentMethodViewController") as! PaymentMethodViewController
//                self.navigationController?.pushViewController(vc, animated: true)

            }else{

                self.view.makeToast(message , position : .center)
            }
        }


    }
    
    
    
}
