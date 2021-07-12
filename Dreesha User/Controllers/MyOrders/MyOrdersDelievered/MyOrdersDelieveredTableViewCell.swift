//
//  MyOrdersDelieveredTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 12/03/21.
//

import UIKit

class MyOrdersDelieveredTableViewCell: UITableViewCell {
    @IBOutlet weak var MyorderImgview: UIImageView!
  
    @IBOutlet weak var Order_idVal: UILabel!
    @IBOutlet weak var DateVal: UILabel!
    @IBOutlet weak var OrderTitleVal: UILabel!
    @IBOutlet weak var SarVal: UILabel!
    @IBOutlet weak var ViewDetailBtn: UIButton!
    @IBOutlet weak var ExchangeBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    

}
