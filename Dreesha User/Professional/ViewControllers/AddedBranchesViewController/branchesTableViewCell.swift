//
//  branchesTableViewCell.swift
//  Dreeshah
//
//  Created by promatics on 12/03/21.
//

import UIKit

class branchesTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var branchImage: UIImageView!
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var pointOfContact: UILabel!
    @IBOutlet weak var branchDesc: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var viewDetailsBtn: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
