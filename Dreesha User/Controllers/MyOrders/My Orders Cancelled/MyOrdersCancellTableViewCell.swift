//
//  MyOrdersCancellTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 12/03/21.
//

import UIKit

class MyOrdersCancellTableViewCell: UITableViewCell {

    @IBOutlet weak var CancelImgView: UIImageView!
    
    @IBOutlet weak var OrderIdVal: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var OrderTitle: UILabel!
    @IBOutlet weak var SarLAbel: UILabel!
    
    @IBOutlet weak var OrderAgainBtn: UIButton!
    
    @IBOutlet weak var ViewDtlBtn: UIButton!
    @IBOutlet weak var CancelLbl: UILabel!
    
    @IBOutlet weak var ReasonLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
