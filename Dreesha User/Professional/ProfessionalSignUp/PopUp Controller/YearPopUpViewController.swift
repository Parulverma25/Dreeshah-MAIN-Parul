//
//  YearPopUpViewController.swift
//  Dreesha User
//
//  Created by Apple on 08/04/21.
//

import UIKit

class YearPopUpCell: UITableViewCell {
    
    @IBOutlet weak var yearLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


protocol Year {
    func getYearValue(year: String)
}

class YearPopUpViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var isSelect : Int!
    var delegate: Year?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if let sa = isSelect {
           let saa = "\(2021 - sa)"
            delegate?.getYearValue(year: saa)
        }
    }
}



//MARK:- Table View Delegates

extension YearPopUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 122
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! YearPopUpCell
        cell.yearLabel.text = "\(2021 - indexPath.row)"
        cell.accessoryType = (self.isSelect == indexPath.row) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isSelect = indexPath.row
        tableView.reloadData()
    }
}
