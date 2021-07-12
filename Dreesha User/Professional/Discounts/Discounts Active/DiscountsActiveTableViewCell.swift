//
//  DiscountsActiveTableViewCell.swift
//  Dreeshah
//
//  Created by Promatics on 20/03/21.
//

import UIKit

class DiscountsActiveTableViewCell: UITableViewCell {
    //Mark Outlets
    @IBOutlet weak var IMGView1: SetImage!
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var ButtView: SetView!
    @IBOutlet weak var ButtonLabel: UILabel!
    
    @IBOutlet weak var OffLabel: UILabel!
    @IBOutlet weak var OffView: UIView!
    @IBOutlet weak var ImageLabel: UILabel!
    //Mark Variables
    
    //Mark View Did Load
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
