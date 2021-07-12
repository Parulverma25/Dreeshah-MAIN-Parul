//
//  workScheduleTabCell.swift
//  Dreesha User
//
//  Created by Promatics on 22/05/21.
//

import UIKit

class workScheduleTabCell: UITableViewCell {

    @IBOutlet weak var moduleName: UILabel!
    @IBOutlet weak var moduleDescription: UILabel!
    @IBOutlet weak var moduleTimePeriod: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
