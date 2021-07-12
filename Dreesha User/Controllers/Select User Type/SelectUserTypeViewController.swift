//
//  SelectUserTypeViewController.swift
//  Dreesha User
//
//  Created by Promatics on 22/03/21.
//

import UIKit

class SelectUserTypeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
//MArk Outlet
    @IBOutlet weak var UserSelectTableView: UITableView!
    
    //Mark Variables
    var ArrLabel=["Customer","Professional","Photographer"]
    var ArrImg = [ #imageLiteral(resourceName: "Review Online"), #imageLiteral(resourceName: "Review Online"), #imageLiteral(resourceName: "Photo Product")]
    var setSelectedIndex = -1
    var usertype = ""
    
//Mark View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        UserSelectTableView.delegate=self
        UserSelectTableView.dataSource=self
        UserSelectTableView.reloadData()
        UserSelectTableView.tableFooterView=UIView()
        navigationController?.navigationBar.isHidden = true
    }
}
//MArk TableView Delegates
extension SelectUserTypeViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrLabel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell") as! SelectUserTableViewCell
        cell.Label1.text=ArrLabel[indexPath.row]
        cell.ImageView.image=ArrImg[indexPath.row]
        
        
        if setSelectedIndex == indexPath.row{
            cell.colorView.backgroundColor = #colorLiteral(red: 0.329318583, green: 0.5059168935, blue: 0.6744242907, alpha: 1)
            cell.CheckBtn.isHidden = false
            
        }else {
            cell.colorView.backgroundColor = #colorLiteral(red: 0.709718883, green: 0.7882816792, blue: 0.8587187529, alpha: 1)
            cell.CheckBtn.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setSelectedIndex = indexPath.row
        UserSelectTableView.reloadData()
        let vc  = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        
        if indexPath.row == 0 {
            CurrentSession.shared.isUser = true
            vc.userType = ArrLabel[indexPath.row]
        } else if indexPath.row == 1 {
            CurrentSession.shared.isProfesstional = true
            vc.userType = ArrLabel[indexPath.row]
        } else {
            CurrentSession.shared.isPhotographer = true
            vc.userType = ArrLabel[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
