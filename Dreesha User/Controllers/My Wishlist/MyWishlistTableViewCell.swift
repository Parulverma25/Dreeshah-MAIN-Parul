//
//  MyWishlistTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 11/03/21.
//

import UIKit

class MyWishlistTableViewCell: UITableViewCell {

    //Mark Outlets
    @IBOutlet weak var Wishlistimgview: UIImageView!
    @IBOutlet weak var ProductTitle: UILabel!
    @IBOutlet weak var SarVal: UILabel!
    @IBOutlet weak var YearVal: UILabel!
    @IBOutlet weak var likebtn: UIButton!
    @IBOutlet weak var RemoveBtn: UIButton!
    
    //Mark ViewDidLoad
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    //Mark Functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    @IBAction func Likebutton(_ sender: UIButton) {
        
    }
    
    @IBAction func removebtn(_ sender: UIButton) {
        
    }
}
