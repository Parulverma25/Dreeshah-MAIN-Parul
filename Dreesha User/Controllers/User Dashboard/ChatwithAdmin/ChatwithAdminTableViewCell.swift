//
//  ChatwithAdminTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 10/03/21.
//

import UIKit

class ChatwithAdminTableViewCell: UITableViewCell {

    //Mark Outlets
    @IBOutlet weak var AdmnImg: UIImageView!
    @IBOutlet weak var admnNamelbl: UILabel!
    @IBOutlet weak var admnMsgLbl: UILabel!
    @IBOutlet weak var admnDateLbl: UILabel!
    
    //Mark ViewDidLoad
    override func awakeFromNib() {
        super.awakeFromNib()
        AdmnImg.setRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIImageView {
   func setRounded() {
    let radius = self.frame.width / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}
