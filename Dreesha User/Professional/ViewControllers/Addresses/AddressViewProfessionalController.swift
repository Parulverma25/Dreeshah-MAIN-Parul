//
//  AddressViewController.swift
//  Dreeshah
//
//  Created by promatics on 12/03/21.
//

import UIKit

class AddressViewProfessionalController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var addressListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressListTable.delegate = self
        addressListTable.dataSource = self
        addressListTable.reloadData()

    }

}

//MARK:- TableView Delegates
extension AddressViewProfessionalController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListTableViewCell", for: indexPath) as! AddressListTableViewCell
        return cell
    }
    
    
}
