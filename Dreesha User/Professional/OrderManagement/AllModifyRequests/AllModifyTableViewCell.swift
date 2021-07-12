//
//  AllModifyTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 05/05/21.
//

import UIKit

class AllModifyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var refrenceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var requestStatusLbl: UILabel!
    @IBOutlet weak var viewDetailsBtn: UIButton!
    @IBOutlet weak var horizontalView: UIView!
    @IBOutlet weak var verticalView: UIView!
    @IBOutlet weak var imgView: SetImage!
    @IBOutlet weak var ProcessViewColor: SetView!
    @IBOutlet weak var CreateOrderBtnView: SetView!
    
    @IBOutlet weak var PendingbtnView: SetView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
