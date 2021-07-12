//
//  ProjectDetailsViewController.swift
//  Dreeshah
//
//  Created by Promatics on 18/03/21.
//

import UIKit

class ProjectDetailsViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var projectNameLbl: UIButton!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var categoryNameLbl: UILabel!
    @IBOutlet weak var styleNameLbl: UILabel!
    @IBOutlet weak var yearValLbl: UILabel!
    @IBOutlet weak var projectCostValLbl: UILabel!
    @IBOutlet weak var websiteBtn: UIButton!
    @IBOutlet weak var keywordNameLbl: UILabel!
    @IBOutlet weak var projectImagesColl: UICollectionView!
    
    
    
    //MARK:- Variables
    var projectID = ""
    var viewModel = ProjectDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        projectImagesColl.delegate = self
        projectImagesColl.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Project Detail")
        //navigationController?.navigationBar.barTintColor = .clear
        getProjectDetails()
        
    }
    
    func setData(){
        self.projectNameLbl.setTitle(viewModel.getProjectDetail()?.projectName ?? "", for: .normal)
        self.addressLbl.text = viewModel.getProjectDetail()?.projectAddress ?? ""
        self.categoryNameLbl.text = (viewModel.getProjectDetail()?.projectCategory?.map({$0.name ?? ""}))?.joined(separator: ",")
        self.projectCostValLbl.text = "AED \(viewModel.getProjectDetail()?.projectCost ?? 0)"
        self.styleNameLbl.text = viewModel.getProjectDetail()?.projectStyle?.name ?? ""
        self.websiteBtn.setTitle(viewModel.getProjectDetail()?.projectWebsite ?? "", for: .normal)
        self.keywordNameLbl.text = (viewModel.getProjectDetail()?.projectKeyword?.map({$0.name ?? ""}))?.joined(separator: ", ")
        
    }

}

//MARK:- UICollectionView Delegates
extension ProjectDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getProjectDetail()?.projectImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectImagesCollectionViewCell", for: indexPath) as! ProjectImagesCollectionViewCell
        cell.projectImage.contentMode = .scaleAspectFill
        var imgUrl = ""
//        if ((viewModel.getProjectDetail()?.projectImages?.first?.name ?? "").suffix(4)) == ".mp4" {
//        imgUrl = URLS.projectImageUrl(viewModel.getProjectDetail()?.projectImages?[1].name ?? "").getDescription()
//        }else{
        imgUrl = URLS.projectImageUrl(viewModel.getProjectDetail()?.projectImages?[indexPath.row].name ?? "").getDescription()
//        }
        cell.projectImage.sd_setImage(with: URL(string: imgUrl), placeholderImage: #imageLiteral(resourceName: "Placehold"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.projectImagesColl.bounds.width - 2, height: self.projectImagesColl.bounds.height - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}

//MARK:- API CAll
extension ProjectDetailsViewController{
    func getProjectDetails(){
        viewModel.apiProjectDetails(projectId: self.projectID) { (isSuccess, message) in
            if isSuccess{
                self.setData()
                self.projectImagesColl.reloadData()
                let rem = (self.viewModel.getProjectDetail()?.projectImages?.first?.name ?? "").suffix(4)
                print(rem)
                print("REM IS UP")
            }else{
                self.view.makeToast(message)
            }
        }
    }
}
