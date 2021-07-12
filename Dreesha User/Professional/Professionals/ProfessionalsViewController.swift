//
//  ProfessionalsViewController.swift
//  Dreesha User
//
//  Created by Promatics on 06/05/21.
//

import UIKit

class ProfessionalsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    var refreshControl = UIRefreshControl()


    @objc func refresh(_ sender: AnyObject) {
        self.hitGetAllProfessionals(Search: self.searchvalStr, CategoryID: "")
    }
    
    
//MARK: Outlets
    
    @IBOutlet weak var SearchBAr: UISearchBar!
    @IBOutlet weak var TotalRecordsVal: UILabel!
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var ProfessionalsTableview: UITableView!

    //MARK:- Variables
    var comefrom = ""
    var viewModel = ProfessionalListViewModel()
    
    var offset = 0
    var isFetching = false
    var searchvalStr = ""
    var categoryIDStrVal = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfessionalsTableview.dataSource = self
        ProfessionalsTableview.delegate = self
        ProfessionalsTableview.reloadData()
        SearchBAr.backgroundColor = UIColor(named: "AppBlue")
        SearchBAr.searchTextField.backgroundColor = .white
        viewModel.dataModel = []
        SearchBAr.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        ProfessionalsTableview.addSubview(refreshControl) // not required when using UITableViewController
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Professionals")
        navigationController?.navigationBar.isHidden = false
        
      
        
        
        if comefrom == "recently"{
            self.topLabel.text = "Recently Joined Professionals"
            self.offset = 0
            self.viewModel.dataModel = []
            hitGetRecentProList(Search: " ")
        }else{
            self.topLabel.text = "All Professionals"
            self.offset = 0
            self.viewModel.dataModel = []
            hitGetAllProfessionals(Search: " ", CategoryID: categoryIDStrVal)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           print("searchText \(searchText)")
        searchvalStr = "\(searchText)"
        self.offset = 0
        self.viewModel.dataModel = []
        self.isFetching = false
        hitGetAllProfessionals(Search: searchvalStr, CategoryID: categoryIDStrVal )
        
        
       }
    
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.offset = 0
        self.viewModel.dataModel = []
        self.isFetching = false
        hitGetAllProfessionals(Search: searchvalStr, CategoryID: categoryIDStrVal )
        
    }
    
    
    @IBAction func tapProfessionalCategory(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SortByProfCategoryViewController") as! SortByProfCategoryViewController
        
        vc.modalPresentationStyle = .overFullScreen
        vc.completionBlock = {
            value in
            print(value)
            self.viewModel.dataModel = []
            self.hitGetAllProfessionals(Search: self.searchvalStr, CategoryID: value)
            self.categoryIDStrVal = value
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SearchBAr.text = ""
    }


}


//MARK: Tableview Delegate Functions
extension ProfessionalsViewController{
    
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getprofessionalInfo()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProfessionalsTableViewCell
        
        let proimg = URLS.profileImageUrl(viewModel.getprofessionalInfo()?[indexPath.row]?.profileImage ?? "").getDescription()
        cell.ProfessionalsProfileImageView.sd_setImage(with: URL(string: proimg), placeholderImage: #imageLiteral(resourceName: "Placed"))
        
        let branchImg = URLS.profileImageUrl(viewModel.getprofessionalInfo()?[indexPath.row]?.branches?.first?.branchProfile ?? "").getDescription()
        
        cell.imageViewProf.sd_setImage(with: URL(string: branchImg), placeholderImage: #imageLiteral(resourceName: "Placeholding"))
        
        cell.PhoneNoVal.text = viewModel.getprofessionalInfo()?[indexPath.row]?.contactDetails?.mobileNumber ?? ""
        cell.TitleVal.text = (viewModel.getprofessionalInfo()?[indexPath.row]?.firstName ?? "") + " \(viewModel.getprofessionalInfo()?[indexPath.row]?.lastName ?? "")"
        cell.locationVal.text = "\(viewModel.getprofessionalInfo()?[indexPath.row]?.professionalAddress?.city ?? "" )"
        
        
        let uppercased : [String] = viewModel.getprofessionalInfo()?[indexPath.row]?.serviceCategories.map { $0?.name ?? ""} ?? []
        print(uppercased)
      
        cell.CategoryTitle.text = " \(uppercased.joined(separator: ", "))"
        
        cell.DescriptionVal.text = viewModel.getprofessionalInfo()?[indexPath.row]?.branchBrief ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfessionalDetailsViewController") as! ProfessionalDetailsViewController
        
        vc.professionalData = viewModel.getprofessionalInfo()?[indexPath.row]
        
        vc.professionalID = viewModel.getprofessionalInfo()?[indexPath.row]?.id ?? ""
        
        vc.name = (viewModel.getprofessionalInfo()?[indexPath.row]?.firstName ?? "") + " \(viewModel.getprofessionalInfo()?[indexPath.row]?.lastName ?? "")"
        vc.imageOfProf = (viewModel.getprofessionalInfo()?[indexPath.row]?.profileImage ?? "")
        vc.mobileNo = (viewModel.getprofessionalInfo()?[indexPath.row]?.contactDetails?.mobileNumber ?? "")
        vc.website = (viewModel.getprofessionalInfo()?[indexPath.row]?.contactDetails?.branchWebsite ?? "")
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- ScrollViewDelegates
extension ProfessionalsViewController : UIScrollViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ){
            
            if isFetching{
                self.offset += 10
                if comefrom == "recently"{
                    hitGetRecentProList(Search: SearchBAr.text?.replacingOccurrences(of: " ", with: "") ?? "")
                }else{
                    hitGetAllProfessionals(Search: SearchBAr.text?.replacingOccurrences(of: " ", with: "") ?? "", CategoryID: categoryIDStrVal )
                }
            }
        
    }
    }
    

        
}

//MARK:- API CALL
extension ProfessionalsViewController{
    
    func hitGetAllProfessionals(Search: String , CategoryID : String){
        viewModel.apiAllProfessionalList(limit: "10", offset: String(self.offset), Search: Search, CatrgoryID: CategoryID) { (isSuccess, message) in
            if isSuccess{
                self.TotalRecordsVal.text = "\(self.viewModel.totalCount) Results Found"
                self.refreshControl.endRefreshing()
                self.ProfessionalsTableview.reloadData()
                self.isFetching = true
                tableCollectionErrors(view: self.ProfessionalsTableview, text: "")
            }else{
                self.ProfessionalsTableview.reloadData()
                if message == "no records"{
                    self.isFetching = false
                    if self.offset == 0{
                        tableCollectionErrors(view: self.ProfessionalsTableview, text: "No Records Found")
                    }else{
                        
                    }
                    
                }else{
                    self.view.makeToast(message)
                }
            }
        }
    }
    
    func hitGetRecentProList(Search: String ){
        viewModel.apiGetRecentlyProfessionalList(limit: "10", offset: String(self.offset), Search: Search) { (isSuccess, message) in
            if isSuccess{
                self.TotalRecordsVal.text = "\(self.viewModel.totalCount) Results Found"
                self.ProfessionalsTableview.reloadData()
                self.isFetching = true
                tableCollectionErrors(view: self.ProfessionalsTableview, text: "")
            }else{
                self.ProfessionalsTableview.reloadData()
                if message == "no records"{
                    self.isFetching = false
                    if self.offset == 0{
                        tableCollectionErrors(view: self.ProfessionalsTableview, text: "No Records Found")
                    }else{
                        
                    }
                    
                }else{
                    self.view.makeToast(message)
                }
            }
        }
    }
    
    
}
