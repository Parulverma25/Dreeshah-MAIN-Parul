//
//  quantityDetailTabCell.swift
//  Dreesha User
//
//  Created by Promatics on 22/05/21.
//

import UIKit
import SpreadsheetView

class quantityDetailTabCell: UITableViewCell {

    @IBOutlet weak var quantiveheight: NSLayoutConstraint!
    
    @IBOutlet weak var detailsView: SpreadsheetView!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var detailViewHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
