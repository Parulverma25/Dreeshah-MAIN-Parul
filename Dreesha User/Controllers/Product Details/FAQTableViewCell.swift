//
//  FAQTableViewCell.swift
//  Dreesha User
//
//  Created by promatics on 3/30/21.
//

import UIKit

class FAQTableViewCell: UITableViewCell {

    @IBOutlet weak var showHideBtn: UIButton!
    @IBOutlet weak var cellHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
