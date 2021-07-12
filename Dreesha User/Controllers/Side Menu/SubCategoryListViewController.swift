//
//  SubCategoryListViewController.swift
//  Dreesha User
//
//  Created by Promatics on 30/04/21.
//

import UIKit

class SubCategoryListViewController: UIViewController {

    @IBOutlet weak var subCategoryList: UITableView!
    var subCategories = [String]()
    var Category = ""
    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = false
       // navigationItem.title = "\(Category)"
        setBackWithTitle(titleVal: "\(Category)")
        super.viewDidLoad()
        subCategoryList.tableFooterView = UIView()
        subCategoryList.delegate = self
        subCategoryList.dataSource = self
        // Do any additional setup after loading the view.
    }
    
}

extension SubCategoryListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SubCategoryTabCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SubCategoryTabCell
        cell.subCategory_Lbl.text = subCategories[indexPath.row]
        return cell
    }
    
    
}
