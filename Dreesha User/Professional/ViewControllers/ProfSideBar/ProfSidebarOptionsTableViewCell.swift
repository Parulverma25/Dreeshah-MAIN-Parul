//
//  ProfSidebarOptionsTableViewCell.swift
//  Dreeshah
//
//  Created by promatics on 12/03/21.
//

import UIKit

class ProfSidebarOptionsTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var optionName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
