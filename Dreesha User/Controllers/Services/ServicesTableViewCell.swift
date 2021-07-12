//
//  ServicesTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 28/04/21.
//

import UIKit

class ServicesTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var ServiceImgView1: SetImage!
    @IBOutlet weak var ProfileImageView1: SetImage!
    @IBOutlet weak var ServiceNameLbl: UILabel!
    @IBOutlet weak var CategoryLbl: UILabel!
    @IBOutlet weak var LocationLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var PhoneNoLbl: UILabel!
    @IBOutlet weak var SarValLbl: UILabel!
    @IBOutlet weak var BookAppointmentbtn: UIButton!
    
    @IBOutlet weak var GetQuotationBtn: UIButton!
    
    @IBOutlet weak var ChatBtn: UIButton!
    
    @IBOutlet weak var LikeBtn: UIButton!
    
    @IBOutlet weak var ShareBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
