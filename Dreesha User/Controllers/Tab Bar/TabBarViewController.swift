//
//  TabBarViewController.swift
//  Dreesha User
//
//  Created by Promatics on 16/03/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.isHidden = true
    }
    
    //Mark Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
    
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
