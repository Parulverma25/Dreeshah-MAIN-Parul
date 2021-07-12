//
//  OrderManagementViewController.swift
//  Dreeshah
//
//  Created by Promatics on 19/03/21.
//

import UIKit

class OrderManagementViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
//Mark Outlets
    @IBOutlet weak var tableviewOrdrMaangement: UITableView!
    
 //Mark Variables
    var ArrLabel1 = ["Designer Bed","Sofa","Italian Lamp"]
    var ArrImg1 = [#imageLiteral(resourceName: "Bed Image 1"),#imageLiteral(resourceName: "Sofa IMG2"),#imageLiteral(resourceName: "Light Img 3")]
                    
    
    
    //Mark View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewOrdrMaangement.delegate=self
        tableviewOrdrMaangement.dataSource=self
        tableviewOrdrMaangement.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Order Management")
    }
    
    @IBAction func gridView(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "OrderGridViewController") as! OrderGridViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addOrder(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CreateOrderViewController") as! CreateOrderViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
//Mark Table View Delegate Functions
extension OrderManagementViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrLabel1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! OrderManagementTableViewCell
        cell.Label1.text=ArrLabel1[indexPath.row]
        cell.Imageview1.image=ArrImg1[indexPath.row]
        return cell
    }
}
