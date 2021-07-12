//
//  ProductListTableViewCell.swift
//  Dreeshah
//
//  Created by Promatics on 18/03/21.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
//Mark Outlets
    
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var ViewDetailBtn: UIButton!
    @IBOutlet weak var CheckBtn: UIButton!
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var ViewDetailServiceBtn: UIButton!
    
    @IBOutlet weak var AddtoCollectionBtn: UIButton!
    
  
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


