//
//  PaymentOptionsTableViewCell.swift
//  Dreeshah
//
//  Created by promatics on 19/02/21.
//

import UIKit

class PaymentOptionsTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var paymentImage: UIImageView!
    @IBOutlet weak var cardNo: UILabel!
    @IBOutlet weak var expiry: UILabel!
    @IBOutlet weak var outerView: SetView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
