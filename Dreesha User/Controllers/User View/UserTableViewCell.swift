//
//  UserTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 09/03/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    //Mark Outlets
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var LabelView: UILabel!
    
    //Mark ViewDidLoad
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
