//
//  CerImagesTableViewCell.swift
//  Dreesha User
//
//  Created by promatics on 21/04/21.
//

import UIKit

class CerImagesTableViewCell: UITableViewCell {

    @IBOutlet weak var imae: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
