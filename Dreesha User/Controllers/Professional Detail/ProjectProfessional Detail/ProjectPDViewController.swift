//
//  ProjectPDViewController.swift
//  Dreesha User
//
//  Created by promatics on 3/25/21.
//

import UIKit


class ProjectPDViewController: UIViewController {
    @IBOutlet weak var collectionViewProject: UICollectionView!
    
    //MARK:- Variables
    var viewModel = ProfessionalDetailsViewModel()
    var profID = ""
    var isfetching = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.model = []
        self.isfetching = false
        getProjectList(offset: 0)
    }
    
    

 
}
extension  ProjectPDViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionViewProject.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProjectsPDCollectionViewCell
        
        let projectImg = URLS.projectImageUrl(viewModel.model[indexPath.row].projectImages?.first?.name ?? "").getDescription()
        
        cell.projectImage.sd_setImage(with: URL(string: projectImg), placeholderImage: #imageLiteral(resourceName: "Placehold"))
        
        cell.projectName.text = viewModel.model[indexPath.row].projectName ?? ""
        
            return cell
    
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.collectionView.frame.size.width/2 - 20, height: self.collectionView.frame.size.width/2 + 30)
        return CGSize(width: self.collectionViewProject.frame.size.width / 2 - 5, height: 260)
    }
}

//MARK:- API Call
extension ProjectPDViewController{
    func getProjectList(offset  : Int){
        
        viewModel.apiGetProfProjects(professionalID: profID, limit: "10", offset: String(offset)) { (isSuccess, message) in
            if isSuccess{
                self.isfetching = true
                tableCollectionErrors(view: self.collectionViewProject, text: "")
                self.collectionViewProject.reloadData()
                
                
            }else{
                self.isfetching = false
                if offset == 0{
                  
                    tableCollectionErrors(view: self.collectionViewProject, text: "No Projects Available")
                }else{
                    
                }
                
            }
        }
        
        //viewModel.apiGetProfProjects(professionalID: professinalID)
    }
}
