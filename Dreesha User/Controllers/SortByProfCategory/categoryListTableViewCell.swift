//
//  categoryListTableViewCell.swift
//  Dreesha User
//
//  Created by promatics on 3/1/1400 AP.
//

import UIKit

class categoryListTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet weak var categoryNameLbl: UILabel!
    @IBOutlet weak var radiobtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
