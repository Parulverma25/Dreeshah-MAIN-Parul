//
//  pendingRequestListTableViewCell.swift
//  Dreeshah
//
//  Created by promatics on 20/02/21.
//

import UIKit

class pendingRequestListTableViewCell: UITableViewCell {
    
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

    @IBOutlet weak var acceptBtn: UIButton!
    
    @IBOutlet weak var rejectBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
