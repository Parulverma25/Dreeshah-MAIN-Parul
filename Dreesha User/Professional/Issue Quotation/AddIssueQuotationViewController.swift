//
//  AddIssueQuotationViewController.swift
//  Dreesha User
//
//  Created by Promatics on 18/05/21.
//

import UIKit
import SpreadsheetView
import SBCardPopup
import iOSDropDown

class AddIssueQuotationViewController: UIViewController, QuantityData, SelectDate {

    //MARK:- protocol func
    
    func getDataValue(model: String, descriptn: String, quant: String, price: String, totalvat: String, toEdit: Bool) {
        if toEdit == false{
            var sr : Int!
            if(QuantityData[quantRow].count == 0){
                sr = 0
            }else{
                sr = Int(QuantityData[quantRow!][QuantityData[quantRow].count-1][QuantDictElement[0]] ?? "\(QuantityData[quantRow].count)")
            }
            let quantDetailEnterd = ["srNo": "\((sr ?? QuantityData[quantRow].count)+1)","itemName": model, "description": descriptn, "quantity": quant, "price": price, "total_Price": totalvat]
            QuantityData[quantRow].append(quantDetailEnterd)
            quantityDescription_tab.reloadData()
            updateTableHeight(tableName: quantityDescription_tab, tableHeight: quantTabHeight)
        }else{
            let sr = Int(QuantityData[quantRow!][dataNumSelected][QuantDictElement[0]] ?? "\(QuantityData[quantRow].count)")
            let quantDetailEnterd = ["srNo": "\(sr ?? QuantityData[quantRow].count)","itemName": model, "description": descriptn, "quantity": quant, "price": price, "total_Price": totalvat]
            QuantityData[quantRow][dataNumSelected] = quantDetailEnterd
            quantityDescription_tab.reloadData()
            updateTableHeight(tableName: quantityDescription_tab, tableHeight: quantTabHeight)
        }
    }
    
    func onDate(date: String) {
            Module_Ranges[moduleNumSelected] = date
            if(workModuleCount != 0){
                for i in 0...workModuleData.count-1{
                    let index = IndexPath(row: i, section: 0)
                    let cell: QuotationWorkSchdulCell = self.workModules_tab.cellForRow(at: index) as! QuotationWorkSchdulCell
                    Module_Names[index.row] = cell.moduleNme.text ?? ""
                    Module_Descriptions[index.row] = cell.moduleDescription.text ?? ""
                }
            }
            workModules_tab.reloadData()
            updateTableHeight(tableName: workModules_tab, tableHeight: moduleTabHeight)
    }
    
//MARK:- IBOutlet Var
    
    var modelData: IssuedQuotationDetailModel!
    
    
    @IBOutlet weak var title_txtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var Warrenty_txtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var offerVald_txtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var offerVldty_Btn: UIButton!
    @IBOutlet weak var offerVldty_Tab: UITableView!
    @IBOutlet weak var offerVldtyLbl: UILabel!
    @IBOutlet weak var vldtyTabHeight: NSLayoutConstraint!
    @IBOutlet weak var price_txtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var vat_txtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var totalprice: SkyFloatingLabelTextField!
    
    @IBOutlet weak var quantity_txtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var quantityDescription_tab: UITableView!
    @IBOutlet weak var scopeOfWork_txtView: UITextView!
    @IBOutlet weak var quantTabHeight: NSLayoutConstraint!
    @IBOutlet weak var exclusion_txtView: UITextView!
    @IBOutlet weak var DreeshsahTC_txtView: UITextView!
    @IBOutlet weak var SellerTC_txtView: UITextView!
    @IBOutlet weak var oneTimePay_btn: SetButton!
    @IBOutlet weak var twoInstallmnt_btn: SetButton!
    @IBOutlet weak var threeInstallmnt_btn: SetButton!
    @IBOutlet weak var workModules_tab: UITableView!
    @IBOutlet weak var moduleTabHeight: NSLayoutConstraint!
    @IBOutlet weak var uploadedFileView: UIView!
    @IBOutlet weak var fileImage: UIImageView!
    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var fileHeight: NSLayoutConstraint!
    @IBOutlet weak var browseBtn: SetButton!
    @IBOutlet weak var DeleteModButt: SetButton!
    
   
    @IBOutlet weak var firstInstallment: SkyFloatingLabelTextField!
    
    @IBOutlet weak var thirdinstall: SkyFloatingLabelTextField!
    @IBOutlet weak var Secondinstall: SkyFloatingLabelTextField!
    @IBOutlet weak var percentViewHeight: NSLayoutConstraint!
    
