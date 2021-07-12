//
//  OrderManagementTableViewCell.swift
//  Dreeshah
//
//  Created by Promatics on 19/03/21.
//

import UIKit

class OrderManagementTableViewCell: UITableViewCell {
    //Mark Outlets
    @IBOutlet weak var Imageview1: SetImage!
    @IBOutlet weak var Label1: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
