//
//  ViewQuotationViewController.swift
//  Dreesha User
//
//  Created by Apple on 17/03/21.
//

import UIKit
import SpreadsheetView

class ViewQuotationViewController: UIViewController {
    
    
    
let arrayLeftLbl = ["Price Per Unit","Total Quantity","Vat","Discount","Total"]
let arrayRightLbl = ["SAR 10","300pcs","SAR 10","SAR 100","SAR  3090"]
var QuantDictElement = ["srNo", "itemName", "description", "quantity", "price", "total_Price"]
    
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var warrantyval: UILabel!
    @IBOutlet weak var offerValidityVal: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    @IBOutlet weak var vatValue: UILabel!
    @IBOutlet weak var quantityValue: UILabel!
    @IBOutlet weak var totalpriceval: UILabel!
    
    @IBOutlet weak var QunatityDetailTab: UITableView!
    @IBOutlet weak var scopeOfWorkValue: UILabel!
    @IBOutlet weak var exclusuionValue: UILabel!
    @IBOutlet weak var DreeshshConditionsVal: UILabel!
    @IBOutlet weak var SellerConditionsValue: UILabel!
    @IBOutlet weak var paymentTermValue: UILabel!
    @IBOutlet weak var workScheduleTab: UITableView!
    @IBOutlet weak var quantTabHeight: NSLayoutConstraint!
    @IBOutlet weak var moduleTabHeight: NSLayoutConstraint!
    
    @IBOutlet weak var AttachmentImgView: SetImage!
    
    @IBOutlet weak var QuantViewHeight: NSLayoutConstraint!
    
    
    
    
//    var QuantityData = [WFDatum?]()
    var quantRow: Int!
    var header = ["Sr. No.", "Item Name", "Description", "Quantity", "Price", "Total Price"]
    var viewModel = QuotationDetailsViewModel()
    var modelData: IssuedQuotationDetailModel!
    var quotationId = ""
    var startDate = ""
    var sdate = [String]()
    var ldate = [String]()
    var QuantityData = [[WFDatum]]()
    
    var quantityDetails = [Workflow]()
    var workScheduleDetail = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        hitApiIssueQuotationsDetails(QuotationIDStr: quotationId)
        QunatityDetailTab.delegate = self
        QunatityDetailTab.dataSource = self
        
