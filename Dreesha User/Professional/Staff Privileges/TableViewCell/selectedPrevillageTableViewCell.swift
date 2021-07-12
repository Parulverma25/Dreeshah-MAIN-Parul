//
//  selectedPrevillageTableViewCell.swift
//  Dreesha User
//
//  Created by promatics on 28/04/21.
//

import UIKit

class selectedPrevillageTableViewCell: UITableViewCell {

    @IBOutlet weak var selectedName: UILabel!
    @IBOutlet weak var readPermission: UIButton!
    @IBOutlet weak var writePermission: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
