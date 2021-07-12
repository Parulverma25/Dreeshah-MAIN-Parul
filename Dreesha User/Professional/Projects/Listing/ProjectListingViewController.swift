//
//  ProjectListingViewController.swift
//  Dreeshah
//
//  Created by Promatics on 18/03/21.
//

import UIKit

class ProjectListingViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    //MARK:- Outlets
    @IBOutlet weak var TableViewProjectListing: UITableView!

    
    //MARK:- Variables
    var ArrLabel1 = ["Sam's Living Room Designs", "Olivia Bedroom Designs"]
    var ArrImg1 = [ #imageLiteral(resourceName: "IMGInt"),#imageLiteral(resourceName: "1IMG")]
    var viewType = ""
    var viewModel = ProjectListingViewModel()
    var offset = 0
    //MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewProjectListing.delegate=self
        TableViewProjectListing.dataSource=self
        TableViewProjectListing.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Projects")
        viewType = "grid"
        getProjectList(offset: String(self.offset))
    }
    
    @IBAction func listViewBtn(_ sender: Any) {
        viewType = "list"
        getProjectList(offset: String(self.offset))
        
//        let vc = self.storyboard?.instantiateViewController(identifier: "ProjectsViewController") as! ProjectsViewController
//        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    @IBAction func gridViewBtn(_ sender: Any) {
        viewType = "grid"
        getProjectList(offset: String(self.offset))
    }
    @IBAction func viewAddProject(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddProjectViewController") as! AddProjectViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
//MARK:- Table View Delegate Functions
extension ProjectListingViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.model.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewType == "grid"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProjectListingTableViewCell
            cell.Labal1.text = viewModel.model[indexPath.row].projectName ?? ""
            
            let url = URLS.projectImageUrl(viewModel.model[indexPath.row].projectImages?.first?.name ?? "").getDescription()
            
            cell.Imgview1.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "Placehold"))
            cell.photoCount.text = "\(viewModel.model[indexPath.row].projectImages?.count ?? 0) Photos"
            cell.locationLbl.text = viewModel.model[indexPath.row].projectAddress ?? ""
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectsTableViewCell") as! ProjectsTableViewCell
            cell.Labael1.text = viewModel.model[indexPath.row].projectName ?? ""
            
            let url = URLS.projectImageUrl(viewModel.model[indexPath.row].projectImages?.first?.name ?? "").getDescription()
            
            cell.Imagview.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "Placehold"))
            cell.photoCount.text = "\(viewModel.model[indexPath.row].projectImages?.count ?? 0) Photos"
            cell.locationLbl.text = viewModel.model[indexPath.row].projectAddress ?? ""
            return cell
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProjectDetailsViewController") as! ProjectDetailsViewController
        vc.projectID = self.viewModel.model[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- API CALL
extension ProjectListingViewController{
    func getProjectList(offset : String){
        viewModel.apiGetProjectList(limit: "10", offset: offset) { (isSuccess, message) in
            if isSuccess{
                self.TableViewProjectListing.reloadData()
            }else{
                self.view.makeToast(message)
            }
        }
    }
}
