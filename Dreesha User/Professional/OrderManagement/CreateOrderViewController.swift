//
//  CreateOrderViewController.swift
//  Dreesha User
//
//  Created by Apple on 31/03/21.
//

import UIKit
import FlagPhoneNumber

class CreateOrderViewController: UIViewController {

    @IBOutlet weak var phTextField: FPNTextField!
    
    let counListing : FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phTextField.isUserInteractionEnabled = false
        phTextField.placeholder = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Create Order")
    }
    
    @IBAction func selectCountry(_ sender: Any) {
        
        let pTf = FPNTextField()
        pTf.displayMode = .list
        counListing.showCountryPhoneCode = true
        
        counListing.setup(repository: pTf.countryRepository)
        counListing.didSelect = {[weak self] country in
            self?.phTextField.setFlag(countryCode: country.code)
            self?.phTextField.placeholder = nil
        }
    
        self.openPicker()
        
    }
 
    func openPicker() {
        let navController = UINavigationController(rootViewController: counListing)
        counListing.title = "Countries"
        counListing.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissCountries))

        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func dismissCountries() {
        counListing.dismiss(animated: true, completion: nil)
    }
}