    //MARK:- VAriable
    
    var comefrom = ""
    var APIBOOL = false
    var noeditCustomer = false
    var noeditCustomerSP = false
    var noeditCustomerrow = false
    var noeditQuant = false
    var noeditQuantRows = false
    var QuotationIDStrVal = ""
    var QuotationIDStr = ""
    var countbool = false
    var workmodRows = false
    var EditViewModel = QuotationDetailsViewModel()
    
    
    var customerId = ""
    var quotationId = ""
    var name = ""
    var viewModel = IssueQuotationModel()
    var durationOptn = ["Days", "Weeks", "Months", "Years"]
    var header = ["Sr. No.", "Item Name", "Description", "Quantity", "Price", "Total Price"]
    var QuantDictElement = ["srNo", "itemName", "description", "quantity", "price", "total_Price"]
    var QuantityEnterData = [["1","A","B","C", "D", "E"], ["2","A","B","C", "D", "E"], ["3","A","B","C", "D", "E"]]
    var QuantityData = [[[String:String]]]()
    var quantRow: Int!
    var dataNumSelected: Int!
    var quantityValue: Int = 0
    var workModuleCount = 0
    var moduleNumSelected : Int!
    let radioController: RadioButtonController = RadioButtonController()
    var workModuleData = [[String : String]]()
    var PaymentData = [[String : String]]()
    var Module_Ranges = [String]()
    var Module_Names = [String]()
    var Module_Descriptions = [String]()
    var offerValidityValue = ""
    var paymentTermsValue = ""
    var workFlowArray = [[String: Any]]()
    var imagePicker = ImagePickerViewControler()
    var imageData = Data()
    var imageType = ""
    var imageName = ""
    var QuantityDatas = [[WFDatum]]()
    var imageParam = ""
    
    
    
    
    //MARK:- DidLoad
    
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = false
        setBackWithTitle(titleVal: "Issue Quotation")
        super.viewDidLoad()
       // QuantityData.append(QuantityEnterData)
        offerVldty_Tab.delegate = self
        offerVldty_Tab.dataSource = self
        offerVldty_Tab.isHidden = true
        quantityDescription_tab.delegate = self
        quantityDescription_tab.dataSource = self
        workModules_tab.delegate = self
        workModules_tab.dataSource = self
        radioController.buttonsArray = [oneTimePay_btn, twoInstallmnt_btn, threeInstallmnt_btn]
      //  workModuleData.append(["module": "", "description": "", "start_date": "", "end_date": ""])
      //  Module_Ranges.append("")
     //   Module_Names.append("")
      //  Module_Descriptions.append("")
       // workModules_tab.reloadData()
        
