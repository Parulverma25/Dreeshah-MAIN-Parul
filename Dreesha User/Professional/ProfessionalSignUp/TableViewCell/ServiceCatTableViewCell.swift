//
//  ServiceCatTableViewCell.swift
//  Dreesha User
//
//  Created by promatics on 2/22/1400 AP.
//

import UIKit

class ServiceCatTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var serviceName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
