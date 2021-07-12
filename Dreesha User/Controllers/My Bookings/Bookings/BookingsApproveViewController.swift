//
//  BookingsApprovedViewController.swift
//  Dreesha User
//
//  Created by Promatics on 27/04/21.
//

import UIKit

class BookingsApproveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     
     //Mark  Outlets
     @IBOutlet weak var ApprovedTableView: UITableView!
     
    //MARK: VARAIBLES
    
    var viewModel = BookingsAllViewModel()
    var offset = 0
    var filtervalstr = ""
    var searchvalStr = ""
     
     override func viewDidLoad() {
         super.viewDidLoad()
         ApprovedTableView.delegate=self
         ApprovedTableView.dataSource=self
         ApprovedTableView.reloadData()
     }
    override func viewWillAppear(_ animated: Bool) {
        hitApiBookingsListSearch(Search: searchvalStr, Filter: filtervalstr)
    }
    
    @IBAction func ViewDtlbuttonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "BookingDetailViewController" ) as! BookingDetailViewController
        vc.Namestr = viewModel.getBookingListData()?.result[sender.tag]?.userID?.firstName ?? ""
        vc.DateStr = viewModel.getBookingListData()?.result[sender.tag]?.date ?? ""
        vc.LocationStr = viewModel.getBookingListData()?.result[sender.tag]?.location ?? ""
        vc.SubjectStr = viewModel.getBookingListData()?.result[sender.tag]?.subject ?? ""
        vc.ServiceDtlDescr = viewModel.getBookingListData()?.result[sender.tag]?.serviceID?.serviceDescription ?? ""
        vc.PuproseStr = viewModel.getBookingListData()?.result[sender.tag]?.serviceID?.serviceDescription ?? ""
        vc.ImgUrl = (URLS.profileImageUrl(viewModel.getBookingListData()?.result[sender.tag]?.serviceID?.professionalID?.profileImage ?? "" )).getDescription()
        vc.statusStr = viewModel.getBookingListData()?.result[sender.tag]?.status ?? ""
        vc.comefrom = "Approved"
        navigationController?.pushViewController(vc, animated: true)
       
    }
     

 }
 //Mark Table View Delegates func
 extension BookingsApproveViewController{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getBookingListData()?.result.count ?? 0
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BookingsApproveTableViewCell
        cell.Label1.text = viewModel.getBookingListData()?.result[indexPath.row]?.userID?.firstName ?? ""
        cell.Label2.text = viewModel.getBookingListData()?.result[indexPath.row]?.date ?? ""
        cell.Label3.text = viewModel.getBookingListData()?.result[indexPath.row]?.location ?? ""
        cell.ButtProcess.text = viewModel.getBookingListData()?.result[indexPath.row]?.status ?? ""
        let imageUrl = URLS.profileImageUrl(viewModel.getBookingListData()?.result[indexPath.row]?.serviceID?.professionalID?.profileImage ?? "").getDescription()
        cell.IMG1.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
        cell.ViewDtlBtn.tag = indexPath.row
        cell.ViewDtlBtn.addTarget(self, action: #selector(ViewDtlbuttonTapped(_:)), for: .touchUpInside)

        
        switch (cell.ButtProcess.text) {
        case "approved":
            cell.ButtView.backgroundColor = #colorLiteral(red: 0.1564441919, green: 0.6549337506, blue: 0.2705431581, alpha: 1)
        case "pending":
            cell.ButtView.backgroundColor =  #colorLiteral(red: 0.8627645373, green: 0.2078584731, blue: 0.2705822289, alpha: 1)
        case "completed":
            cell.ButtView.backgroundColor =  #colorLiteral(red: 0, green: 0.4824024439, blue: 0.9998757243, alpha: 1)
        default:
            cell.ButtView.backgroundColor = .black
        }
        return cell
     }
 }
//MARK:- API Call
extension BookingsApproveViewController{
    func hitApiBookingsListSearch(Search : String , Filter : String){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiBookingListfunc(limit: "10", offset: "0",Search: Search ,Filter: Filter,Status: "approved" ){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                
                self.ApprovedTableView.reloadData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
}
