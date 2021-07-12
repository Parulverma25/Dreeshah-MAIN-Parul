//
//  QuotationAllViewController.swift
//  Dreesha User
//
//  Created by Apple on 16/03/21.
//

import UIKit

class QuotationAllViewController: UIViewController {
    //Mark Outlets
    @IBOutlet weak var requestsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //Mark Actions
    @IBAction func viewMore(_ sender: Any) {
    }
}
//Mark TableView Delegates
extension QuotationAllViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QuotationAllTableViewCell
        return cell
    }

}
