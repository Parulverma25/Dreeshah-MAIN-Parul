//
//  FAQofProductDetailsViewController.swift
//  Dreesha User
//
//  Created by promatics on 3/24/21.
//

import UIKit

class FAQofProductDetailsViewController: UIViewController {
    var buttonIndex : Int? = nil
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK:- actions
    @IBAction func expandViewBtn(_ sender: UIButton) {
        buttonIndex = sender.tag
        tableView.reloadData()
    }

}
// MARK:- extensions
extension FAQofProductDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FAQTableViewCell
        cell.showHideBtn.tag = indexPath.row
  //      cell.cellHeight.constant = 50
        if ((buttonIndex?.hashValue) != nil)
        {
        if buttonIndex! == indexPath.row
        {
           if cell.cellHeight.constant == 200
            {
            cell.cellHeight.constant = 50
            cell.showHideBtn.setImage(UIImage(named:"DRP-DWN-CIRCLE-1"), for: .normal)
                
            }else {
                cell.cellHeight.constant = 200
                cell.showHideBtn.setImage(UIImage(named:"DRP-up-CIRCLE"), for: .normal)
            }
        }
        }
        return cell
    }
    }
   
    
    

