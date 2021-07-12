//
//  OurProductsCollectionViewCell.swift
//  Dreesha User
//
//  Created by Apple on 18/03/21.
//

import UIKit
import Cosmos
class OurProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productRating: CosmosView!
    @IBOutlet weak var productPrice: UILabel!
}
