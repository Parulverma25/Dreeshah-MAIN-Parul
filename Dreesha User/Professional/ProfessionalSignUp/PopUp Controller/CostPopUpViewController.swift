//
//  CostPopUpViewController.swift
//  Dreesha User
//
//  Created by Promatics on 13/05/21.
//

import UIKit

class CostPopUpCell: UITableViewCell {
    
    @IBOutlet weak var costLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


protocol Cost {
    func getCostValue(cost: String)
}

class CostPopUpViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var isSelect : Int!
    var selectCost : String!
    var delegate: Cost?
    
    var priceArray = ["Upto 10000 AED", "Upto 50000 AED", "Upto 100000 AED", "Upto 500000 AED", "More than 500000 AED"]
   // var selectedPrice = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.getCostValue(cost: selectCost)
    }
}



//MARK:- Table View Delegates

extension CostPopUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return priceArray.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CostPopUpCell
        cell.costLabel.text = "\(priceArray[indexPath.row])"
        cell.accessoryType = (self.isSelect == indexPath.row) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isSelect = indexPath.row
        self.selectCost = priceArray[indexPath.row]
        tableView.reloadData()
    }
}

