//
//  RatingReviewViewController.swift
//  Dreesha User
//
//  Created by promatics on 3/25/21.
//

import UIKit

class RatingReviewViewController: UIViewController {

    var name = "No"
    @IBOutlet weak var tableViewRating: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if name == "No"{
            tableCollectionErrors(view: tableViewRating, text: "No Rating & Reviews Found")
        }
    }

}
 // MARK: - TableView
extension RatingReviewViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewRating.dequeueReusableCell(withIdentifier: "cell") as! RatingReviewTableViewCell
        cell.NameVal1.text = name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    
}
