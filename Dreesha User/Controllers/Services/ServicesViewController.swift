//
//  ServicesViewController.swift
//  Dreesha User
//
//  Created by Promatics on 28/04/21.
//

import UIKit

class ServicesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Outlets
    
    @IBOutlet weak var UpperLabel: UILabel!
    @IBOutlet weak var TotalResultsLbl: UILabel!
    @IBOutlet weak var ServicesTblView: UITableView!
    
    //MARK: VARIABLES
    
    var ServiceviewModel = HomeViewModel()
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ServicesTblView.dataSource = self
        ServicesTblView.delegate = self
        ServicesTblView.reloadData()
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Services")
        hitApiServicesList()
       
        
    }
    
    @IBAction func SortTapBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SortByPopUpViewController") as! SortByPopUpViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.completionBlock = {
            value in
            print(value)
//            self.offset = 0
//            self.viewModel.model = []
//            self.isFetching = false
//            hitApiServicesList()
//            self.sortByProducts(sort: "price", sortBy: value, offset: String(self.offset))
        }
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func FilterTapBtn(_ sender: UIButton) {
        
    }
    
    
    
    
    
    @IBAction func BookBtnTapp(_ sender: UIButton) {
//        let vc =  UIStoryboard(name:"ServicesStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddAppointmentViewController")
//         vc.hidesBottomBarWhenPushed = true
        let vc1 = storyboard?.instantiateViewController(identifier: "AddAppointmentViewController") as! AddAppointmentViewController
        vc1.ServiceIdStr = ServiceviewModel.Servicemodel[sender.tag].id ?? ""
        vc1.rqstId = generatenumber(length: 8)
        vc1.subject = ServiceviewModel.Servicemodel[sender.tag].serviceName ?? ""
        vc1.professionalId = ServiceviewModel.Servicemodel[sender.tag].professionalID?.id ?? ""
         navigationController?.pushViewController(vc1, animated: true)
        
    }
    
    @IBAction func QuotationBtnTapp(_ sender: UIButton) {

        let vc1 = storyboard?.instantiateViewController(identifier: "GetInstantQuotationViewController") as! GetInstantQuotationViewController
        vc1.Professional_service_idStr = ServiceviewModel.Servicemodel[sender.tag].id ?? ""
        vc1.quotaionNo = generatenumber(length: 8)
        vc1.Date = Singleton.sharedInstance.dateFormatChange(date: Date().toDateStr() ?? "", oldFormat: "yyyy-MM-dd HH:mm:ss", newFormat: "dd MMM yyyy")
        vc1.subject = ServiceviewModel.Servicemodel[sender.tag].serviceName ?? ""
        vc1.salesRep = (ServiceviewModel.Servicemodel[sender.tag].professionalID?.firstName ?? "") + " \(ServiceviewModel.Servicemodel[sender.tag].professionalID?.lastName ?? "")"
        vc1.professionalId = ServiceviewModel.Servicemodel[sender.tag].professionalID?.id ?? ""
        vc1.branchNames = ServiceviewModel.Servicemodel[sender.tag].professionalID?.branches?.map({$0.branchNameEn ?? ""}) ?? []
         navigationController?.pushViewController(vc1, animated: true)
        
    }
    

}

//MARK: TableView Dlegate Functions
extension ServicesViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceviewModel.getServiceListData()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ServicesTableViewCell
        cell.ServiceNameLbl.text = ServiceviewModel.getServiceListData()?[indexPath.row].serviceName ?? ""
        cell.LocationLbl.text = ServiceviewModel.getServiceListData()?[indexPath.row].country?.joined(separator: ",")
        cell.DescriptionLbl.text = ServiceviewModel.getServiceListData()?[indexPath.row].serviceDescription ?? ""
        let imageUrl = URLS.ServiceImgUrl(ServiceviewModel.getServiceListData()?[indexPath.row].serviceImage ?? "").getDescription()
        cell.ServiceImgView1.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placeholding"))
        let imageUrl2 = URLS.profileImageUrl(ServiceviewModel.getServiceListData()?[indexPath.row].professionalID?.profileImage ?? "").getDescription()
        cell.ProfileImageView1.sd_setImage(with: URL(string : imageUrl2),  placeholderImage: #imageLiteral(resourceName: "Placeholding"))
        
        
        let serviceCate = ServiceviewModel.getServiceListData()?[indexPath.row].serviceCategory?.map({$0.name ?? ""})
        
        cell.CategoryLbl.text =  serviceCate?.joined(separator: ",")
        cell.PhoneNoLbl.text =  ServiceviewModel.getServiceListData()?[indexPath.row].professionalID?.contactDetails?.mobileNumber ?? ""
        cell.SarValLbl.text = "AED \(ServiceviewModel.getServiceListData()?[indexPath.row].price ?? 0) "
        cell.BookAppointmentbtn.tag = indexPath.row
        cell.BookAppointmentbtn.addTarget(self, action: #selector(BookBtnTapp(_:)), for: .touchUpInside)
        cell.GetQuotationBtn.tag = indexPath.row
        cell.GetQuotationBtn.addTarget(self, action: #selector(QuotationBtnTapp(_:)), for: .touchUpInside)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ServiceDtlsViewController") as! ServiceDtlsViewController
        vc.serviceID = ServiceviewModel.getServiceListData()?[indexPath.row].id ?? ""
        vc.serviceName = ServiceviewModel.getServiceListData()?[indexPath.row].serviceName ?? ""
        vc.branchName = ServiceviewModel.Servicemodel[indexPath.row].professionalID?.branches?.map({$0.branchNameEn ?? ""}) ?? []
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ServiceviewModel.isMoreData{
            self.offset += 10
            hitApiServicesList()
        }
    }
    
    
}
//MARK:- API Call
extension ServicesViewController{

func hitApiServicesList(){
    
    Indicator.shared.showProgressView(self.parent?.view ?? self.view)
    ServiceviewModel.apiServiceList(limit: "10", offset: String(self.offset)){(isSuccess , message) in
        Indicator.shared.hideProgressView()
        if isSuccess{
            self.TotalResultsLbl.text = "\(self.ServiceviewModel.totalcount) results found"
            self.ServicesTblView.reloadData()
        }else{
            self.view.makeToast(message , position : .center)
        }
    }
}



}
