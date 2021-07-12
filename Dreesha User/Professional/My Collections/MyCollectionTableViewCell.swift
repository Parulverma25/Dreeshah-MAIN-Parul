//
//  MyCollectionTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 17/06/21.
//

import UIKit

class MyCollectionTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet weak var CollectionTitle: UILabel!
    
    @IBOutlet weak var DeleteCollectionBtn: UIButton!
    @IBOutlet weak var CollectionValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
