//
//  BookingDetailViewController.swift
//  Dreesha User
//
//  Created by Promatics on 15/03/21.
//

import UIKit

class BookingDetailViewController: UIViewController {

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Book Appointment")
        setdata(imageUrl: ImgUrl)
        
            switch (comefrom) {
            case "Approved":
                StatusView.backgroundColor = #colorLiteral(red: 0.1564441919, green: 0.6549337506, blue: 0.2705431581, alpha: 1)
                StatusView.isHidden = false
            case "Cancelled":
                StatusView.isHidden = true
            case "Delievered":
                StatusView.backgroundColor =  #colorLiteral(red: 0, green: 0.4824024439, blue: 0.9998757243, alpha: 1)
                StatusView.isHidden = false
            default:
                StatusView.backgroundColor = .black
                StatusView.isHidden = true
            
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
    
    
}

