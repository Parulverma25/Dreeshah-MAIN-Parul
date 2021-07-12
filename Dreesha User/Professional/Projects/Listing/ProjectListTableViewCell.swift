//
//  ProjectListTableViewCell.swift
//  Dreesha User
//
//  Created by promatics on 26/04/21.
//

import UIKit

class ProjectListTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    
    @IBOutlet weak var projectName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
