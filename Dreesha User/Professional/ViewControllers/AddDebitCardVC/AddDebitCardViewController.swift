//
//  AddDebitCardViewController.swift
//  Dreeshah
//
//  Created by promatics on 20/02/21.
//

import UIKit

class AddDebitCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Add Debit Card"
        setBackBtn()
    }

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Add Debit Card")
    }
}
