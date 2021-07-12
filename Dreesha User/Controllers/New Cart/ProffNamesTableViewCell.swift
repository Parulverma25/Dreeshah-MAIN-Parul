//
//  ProffNamesTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 21/06/21.
//

import UIKit

class ProffNamesTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel = MyCartViewModel()
    var WishviewModel = ProductViewModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ProductTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CartItemsTableViewCell
        cell.ProductitleLabel.text = ProductTitle[indexPath.row]
        cell.ProductPrice.text = "AED \(ProductPrice[indexPath.row])"
        cell.ProductQuantityVal.text = "\(ProductQuantity[indexPath.row])"
        cell.MovetoWishlistBtn.tag = indexPath.row
        cell.MovetoWishlistBtn.addTarget(self, action: #selector(tapWishlist(_:)), for: .touchUpInside)
        cell.PlusBtn.tag = indexPath.row
        cell.PlusBtn.addTarget(self, action: #selector(tapPlus(_:)), for: .touchUpInside)
        cell.MinusBtn.tag = indexPath.row
        cell.MinusBtn.addTarget(self, action: #selector(tapMinus(_:)), for: .touchUpInside)
        
       
        url = URLS.productImgUrl(URLArr[indexPath.row]).getDescription()
       
        cell.ProdImage.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
        
        cell.RemoveBtn.tag = indexPath.row
        cell.RemoveBtn.addTarget(self, action: #selector(tapremoveitem(_:)), for: .touchUpInside)
        
        if removedone == true{
            CartListTableView.reloadData()
            removedone = false
        }
        
        
        
        return cell
    }
    
    

    //MARK: Outlets
    
    
    @IBOutlet weak var PercentageTax: UILabel!
    
    @IBOutlet weak var PresentLabel: UILabel!
    
    @IBOutlet weak var ProfessionalNameLabel: UILabel!
    @IBOutlet weak var SubtotalLabelVal: UILabel!
    @IBOutlet weak var TaxLabelVal: UILabel!
    @IBOutlet weak var ShippingChargesVal: UILabel!
    @IBOutlet weak var TotalLabelVal: UILabel!
   
    @IBOutlet weak var CartListTableView: UITableView!
    @IBOutlet weak var CartTableHeight: NSLayoutConstraint!
    
    //MARK: Variables
    var PRCount = [Int]()
    
    
    
    var ProductTitle = [String]()
    var arr = false
    var Wish = false
    var plus = false
    var minus = false
    var ProductPrice = [Int]()
    var ProductQuantity = [Int]()
    var ProductTax = [Int]()
    var ShippingChargesARR = [Int]()
    var ProductURL = [String]()
    var url = ""
    var URLArr = [String]()
    var viewContrlr = UIViewController()
    var count = 0
    var num = 0
    var quant = 0
    var mincount = 0
    var minnum = 0
    var productid = ""
    var professionalID = ""
    var cartID = ""
    var productIDarr = [String]()
    var professionalIDarr = [String]()
    var cartIDarr = [String]()
    var callback : ((String?)-> ())?
    var callbackPLUS : ((String?)-> ())?
    var callbackMinus : ((String?)-> ())?
    var removedone = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CartListTableView.dataSource = self
        CartListTableView.delegate = self
        updateTableHeight(tableName: CartListTableView, tableHeight: CartTableHeight)
        CartListTableView.reloadData()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateTableHeight(tableName : UITableView , tableHeight : NSLayoutConstraint){
        var frame = tableName.frame
        frame.size.height = tableName.contentSize.height
        tableName.frame = frame
        
        tableName.reloadData()
        tableName.layoutIfNeeded()
        tableHeight.constant = CGFloat(tableName.contentSize.height + 180)
        
    }

}
extension ProffNamesTableViewCell {
    
    
     func Quant(){
    
        var AmountArraya = [Int]()
        AmountArraya = []
        for i in 0...ProductTitle.count - 1{
            let index = IndexPath(row: i, section: 0)
            let cell: CartItemsTableViewCell = self.CartListTableView.cellForRow(at: index) as! CartItemsTableViewCell
            
            let moduleName = cell.ProductQuantityVal.text ?? ""
            
            AmountArraya.append(Int(moduleName) ?? 0)
        }
        print(AmountArraya)
        
    }
    
    
    @IBAction func tapWishlist(_ sender : UIButton){
        Wish = true
        productid = productIDarr[sender.tag]
        professionalID = professionalIDarr[sender.tag]
        
        
        self.callback?(String(self.Wish))
    }
    
    @IBAction func tapremoveitem(_ sender : UIButton){
        arr = true
        productid = productIDarr[sender.tag]
        professionalID = professionalIDarr[sender.tag]
        cartID = cartIDarr[sender.tag]
        
        self.callback?(String(self.arr))
    }
    
    @IBAction func tapPlus(_ sender : UIButton){
        
        plus = true
        productid = productIDarr[sender.tag]
        professionalID = professionalIDarr[sender.tag]
        cartID = cartIDarr[sender.tag]
        quant = ProductQuantity[sender.tag]
        
        self.callbackPLUS?(String(self.arr))
        
        
//        count = ProductQuantity[sender.tag]
//        num = count + 1
//        ProductQuantity.remove(at: sender.tag)
//        ProductQuantity.insert(num, at: sender.tag)
//        print(ProductQuantity)
//        CartListTableView.reloadData()
    }
    
    @IBAction func tapMinus(_ sender : UIButton){
        
        minus = true
        productid = productIDarr[sender.tag]
        professionalID = professionalIDarr[sender.tag]
        cartID = cartIDarr[sender.tag]
        quant = ProductQuantity[sender.tag]
        if quant <= 1 {
            quant = 2
        }
        
        self.callbackPLUS?(String(self.arr))
        
        
        
//            mincount = ProductQuantity[sender.tag]
//            minnum = mincount - 1
//            ProductQuantity.remove(at: sender.tag)
//            if minnum <= 0
//            {
//            minnum = 0
//            }
//            ProductQuantity.insert(minnum, at: sender.tag)
//            print(ProductQuantity)
//            CartListTableView.reloadData()
//
    }
    
    
}
