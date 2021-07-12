//
//  OrderListDetailTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 28/06/21.
//

import UIKit

class OrderListDetailTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var AEDLabel: UILabel!
    @IBOutlet weak var QuantityLAbel: UILabel!
    @IBOutlet weak var ViewdetailsBtn: UIButton!
    @IBOutlet weak var OrderImageView: SetImage!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
