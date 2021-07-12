//
//  CancelledOrdersTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 27/05/21.
//

import UIKit

class CancelledOrdersTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var imageViewOrders: SetImage!
    
    @IBOutlet weak var titleOrder: UILabel!
    
    @IBOutlet weak var PhoneNoOrders: UILabel!
    @IBOutlet weak var ViewDetailsBtn: UIButton!
    @IBOutlet weak var AED_Val: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
