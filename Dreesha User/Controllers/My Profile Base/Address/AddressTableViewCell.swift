//
//  AddressTableViewCell.swift
//  Dreesha User
//
//  Created by Promatics on 10/03/21.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    //Mark Outlets
    @IBOutlet weak var AdrsLabl: UILabel!
    @IBOutlet weak var Adrsdata: UILabel!
    @IBOutlet weak var EditAddressButton: UIButton!
    @IBOutlet weak var DeleteAdressButtomn: UIButton!
    @IBOutlet weak var ToggleDefaultBtn: UISwitch!
    @IBOutlet weak var contactNo: UILabel!
    
    

    
    //Mark ViewDidLoad
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
