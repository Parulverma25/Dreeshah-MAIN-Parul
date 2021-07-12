//
//  AllQuotationManagementViewController.swift
//  Dreesha User
//
//  Created by Apple on 26/03/21.
//

import UIKit

class AllQuotationManagementCell: UITableViewCell {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


class AllQuotationManagementViewController: UIViewController {

    var parentNavigationController : UINavigationController?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}


//MARK:- TableView Delegates
extension AllQuotationManagementViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AllQuotationManagementCell
        return cell
    }
    
    
}
