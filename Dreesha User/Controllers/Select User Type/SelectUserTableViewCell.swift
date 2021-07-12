//
//  SelectUserTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 22/03/21.
//

import UIKit

class SelectUserTableViewCell: UITableViewCell {
//MArk Outlets
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Label1: UILabel!
    
    @IBOutlet weak var CheckBtn: UIButton!
    
    @IBOutlet weak var colorView: SetView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
