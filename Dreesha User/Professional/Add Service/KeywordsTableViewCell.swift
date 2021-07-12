//
//  KeywordsTableViewCell.swift
//  Dreesha User
//
//  Created by promatics on 5/4/21.
//

import UIKit

class KeywordsTableViewCell: UITableViewCell {
    @IBOutlet weak var keywordBtn : UIButton!
    @IBOutlet weak var keywordLbl : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
