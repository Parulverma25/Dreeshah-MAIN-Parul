//
//  BookAppointmentPendingButtonViewController.swift
//  Dreeshah
//
//  Created by Promatics on 20/03/21.
//

import UIKit

class BookAppointmentPendingButtonViewController: UIViewController {

    //MARK: OUTLETS
    @IBOutlet weak var ImageViewBook: UIImageView!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var LocationLbl: UILabel!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var SubjectValLbl: UILabel!
    @IBOutlet weak var ServiceDtlDescriptionLbl: UILabel!
    @IBOutlet weak var PurposeLbl: UILabel!
    @IBOutlet weak var StatusView: SetView!
    @IBOutlet weak var StatusLbl: UILabel!
    @IBOutlet weak var ApproveBtn: SetButton!
    @IBOutlet weak var DisapproveBtn: SetButton!
    
    
    //MARK: VARIABLES
    var Namestr = ""
    var LocationStr = ""
    var DateStr = ""
    var SubjectStr = ""
    var ServiceDtlDescr = ""
    var PuproseStr = ""
    var ImgUrl = ""
    var comefrom = ""
    var statusStr = ""
    var bookingID = ""
    var viewModel = AcceptRejectAppointmentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Book Appointment")
        setdata(imageUrl: ImgUrl)
        
            switch (comefrom) {
            case "approved":
                StatusView.backgroundColor = #colorLiteral(red: 0.1564441919, green: 0.6549337506, blue: 0.2705431581, alpha: 1)
                StatusView.isHidden = false
                ApproveBtn.isHidden = true
                DisapproveBtn.isHidden = true
            case "completed":
                StatusView.backgroundColor =  #colorLiteral(red: 0, green: 0.4824024439, blue: 0.9998757243, alpha: 1)
                StatusView.isHidden = false
                ApproveBtn.isHidden = true
                DisapproveBtn.isHidden = true
            case "pending":
                StatusView.backgroundColor =  #colorLiteral(red: 0.8627645373, green: 0.2078584731, blue: 0.2705822289, alpha: 1)
                StatusView.isHidden = false
                ApproveBtn.isHidden = false
                DisapproveBtn.isHidden = false
            case "rejected":
                StatusView.backgroundColor =  #colorLiteral(red: 0.8627645373, green: 0.2078584731, blue: 0.2705822289, alpha: 1)
                StatusView.isHidden = false
                ApproveBtn.isHidden = true
                DisapproveBtn.isHidden = true
            default:
                StatusView.backgroundColor = .black
                StatusView.isHidden = true
                ApproveBtn.isHidden = true
                DisapproveBtn.isHidden = true
            
        }
        
    }

    func setdata(imageUrl : String){
        NameLbl.text = Namestr
        LocationLbl.text = LocationStr
        DateLbl.text = DateStr
        SubjectValLbl.text = SubjectStr
        ServiceDtlDescriptionLbl.text = ServiceDtlDescr
        PurposeLbl.text = PuproseStr
        StatusLbl.text = statusStr
        
        ImageViewBook.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
        
    }
    
    //MARK:- IBAction
    
    @IBAction func tapApprove(_ sender: Any) {
        hitApiAcceptReject(status: "approved")
    }
    
    
    @IBAction func tapDisapprove(_ sender: Any) {
        hitApiAcceptReject(status: "rejected")
    }
    
    
}


//MARK:- API
extension BookAppointmentPendingButtonViewController{
    func hitApiAcceptReject(status : String){
        viewModel.apiAcceptRejectAppointment(status: status, booking_id: self.bookingID) { (isSuccess, msg) in
            if isSuccess{
                self.navigationController?.popViewController(animated: true)
            }else{
                self.view.makeToast(msg)
            }
        }
    }
}