        updateTableHeight(tableName: workModules_tab, tableHeight: moduleTabHeight)
        if comefrom == "CustomerEdit"{
        
        }
    }
    
    //MARK: VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        
        if comefrom == "CustomerEdit"{
            setBackWithTitle(titleVal: "Modify Issue Quotation")
            hitApiIssueQuotationsDetails(QuotationIDStr: QuotationIDStr)
        }else{
            title_txtFld.text = name
        }
    }
    
    
    //MARK:- Functions
    
    func json(from object: [[String:Any]]) throws -> String {
        let data = try JSONSerialization.data(withJSONObject: object)
        
        
        return String(data: data, encoding: .utf8)!
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
    
    
    //MARK:- Objc Func
    
    @objc func addQuanttyDetails(_ sender: UIButton){
        noeditCustomerSP = true
        quantRow = sender.tag
        let vc = storyboard?.instantiateViewController(identifier: "AddDataPopUpViewController") as! AddDataPopUpViewController
        vc.delegate = self
        let card = SBCardPopupViewController(contentViewController: vc)
        card.show(onViewController: self)
        dataNumSelected = QuantityData.count-1
    }
    
    @objc func deleteQuanttyDetails(_ sender: UIButton){
        noeditCustomerSP = true
        if(dataNumSelected != nil && quantRow == sender.tag){
            QuantityData[quantRow].remove(at: dataNumSelected)
            quantityDescription_tab.reloadData()
            updateTableHeight(tableName: quantityDescription_tab, tableHeight: quantTabHeight)
        }
    }
    
    @objc func editQuanttyDetails(_ sender: UIButton){
        if QuantityData == [[]] {
            print(QuantityData)
        }else{
        noeditCustomerSP = true
        if quantRow == sender.tag{
            let vc = storyboard?.instantiateViewController(identifier: "AddDataPopUpViewController") as! AddDataPopUpViewController
            vc.delegate = self
            vc.toEdit = true
            if dataNumSelected == nil {
                dataNumSelected = QuantityData.count - 1
            }else{}
            vc.quantDetailEnterd = QuantityData[quantRow][dataNumSelected]
            let card = SBCardPopupViewController(contentViewController: vc)
            card.show(onViewController: self)
        }
        }
    }

    
    @objc func selectModuleTimeRange(_ sender: UIButton){
        moduleNumSelected = sender.tag
        let vc = UIStoryboard(name: "Professional", bundle: nil).instantiateViewController(identifier: "CalenderPopUpViewController") as! CalenderPopUpViewController
        vc.delegate = self
        vc.maxDateReq = false
        vc.multipleVal = true
        let card = SBCardPopupViewController(contentViewController: vc)
        card.show(onViewController: self)
    }
    
    //MARK:- BAction func
    
    @IBAction func quantityEdited(_ sender: Any){
        if(quantity_txtFld.text != nil){
            quantityValue = Int(quantity_txtFld.text ?? "0") ?? 0
            var qdCount = QuantityData.count
            if(quantityValue > qdCount){
                for i in qdCount...quantityValue-1{
                    QuantityData.append([])
                }
            }else if quantityValue < qdCount{
                repeat{
                    QuantityData.remove(at: qdCount-1)
                    qdCount = qdCount-1
                }while qdCount > quantityValue
            }
            quantityDescription_tab.reloadData()
            updateTableHeight(tableName: quantityDescription_tab, tableHeight: quantTabHeight)
        }
    }
    
    @IBAction func tapOffervldtyBtn(_ sender: Any) {
        if offerVldty_Tab.isHidden{
            offerVldty_Tab.isHidden = false
            vldtyTabHeight.constant = 160
            offerVldty_Tab.reloadData()
        }else {
            offerVldty_Tab.isHidden = true
            vldtyTabHeight.constant = 0
        }
    }
    
    @IBAction func tapOnePay(_ sender: Any) {
        radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
        paymentTermsValue = "One Time Payment"
        percentViewHeight.constant = 0
        firstInstallment.isHidden = true
        Secondinstall.isHidden = true
        thirdinstall.isHidden = true
    }
    
    @IBAction func tapTwoPay(_ sender: Any) {
        radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
        paymentTermsValue = "Two Installments"
        percentViewHeight.constant = 130
        firstInstallment.isHidden = false
        Secondinstall.isHidden = false
        thirdinstall.isHidden = true
    }
    @IBAction func tapThreePay(_ sender: Any) {
        radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
        paymentTermsValue = "Three Installments"
        percentViewHeight.constant = 190
        firstInstallment.isHidden = false
        Secondinstall.isHidden = false
        thirdinstall.isHidden = false
    }
   
    
    
    @IBAction func addModule(_ sender: Any) {
            if workModuleData.count>0{
                for i in 0...workModuleData.count-1{
                    let index = IndexPath(row: i, section: 0)
                    let cell: QuotationWorkSchdulCell = self.workModules_tab.cellForRow(at: index) as! QuotationWorkSchdulCell
                    let moduleName = cell.moduleNme.text ?? ""
                    let modDesc = cell.moduleDescription.text ?? ""
                    let strDate = cell.timePeriod_tfld.text ?? ""
                    if moduleName.isEmpty{
                        view.makeToast("Please enter module name")
                    }else if modDesc.isEmpty{
                        view.makeToast("Please enter module description")
                    }else if strDate.isEmpty{

                        view.makeToast("Please select module date")
                    }else{
                        Module_Names[index.row] = moduleName
                        Module_Descriptions[index.row] = modDesc
                    }
                }
            }
                workModuleCount += 1
                workModuleData.append(["module": "", "description": "", "start_date": "", "end_date": ""])
                Module_Ranges.append("")
                Module_Names.append("")
                Module_Descriptions.append("")
                workModules_tab.reloadData()
                updateTableHeight(tableName: workModules_tab, tableHeight: moduleTabHeight)
                moduleNumSelected = workModuleCount-1
        }
    
    
    @IBAction func uploadFile(_ sender: Any) {
        imagePicker.imagePickerDelegete = self
        imagePicker.showImagePicker(viewController: self)
    }
    
    @IBAction func cancelFile(_ sender: Any) {
        imageData = Data()
        imageType = ""
        imageName = ""
        imageParam = ""
        uploadedFileView.isHidden = true
        fileHeight.constant = 0
        browseBtn.isHidden = false
    }
    
    @IBAction func deleteModule(_ sender: Any) {
        if moduleNumSelected != nil{
            
            workModuleCount = workModuleCount - 1
            workModuleData.remove(at: moduleNumSelected)
            Module_Ranges.remove(at: moduleNumSelected)
            Module_Names.remove(at: moduleNumSelected)
            Module_Descriptions.remove(at: moduleNumSelected)
            workModules_tab.reloadData()
            updateTableHeight(tableName: workModules_tab, tableHeight: moduleTabHeight)
            moduleNumSelected = workModuleCount-1
        }
    }
    
    @IBAction func tapSubmitBnt(_ sender: Any) {
        var msg = ""
        if title_txtFld.text!.isEmpty{
            msg = "Please enter title"
        }else if Warrenty_txtFld.text!.isEmpty{
            msg = "Please enter warrenty"
        }else if offerVald_txtFld.text!.isEmpty{
            msg = "Please enter offer validity"
        }else if offerVldtyLbl.text!.isEmpty{
            msg = "Please select offer validity"
        }else if price_txtFld.text!.isEmpty{
            msg = "Please enter price"
        }else if vat_txtFld.text!.isEmpty{
            msg = "Please enter vat"
        }else if quantity_txtFld.text!.isEmpty{
            msg = "Please enter quantity"
        }else if scopeOfWork_txtView.text!.isEmpty{
            msg = "Please enter scope of work"
        }else if exclusion_txtView.text!.isEmpty{
            msg = "Please enter exclusions"
        }else if DreeshsahTC_txtView.text!.isEmpty{
            msg = "Please enter terms and condiotions of dreeshsah"
        }else if SellerTC_txtView.text!.isEmpty{
            msg = "Please enter terms and conditions of seller"
        }else if paymentTermsValue == ""{
            msg = "Please select payment terms"
        }else if Module_Names[0] == ""{
            msg = "Please enter work schedule details (DATE)"
        }else {
            offerValidityValue = (offerVald_txtFld.text ?? "") + " " + (offerVldtyLbl.text ?? "")
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            for i in 0...workModuleData.count-1{
                let index = IndexPath(row: i, section: 0)
                let cell: QuotationWorkSchdulCell = self.workModules_tab.cellForRow(at: index) as! QuotationWorkSchdulCell
                let moduleName = cell.moduleNme.text ?? ""
                let modDesc = cell.moduleDescription.text ?? ""
                let strDate = cell.timePeriod_tfld.text ?? ""
                if moduleName.isEmpty{
                    msg = "Please enter module name"
                }else if modDesc.isEmpty{
                    msg = "Please enter module description"
                }else if strDate.isEmpty{
                    msg = "Please select module date"
                }else{
                    Module_Names[index.row] = moduleName
                    Module_Descriptions[index.row] = modDesc
                    let firstDateStr = strDate.components(separatedBy: " ").first
                    let lastDateStr = strDate.components(separatedBy: " ").last
                    let StartDate = formatter.date(from: firstDateStr ?? "")
                    let EndDate = formatter.date(from: lastDateStr ?? "")
                    let StartDateStr = dateFormatter.string(from: StartDate!)
                    let EndDateStr = dateFormatter.string(from: EndDate!)
                    let cellData = ["module": moduleName, "description": modDesc, "start_date": StartDateStr, "end_date": EndDateStr]
                    workModuleData[index.row] = cellData
                }
            }
            for i in 0...(quantityValue-1){
                let index = IndexPath(row: i, section: 0)
                let cell: QuotationQuantityCell = self.quantityDescription_tab.cellForRow(at: index) as! QuotationQuantityCell
                if cell.title_txtfld.text!.isEmpty{
                    msg = "Please enter title in quantity table"
                }else {
                    if comefrom == "CustomerEdit"{
                        
                        workFlowArray.append(["title": (cell.title_txtfld.text ?? ""), "data": QuantityData[index.row]])
                    }else{
                        
                    workFlowArray.append(["title": (cell.title_txtfld.text ?? ""), "data": QuantityData[index.row]])
                    }
                }
            }
        }
        if msg != ""{
            self.showDefaultAlert(Message: msg)
        }else{
            if comefrom == "CustomerEdit"{
                hitModifyIssueQuotation(QuotationIDStr : QuotationIDStrVal , customerId : customerId , quotationId: quotationId)
            }else{
                PaymentData.append(["first": (firstInstallment.text?.replacingOccurrences(of: " ", with: "") ?? ""), "second": Secondinstall.text?.replacingOccurrences(of: " ", with: "") ?? "", "third": thirdinstall.text?.replacingOccurrences(of: " ", with: "") ?? "" ])
                print(PaymentData)
                print(workFlowArray)
                print(workModuleData)
                hitAddIssueQuotation(customerId: customerId, quotationId: quotationId)
            }
            
        }
    }
    
}
//MARK: TABLE VIEWs
extension AddIssueQuotationViewController: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: TABLEVIEWS No of ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == offerVldty_Tab{
            return durationOptn.count
        }else if tableView == quantityDescription_tab{
            if comefrom == "CustomerEdit" && noeditQuantRows == false{
                noeditQuantRows = true
                return EditViewModel.issueModel?.workflow?.count ?? 0
            }else{
            return QuantityData.count
            }
        }else{
            if comefrom == "CustomerEdit" && workmodRows == false{
                workmodRows = true
                if (modelData?.workSchedule?.count ?? 0) == 0 {
                    DeleteModButt.isUserInteractionEnabled = false
                }else{
                    DeleteModButt.isUserInteractionEnabled = true
                }
                return modelData?.workSchedule?.count ?? 0
//
            }else{
                if workModuleCount == 0 {
                    DeleteModButt.isUserInteractionEnabled = false
                }else{
                    DeleteModButt.isUserInteractionEnabled = true
                }
            return workModuleCount
        }
        }
    }
    //MARK: TableVIEW CELL for ROW AT
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == offerVldty_Tab{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = durationOptn[indexPath.row]
            return cell!
        }else if tableView == quantityDescription_tab{
        let cell: QuotationQuantityCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QuotationQuantityCell
            if comefrom == "CustomerEdit" && noeditQuant == false{
                noeditQuant = true
                cell.title_txtfld.text = EditViewModel.issueModel?.workflow?[indexPath.row].title ?? ""
                self.QuantityDatas = self.EditViewModel.issueModel?.workflow?.map({$0.data } ) as! [[WFDatum]]
                cell.detailsView.delegate = self
                cell.detailsView.dataSource = self
                cell.detailsView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
                cell.detailsView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
                    cell.addBtn.tag = indexPath.row
                    cell.addBtn.addTarget(self, action: #selector(addQuanttyDetails(_:)), for: .touchUpInside)
                    cell.deleteBtn.tag = indexPath.row
                    cell.deleteBtn.addTarget(self, action: #selector(deleteQuanttyDetails(_:)), for: .touchUpInside)
                    cell.editBtn.tag = indexPath.row
                    cell.editBtn.addTarget(self, action: #selector(editQuanttyDetails(_:)), for: .touchUpInside)
                    cell.detailsView.tag = indexPath.row
                    quantRow = indexPath.row
                    if(QuantityDatas.count < quantRow+1){
                        cell.detailViewHeight.constant = 80
                    }else{
                        cell.detailViewHeight.constant = CGFloat(80 + (QuantityDatas[quantRow].count * 44))
                    }
                    cell.detailsView.reloadData()
                    return cell
            }else{
        cell.detailsView.delegate = self
        cell.detailsView.dataSource = self
        cell.detailsView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        cell.detailsView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
            cell.addBtn.tag = indexPath.row
            cell.addBtn.addTarget(self, action: #selector(addQuanttyDetails(_:)), for: .touchUpInside)
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(deleteQuanttyDetails(_:)), for: .touchUpInside)
            cell.editBtn.tag = indexPath.row
            cell.editBtn.addTarget(self, action: #selector(editQuanttyDetails(_:)), for: .touchUpInside)
            cell.detailsView.tag = indexPath.row
            quantRow = indexPath.row
            if(QuantityData.count < quantRow+1){
                cell.detailViewHeight.constant = 80
            }else{
                cell.detailViewHeight.constant = CGFloat(80 + (QuantityData[quantRow].count * 44))
            }
            cell.detailsView.reloadData()
            return cell
            }
        }
        else {
            let cell: QuotationWorkSchdulCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QuotationWorkSchdulCell
            
            if comefrom == "CustomerEdit" && noeditCustomer == false{
//
                cell.moduleNme.text = modelData.workSchedule?[indexPath.row].module ?? ""
                cell.moduleDescription.text = modelData.workSchedule?[indexPath.row].workScheduleDescription ?? ""
                cell.timePeriod_tfld.text = String(((modelData.workSchedule?[indexPath.row].startDate ?? "").dateToString).prefix(10)) + " - " + ((modelData.workSchedule?[indexPath.row].endDate ?? "").dateToString).prefix(10)
                
                
                let dates = String(((modelData.workSchedule?[indexPath.row].startDate ?? "").dateToString).prefix(10)) + " - " + ((modelData.workSchedule?[indexPath.row].endDate ?? "").dateToString).prefix(10)
                moduleNumSelected = indexPath.row
                Module_Ranges[moduleNumSelected] = dates
                if(workModuleCount != 0){
                    for i in 0...workModuleData.count-1{
                        let index = IndexPath(row: i, section: 0)
                        Module_Names[index.row] = cell.moduleNme.text ?? ""
                        Module_Descriptions[index.row] = cell.moduleDescription.text ?? ""
                    }
                }
                cell.selectDateBtn.tag = indexPath.row
                cell.selectDateBtn.addTarget(self, action: #selector(selectModuleTimeRange(_:)), for: .touchUpInside)
                if ((indexPath.row) == (modelData?.workSchedule?.count ?? 0) - 1 ) {
                    noeditCustomer = true
                    
                }
                
                return cell
            }else{
                cell.moduleNme.text = Module_Names[indexPath.row]
                cell.moduleDescription.text = Module_Descriptions[indexPath.row]
                cell.timePeriod_tfld.text = Module_Ranges[indexPath.row]
                cell.selectDateBtn.tag = indexPath.row
                cell.selectDateBtn.addTarget(self, action: #selector(selectModuleTimeRange(_:)), for: .touchUpInside)
                return cell
            }
            
           
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == offerVldty_Tab{
            offerVldtyLbl.text =  durationOptn[indexPath.row]
            offerVldty_Tab.isHidden = true
            vldtyTabHeight.constant = 0
        }else if tableView == workModules_tab{
            moduleNumSelected = indexPath.row
        }
    }
}


//MARK: SPREADSHEET Delegates
extension AddIssueQuotationViewController: SpreadsheetViewDelegate, SpreadsheetViewDataSource{
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        
        return header.count
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        if comefrom == "CustomerEdit" && noeditCustomerrow == false{
            noeditCustomerrow = true
            if(QuantityDatas.count < quantRow+1){
                return 1
            }else {
                return 1 + QuantityDatas[quantRow].count
            }
        }else{
        if(QuantityData.count < quantRow+1){
            return 1
        }else {
            return 1 + QuantityData[quantRow].count
        }
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
           // print("\n" + QuantityData[spreadsheetView.tag][indexPath.row - 1].quantDataEle//[indexPath.column])
            
            if comefrom == "CustomerEdit" && noeditCustomerSP == false{
//                if QuantityDatas.count-1 > indexPath.row{
//                    noeditCustomerSP = true
//                }
               // QuantityData[quantRow].append(contentsOf: [])
                let srNo = QuantityDatas[quantRow][indexPath.row - 1].srNo ?? ""
                let itemName = QuantityDatas[quantRow][indexPath.row - 1].itemName ?? ""
                let datDesc = QuantityDatas[quantRow][indexPath.row - 1].datumDescription ?? ""
                let quantity = QuantityDatas[quantRow][indexPath.row - 1].quantity ?? ""
                let price = QuantityDatas[quantRow][indexPath.row - 1].price ?? ""
                let totalPrice = QuantityDatas[quantRow][indexPath.row - 1].totalPrice ?? ""
                let dataValue = [srNo, itemName, datDesc, quantity, price, totalPrice]
                if QuantityData[quantRow].count < indexPath.row{
                let quantDetailEnterd = ["srNo": srNo,"itemName": itemName, "description": datDesc, "quantity": quantity, "price": price, "total_Price": totalPrice]
                QuantityData[quantRow].append(quantDetailEnterd)
                }
                cell.label.text = dataValue[indexPath.column]
                return cell

            }
            else{
                cell.label.text = QuantityData[spreadsheetView.tag][indexPath.row - 1][QuantDictElement[indexPath.column]]
            return cell
                }
    }
    }

    /// Delegate

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row != 0){
            dataNumSelected = indexPath.row - 1
            quantRow = spreadsheetView.tag
        }
    }
}


//MARK: IMAGE PICKER
extension AddIssueQuotationViewController : ImagePickerDelegete {
//
    func disFinishPicking(imgData: Data, img: UIImage) {
        imageData = img.jpegData(compressionQuality: 0.6)!
        imageName = GenerateUniqueImageName()
        imageParam = "image"
        imageType = "jpeg/image"
        uploadedFileView.isHidden = false
        fileHeight.constant = 140
        fileImage.image = img
        fileName.text = imageName
        browseBtn.isHidden = true
    }
}



extension AddIssueQuotationViewController{
    
    func addModEdit(){
        for i in 0...(self.EditViewModel.issueModel?.workSchedule?.count ?? 0) - 1{
        if workModuleData.count>0{
            
            for i in 0...workModuleData.count-1{
                let index = IndexPath(row: i, section: 0)
                let cell: QuotationWorkSchdulCell = self.workModules_tab.cellForRow(at: index) as! QuotationWorkSchdulCell
                let moduleName = cell.moduleNme.text ?? ""
                let modDesc = cell.moduleDescription.text ?? ""
                let strDate = cell.timePeriod_tfld.text ?? ""
                if moduleName.isEmpty{
                    view.makeToast("Please enter module name")
                }else if modDesc.isEmpty{
                    view.makeToast("Please enter module description")
                }else if strDate.isEmpty{
                    view.makeToast("Please select module date")
                }else{
                    Module_Names[index.row] = moduleName
                    Module_Descriptions[index.row] = modDesc
                }
            }
        }
            workModuleCount += 1
            workModuleData.append(["module": "", "description": "", "start_date": "", "end_date": ""])
            Module_Ranges.append("")
            Module_Names.append("")
            Module_Descriptions.append("")
            workModules_tab.reloadData()
            updateTableHeight(tableName: workModules_tab, tableHeight: moduleTabHeight)
        }
    }
    
    
    
    
    
    func imageautosetEdit(){
        imageName = EditViewModel.issueModel?.image ?? ""
        imageParam = "image"
        imageType = "jpeg/image"
        uploadedFileView.isHidden = false
        fileHeight.constant = 140
        let url = URLS.QuotationImgUrl(EditViewModel.issueModel?.image ?? "").getDescription()
        fileImage.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
        fileName.text = imageName
        browseBtn.isHidden = true
    }
    

    func quantData(){
        if(quantity_txtFld.text != nil){
            quantityValue = Int(quantity_txtFld.text ?? "0") ?? 0
            var qdCount = QuantityData.count
            if(quantityValue > qdCount){
                for i in qdCount...quantityValue-1{
                    QuantityData.append([])
                }
            }else if quantityValue < qdCount{
                repeat{
                    QuantityData.remove(at: qdCount-1)
                    qdCount = qdCount-1
                }while qdCount > quantityValue
            }
            quantityDescription_tab.reloadData()
            updateTableHeight(tableName: quantityDescription_tab, tableHeight: quantTabHeight)
        }
    }
    
    func getdateAutoforEdit(date : String){
       
        workModules_tab.reloadData()
        updateTableHeight(tableName: workModules_tab, tableHeight: moduleTabHeight)
    }
    
    
    func SetdataforEdit(){
//        dataNumSelected = 0
        if workModuleCount != 0{
            addModEdit()
        }
        
        title_txtFld.text = EditViewModel.issueModel?.title ?? ""
        Warrenty_txtFld.text = EditViewModel.issueModel?.warrenty ?? ""
        offerVald_txtFld.text = EditViewModel.issueModel?.offerValidity ?? ""
        if EditViewModel.issueModel?.offerValidity != ""{
            if let first = (EditViewModel.issueModel?.offerValidity ?? "").components(separatedBy: " ").first{
            offerVald_txtFld.text = "\(first)"
            
            }
         if let second = ((EditViewModel.issueModel?.offerValidity ?? "").components(separatedBy: " ").last){
                    offerVldtyLbl.text = "\(second)"
         }
        }
        updateTableHeight(tableName: workModules_tab, tableHeight: moduleTabHeight)
        price_txtFld.text = "\(EditViewModel.issueModel?.price ?? 0)"
        vat_txtFld.text = EditViewModel.issueModel?.vat ?? ""
        totalprice.text = "\(EditViewModel.issueModel?.totalPrice ?? 0)"
        quantity_txtFld.text = "\(EditViewModel.issueModel?.quantity ?? 0)"
        quantData()
        addModEdit()
        
        scopeOfWork_txtView.text = EditViewModel.issueModel?.scopeOfWork ?? ""
        exclusion_txtView.text = EditViewModel.issueModel?.exclusion ?? ""
        DreeshsahTC_txtView.text = EditViewModel.issueModel?.dreeshahTerms ?? ""
        if ((EditViewModel.issueModel?.sellerTerms ?? "") == ""  ){
            SellerTC_txtView.text = "nil"
        }else{
            SellerTC_txtView.text = EditViewModel.issueModel?.sellerTerms ?? ""
        }
       
        switch (EditViewModel.issueModel?.paymentTerms ?? "") {
        case "One Time Payment":
            radioController.defaultButton = oneTimePay_btn
            paymentTermsValue = "One Time Payment"
            
            
        case "Two Installments":
            radioController.defaultButton = twoInstallmnt_btn
            paymentTermsValue = "Two Installments"
     
            
        default:
            radioController.defaultButton = threeInstallmnt_btn
            paymentTermsValue = "Three Installments"
           
        }
        imageautosetEdit()
        
        
        }
}


extension AddIssueQuotationViewController{
    func hitAddIssueQuotation(customerId : String , quotationId:String){
        
        var workScheduleJson = ""
        var workFlowJson = ""
        
        do {
            workScheduleJson = try! json(from: workModuleData)
            workFlowJson = try! json(from: workFlowArray)
        } catch { print(error) }
        
        viewModel.apiAddIssueQuotation(customer_id: customerId, customer_quotation_id: quotationId, title: title_txtFld.text ?? "", warrenty: Warrenty_txtFld.text ?? "", offer_validity: offerValidityValue, price: price_txtFld.text ?? "", quantity: quantity_txtFld.text ?? "", vat: vat_txtFld.text ?? "", workflow: convertIntoJSONString(arrayObject: workFlowArray)!, scope_of_work: scopeOfWork_txtView.text ?? "", exclusion: exclusion_txtView.text ?? "", payment_terms: paymentTermsValue, work_schedule: convertIntoJSONString(arrayObject: workModuleData)!, tcForDreeshah: DreeshsahTC_txtView.text ?? "", tcForSeller: SellerTC_txtView.text ?? "", imageData: imageData, imageType: imageType, imageName: imageName, imageParam: imageParam , paymenttype: paymentTermsValue ,total_price: totalprice.text ?? "", payment_installments: convertIntoJSONString(arrayObject: PaymentData)!) { (isSuccess, msg) in
            if(isSuccess){
                
                self.showAlertWithAction(Title: "Dreeshah", Message: msg, ButtonTitle: "OK") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                self.showDefaultAlert(Message: msg)
            }
            
        }
      
    }
    
    func hitModifyIssueQuotation(QuotationIDStr : String ,customerId : String , quotationId:String  ){
        viewModel.apiEditIssueQuotation(customer_id: customerId, quotation_id: QuotationIDStr, customer_quotation_id: quotationId, title: title_txtFld.text ?? "", warrenty: Warrenty_txtFld.text ?? "", offer_validity: offerValidityValue, price: price_txtFld.text ?? "", quantity: quantity_txtFld.text ?? "", vat: vat_txtFld.text ?? "", workflow: convertIntoJSONString(arrayObject: workFlowArray)!, scope_of_work: scopeOfWork_txtView.text ?? "", exclusion: exclusion_txtView.text ?? "", payment_terms: paymentTermsValue, work_schedule: convertIntoJSONString(arrayObject: workModuleData)!, tcForDreeshah: DreeshsahTC_txtView.text ?? "", tcForSeller: SellerTC_txtView.text ?? "", imageData: imageData, imageType: imageType, imageName: imageName, imageParam: imageParam ,paymenttype: paymentTermsValue , total_price: totalprice.text ?? "" , payment_installments: convertIntoJSONString(arrayObject: PaymentData)! ) { (isSuccess, msg) in
            if(isSuccess){
                
                self.showAlertWithAction(Title: "Dreeshah", Message: msg, ButtonTitle: "OK") {
                    self.navigationController?.popViewController(animated: true)
            }
            }
            else{
                self.showDefaultAlert(Message: msg)
            }
            
        }
    }
    
        func hitApiIssueQuotationsDetails(QuotationIDStr : String ){
            Indicator.shared.showProgressView(self.parent?.view ?? self.view)
            
            EditViewModel.apiIssueQuotationDetailfunc(quotationID: QuotationIDStr)    {(isSuccess , message) in
                Indicator.shared.hideProgressView()
                if isSuccess{
                    self.modelData = self.EditViewModel.issueModel
                    //self.QuantityData = self.EditViewModel.issueModel?.workflow?.map({$0.data } ) as! [[[String: Any]]]
                    self.QuantityDatas = self.EditViewModel.issueModel?.workflow?.map({$0.data } ) as! [[WFDatum]]
                    if self.comefrom == "CustomerEdit" && self.APIBOOL == false{
                        self.APIBOOL = true
                    self.SetdataforEdit()
                    }else{
                        print("No Set Data")
                    }
                }else{
                   
                    self.view.makeToast(message , position : .center)
                }
            }
        }
}
