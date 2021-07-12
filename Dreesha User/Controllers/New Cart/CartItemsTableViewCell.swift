//
//  CartItemsTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 21/06/21.
//

import UIKit
import Cosmos
class CartItemsTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var ProdImage: SetImage!
  
    @IBOutlet weak var ProductitleLabel: UILabel!
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var MovetoWishlistBtn: UIButton!
    @IBOutlet weak var RemoveBtn: UIButton!
    @IBOutlet weak var MinusBtn: UIButton!
    @IBOutlet weak var ProductQuantityVal: UILabel!
    @IBOutlet weak var PlusBtn: UIButton!
    @IBOutlet weak var CosmosView: CosmosView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
