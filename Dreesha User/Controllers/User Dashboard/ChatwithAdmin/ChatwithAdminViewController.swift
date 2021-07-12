//
//  ChatwithAdminViewController.swift
//  Dreesha User
//
//  Created by Promatics on 10/03/21.
//

import UIKit

class ChatwithAdminViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
   
    //Mark Variables
    var arrNames = ["Liam","James","Sandra"]
    var arrMsg = ["Great! Thank you so much", "We will Discuss it again!","I Liked it"]
    var arrImag = [ #imageLiteral(resourceName: "Liam"), #imageLiteral(resourceName: "James"), #imageLiteral(resourceName: "Sandra")]
    var arrDate = ["10:30am","12:30pm","yesterday"]
    @IBOutlet weak var ChatAdmnTableview: UITableView!
    
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatAdmnTableview.delegate=self
        ChatAdmnTableview.dataSource=self
        ChatAdmnTableview.reloadData()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "Chat")
    }
    
}
//Mark TableView Delegates
extension ChatwithAdminViewController{
    
  func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatAdminCell") as! ChatwithAdminTableViewCell
        cell.admnNamelbl.text = arrNames[indexPath.row]
        cell.admnMsgLbl.text = arrMsg[indexPath.row]
        cell.AdmnImg.image = arrImag[indexPath.row]
        cell.admnDateLbl.text = arrDate[indexPath.row]
        return cell
    }
    
    
    
}
