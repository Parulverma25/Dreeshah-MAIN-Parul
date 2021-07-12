//
//  MembershipPlanViewController.swift
//  Dreeshah
//
//  Created by promatics on 19/02/21.
//

import UIKit

class MembershipPlanViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var infoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.reloadData()
        navigationItem.title = "Subscription Plan"
        setBackBtn()
    }

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Subscription Plan")
    }
}

//MARK:- TableView Deleagtes
extension MembershipPlanViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoTableViewCell", for: indexPath) as! infoTableViewCell
        return cell
    }
    
    
    
}
