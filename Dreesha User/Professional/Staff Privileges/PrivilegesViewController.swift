//
//  PrivilegesViewController.swift
//  Dreesha User
//
//  Created by Apple on 31/03/21.
//

import UIKit

class PrivilegesViewCell: UITableViewCell {
   
    @IBOutlet weak var selectBtn: SetButton!
    
    var onSelect: (() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    @IBAction func selectBtnAction(_ sender: Any) {
    }
    
}

class PrivilegesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Privileges")
    }
    
    
    @IBAction func managePriviledgeBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ManagePrivilegesViewController") as! ManagePrivilegesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension PrivilegesViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PrivilegesViewCell
        return cell
    }

}
