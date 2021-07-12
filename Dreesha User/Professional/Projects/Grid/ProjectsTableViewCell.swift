//
//  ProjectsTableViewCell.swift
//  Dreeshah
//
//  Created by Promatics on 18/03/21.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {
//Mark Outlets
    @IBOutlet weak var Imagview: SetImage!
    @IBOutlet weak var Labael1: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var photoCount: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