        workScheduleTab.delegate = self
        workScheduleTab.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "View Quotation")
        hitApiIssueQuotationsDetails(QuotationIDStr : quotationId )
    }
    
    func Setdata(){
        let url = URLS.QuotationImgUrl(viewModel.issueModel?.image ?? "").getDescription()
        AttachmentImgView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
        
        
        titleName.text = modelData.title ?? ""
        warrantyval.text = modelData.warrenty ?? ""
        offerValidityVal.text = modelData.offerValidity ?? ""
        priceValue.text = "\(modelData.price ?? 0)"
        vatValue.text = modelData.vat ?? ""
        quantityValue.text = "\(modelData.quantity ?? 0)"
        scopeOfWorkValue.text = modelData.scopeOfWork ?? ""
        exclusuionValue.text = modelData.exclusion ?? ""
        totalpriceval.text = "\(modelData.totalPrice ?? 0)"
        DreeshshConditionsVal.text = modelData.dreeshahTerms ?? ""
        SellerConditionsValue.text = modelData.sellerTerms ?? ""
        paymentTermValue.text = modelData.paymentTerms ?? ""
        QunatityDetailTab.reloadData()
        workScheduleTab.reloadData()
//        quantTabHeight.constant = 200
        updateTableHeight(tableName: QunatityDetailTab, tableHeight: quantTabHeight)
        updateTableHeight(tableName: workScheduleTab, tableHeight: moduleTabHeight)
    }
    
    @IBAction func modify(_ sender: Any) {
        let vc = UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(withIdentifier: "AddIssueQuotationViewController") as! AddIssueQuotationViewController
//        vc.workModuleCount = viewModel.issueModel?.workSchedule?.count ?? 0
        vc.comefrom = "CustomerEdit"
        vc.QuotationIDStr = quotationId
        vc.QuotationIDStrVal = quotationId
        vc.countbool = true
        vc.customerId = viewModel.issueModel?.customerID ?? ""
        vc.quotationId = quotationId
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func reject(_ sender: Any) {
    }
    
    @IBAction func accept(_ sender: Any) {
    }

}
extension ViewQuotationViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == QunatityDetailTab
        {
            return modelData?.workflow?.count ?? 0
        }else
        {
            return modelData?.workSchedule?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == QunatityDetailTab
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! quantityDetailTabCell
            
            
            
            cell.titleName.text = viewModel.issueModel?.workflow?[indexPath.row].title ?? ""
            
            
            cell.detailsView.delegate = self
            cell.detailsView.dataSource = self
            cell.detailsView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
            cell.detailsView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
            cell.detailsView.tag = indexPath.row
            quantRow = indexPath.row
            if(QuantityData.count < quantRow+1){
                cell.detailViewHeight.constant = 80
            }else{
                cell.detailViewHeight.constant = CGFloat(80 + (QuantityData[quantRow].count * 44))
                cell.quantiveheight.constant = cell.quantiveheight.constant + 50
            }
            cell.detailsView.reloadData()
            return cell
        } else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! workScheduleTabCell
            cell.moduleName.text = modelData.workSchedule?[indexPath.row].module ?? ""
            cell.moduleDescription.text = modelData.workSchedule?[indexPath.row]
                .workScheduleDescription ?? ""
            //let formatter = DateFormatter()
            //formatter.dateFormat = "dd/MM/yyyy"
            
            cell.moduleTimePeriod.text = String(((sdate[indexPath.row]).dateToString).prefix(10)) + "  -  " + String(((ldate[indexPath.row]).dateToString).prefix(10))
            return cell
            
        }
        
    }
}

extension ViewQuotationViewController: SpreadsheetViewDelegate, SpreadsheetViewDataSource{
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        
        return header.count
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        if(QuantityData.count < quantRow+1){
            return 1
        }else {
            return 1 + QuantityData[quantRow].count
        }
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 140
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        if case 0 = row {
            return 60
        } else {
            return 44
        }
    }

    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if case 0 = indexPath.row {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = header[indexPath.column]
            
            cell.setNeedsLayout()
            
            return cell
        } else {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TextCell.self), for: indexPath) as! TextCell
//            print("\n" + QuantityData[spreadsheetView.tag][indexPath.row - 1].quantDataEleme[indexPath.column])
            let srNo = QuantityData[quantRow][indexPath.row - 1].srNo ?? ""
            let itemName = QuantityData[quantRow][indexPath.row - 1].itemName ?? ""
            let datDesc = QuantityData[quantRow][indexPath.row - 1].datumDescription ?? ""
            let quantity = QuantityData[quantRow][indexPath.row - 1].quantity ?? ""
            let price = QuantityData[quantRow][indexPath.row - 1].price ?? ""
            let totalPrice = QuantityData[quantRow][indexPath.row - 1].totalPrice ?? ""
            let dataValue = [srNo, itemName, datDesc, quantity, price, totalPrice]
            cell.label.text = dataValue[indexPath.column]
//            cell.label.text =
//            cell.label.text = QuantityData[spreadsheetView.tag][indexPath.row - 1][QuantDictElement[indexPath.column]]
            return cell
        }
    }

    /// Delegate

}

extension ViewQuotationViewController{
    func hitApiIssueQuotationsDetails(QuotationIDStr : String ){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiIssueQuotationDetailfunc(quotationID: QuotationIDStr)    {(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.modelData = self.viewModel.issueModel
                self.sdate = self.viewModel.issueModel?.workSchedule?.map({$0.startDate ?? "" }) ?? []
               
                self.ldate = self.viewModel.issueModel?.workSchedule?.map({$0.endDate ?? "" }) ?? []
               
                self.Setdata()
                self.QuantityData = self.viewModel.issueModel?.workflow?.map({$0.data } ) as! [[WFDatum]]
            }else{
               
                self.view.makeToast(message , position : .center)
            }
        }
    }
}
