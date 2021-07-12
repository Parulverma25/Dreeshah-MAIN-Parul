//
//  ProfessionalsTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 06/05/21.
//

import UIKit

class ProfessionalsTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var imageViewProf: SetImage!
    @IBOutlet weak var ProfessionalsProfileImageView: SetImage!
    @IBOutlet weak var PhoneNoVal: UILabel!
    @IBOutlet weak var TitleVal: UILabel!
    @IBOutlet weak var CategoryTitle: UILabel!
    @IBOutlet weak var locationVal: UILabel!
    @IBOutlet weak var DescriptionVal: UILabel!
    @IBOutlet weak var SendMessageBtn: UIButton!
    @IBOutlet weak var SendRequestBtn: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
