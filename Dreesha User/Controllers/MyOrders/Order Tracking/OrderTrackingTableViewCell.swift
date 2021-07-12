//
//  OrderTrackingTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 24/06/21.
//

import UIKit

class OrderTrackingTableViewCell: UITableViewCell {

    //MARK: Outlets
    //MARK: Outlets
        @IBOutlet weak var OrderImg1: UIImageView!
        
        @IBOutlet weak var ProductTitle: UILabel!
        @IBOutlet weak var AedVal: UILabel!
        

    @IBOutlet weak var QuantityLabel: UILabel!
    
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        OrderImg1.layer.cornerRadius = 8
        OrderImg1.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
