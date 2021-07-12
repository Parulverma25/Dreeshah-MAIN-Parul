//
//  CollectionsListTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 17/06/21.
//

import UIKit

class CollectionsListTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var CollectionImageView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var AEDLabel: UILabel!
    @IBOutlet weak var DiscountLbl: UILabel!
    @IBOutlet weak var RemoveFromCollectionBtn: UIButton!
    @IBOutlet weak var ViewDetailsBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
