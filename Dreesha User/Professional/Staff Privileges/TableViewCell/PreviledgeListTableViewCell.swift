//
//  PreviledgeListTableViewCell.swift
//  Dreesha User
//
//  Created by promatics on 28/04/21.
//

import UIKit

class PreviledgeListTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    
    @IBOutlet weak var previledgeName: UILabel!
    @IBOutlet weak var selectionBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
