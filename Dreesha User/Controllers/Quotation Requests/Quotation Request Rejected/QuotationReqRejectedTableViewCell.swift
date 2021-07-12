//
//  QuotationReqRejectedTableViewCell.swift
//  Dreesha User
//
//  Created by Apple on 17/03/21.
//

import UIKit

class QuotationReqRejectedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var refrenceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var requestStatusLbl: SetLabel!
    @IBOutlet weak var viewDetailsBtn: UIButton!
    @IBOutlet weak var ImgView: SetImage!
    
    @IBOutlet weak var rejectReason: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
