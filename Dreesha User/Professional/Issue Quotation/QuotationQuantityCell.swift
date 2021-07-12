//
//  QuotationQuantityCell.swift
//  Dreesha User
//
//  Created by Promatics on 18/05/21.
//

import UIKit
import SpreadsheetView

class QuotationQuantityCell: UITableViewCell {

    @IBOutlet weak var title_txtfld: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var detailsView: SpreadsheetView!
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
