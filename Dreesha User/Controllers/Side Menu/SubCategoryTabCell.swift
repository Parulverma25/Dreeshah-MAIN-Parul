//
//  SubCategoryTabCell.swift
//  Dreesha User
//
//  Created by Promatics on 30/04/21.
//

import UIKit

class SubCategoryTabCell: UITableViewCell {
    @IBOutlet weak var subCategory_Lbl: UILabel!
    
    @IBOutlet weak var subCategory_Btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
