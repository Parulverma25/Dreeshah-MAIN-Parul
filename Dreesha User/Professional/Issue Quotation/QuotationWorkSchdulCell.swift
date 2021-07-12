//
//  QuotationWorkSchdulCell.swift
//  Dreesha User
//
//  Created by Promatics on 18/05/21.
//

import UIKit

class QuotationWorkSchdulCell: UITableViewCell {

    
    @IBOutlet weak var moduleNme: SkyFloatingLabelTextField!
    @IBOutlet weak var moduleDescription: SkyFloatingLabelTextField!
    @IBOutlet weak var timePeriod_tfld: SkyFloatingLabelTextField!
    @IBOutlet weak var selectDateBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
