//
//  MyOrderinProgressTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 12/03/21.
//

import UIKit

class MyOrderinProgressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgviewprocess: UIImageView!
    @IBOutlet weak var processview: SetView!
    @IBOutlet weak var processlbl: UILabel!
    @IBOutlet weak var timetxtlbl: UILabel!
    @IBOutlet weak var ViewDtlBtn: UIButton!
    @IBOutlet weak var CancellOrderBtn: UIButton!
    
    @IBOutlet weak var Order_idVal: UILabel!
    @IBOutlet weak var DateVal: UILabel!
    @IBOutlet weak var OrderTitleVal: UILabel!
    @IBOutlet weak var SARVal: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
