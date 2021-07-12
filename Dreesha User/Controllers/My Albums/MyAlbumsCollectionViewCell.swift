//
//  MyAlbumsCollectionViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 11/03/21.
//

import UIKit

class MyAlbumsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var outview: UIView!
    @IBOutlet weak var AlbumImgView: UIImageView!
    @IBOutlet weak var Albmlbl1: UILabel!
    @IBOutlet var videoIcon: UIImageView!
    
    override func awakeFromNib() {
        Albmlbl1.layer.shadowColor = UIColor.black.cgColor
        Albmlbl1.layer.shadowRadius = 2.0
        Albmlbl1.layer.shadowOpacity = 1.0
        Albmlbl1.layer.shadowOffset = CGSize(width: 2, height: 2)
        Albmlbl1.layer.masksToBounds = false
    }
}
