//
//  ProjectsViewController.swift
//  Dreeshah
//
//  Created by Promatics on 18/03/21.
//

import UIKit

class ProjectsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
   
    
//MArk Outlets
    
    @IBOutlet weak var projectTableView: UITableView!
    
//Mark Variables
    var ArrLabel1 = ["Sam's Living Room Designs", "Olivia Bedroom Designs"]
    var ArrImg1 = [ #imageLiteral(resourceName: "IMGInt"),#imageLiteral(resourceName: "1IMG")]
    
    //MArk View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        projectTableView.delegate=self
        projectTableView.dataSource=self
        projectTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Projects")
    }
    
    
    @IBAction func gridViewBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewAddProject(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddProjectViewController") as! AddProjectViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MArk Table View Delegate Functions
extension ProjectsViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrLabel1.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProjectsTableViewCell
        cell.Labael1.text=ArrLabel1[indexPath.row]
        cell.Imagview.image=ArrImg1[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ProjectDetailsViewController") as! ProjectDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
