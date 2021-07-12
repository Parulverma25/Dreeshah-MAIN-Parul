//
//  FilterPopUpViewController.swift
//  Dreesha User
//
//  Created by Apple on 30/03/21.
//

import UIKit

class FilterPopUpTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectBtn: SetButton!
    
    var onSelect: (() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    
    @IBAction func selectBtnAction(_ sender: Any) {
        onSelect()
    }
    
}


class FilterPopUpViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data: [FilterData]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.append(contentsOf: [FilterData(title: "Today"), FilterData(title: "Yesterday"), FilterData(title: "Current Week"), FilterData(title: "Previous Wek"), FilterData(title: "Current Month"), FilterData(title: "Previous Month")])
    }

    @IBAction func crossBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}



//Mark Table View Delegate Functions
extension FilterPopUpViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FilterPopUpTableViewCell
        cell.nameLabel.text = data[indexPath.row].title
        
        cell.onSelect = {
            self.data[indexPath.row].isSelect.toggle()
            tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


struct FilterData {
    var title: String!
    var isSelect: Bool! = false
    
    init(title: String!) {
        self.title = title
    }
}
