//
//  CreateNewPasswordsViewController.swift
//  Dreesha User
//
//  Created by Promatics on 19/04/21.
//

import UIKit

class CreateNewPasswordsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func SendBtnAct(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SelectUserTypeViewController") as! SelectUserTypeViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    

}
