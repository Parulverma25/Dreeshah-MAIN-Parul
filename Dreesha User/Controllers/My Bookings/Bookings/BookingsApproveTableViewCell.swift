//
//  BookingsApprovedTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 27/04/21.
//

import UIKit

class BookingsApproveTableViewCell: UITableViewCell {

    @IBOutlet weak var IMG1: SetImage!
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var ButtProcess: UILabel!
    @IBOutlet weak var ButtView: SetView!
    @IBOutlet weak var ViewDtlBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
