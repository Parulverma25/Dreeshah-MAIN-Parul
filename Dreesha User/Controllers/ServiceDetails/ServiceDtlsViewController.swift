//
//  ServiceDtlsViewController.swift
//  Dreesha User
//
//  Created by Promatics on 04/05/21.
//

import UIKit

class ServiceDtlsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    //MARK: Outlets
    
    
    @IBOutlet weak var ImgViewTop: UIImageView!
    @IBOutlet weak var ProfileImgViewTop2: UIImageView!
    @IBOutlet weak var ServiceTitle: UILabel!
    @IBOutlet weak var ServiceCategory: UILabel!
    @IBOutlet weak var ServiceLocation: UILabel!
    @IBOutlet weak var ServiceDescrpt: UILabel!
    @IBOutlet weak var PriceVal: UILabel!
    @IBOutlet weak var DurationVal: UILabel!
    @IBOutlet weak var otherphotosTitle: UILabel!
    @IBOutlet weak var otherphotosheight: NSLayoutConstraint!
    @IBOutlet weak var relatedphotosTitle: UILabel!
    @IBOutlet weak var relatedpicsHeight: NSLayoutConstraint!
    @IBOutlet weak var ProjectsCollHeight: NSLayoutConstraint!
    @IBOutlet weak var projectstitle: UILabel!
    
    @IBOutlet weak var AreasCollectionView: UICollectionView!
    @IBOutlet weak var OtherphotosClctnView: UICollectionView!
    @IBOutlet weak var RelatedClctnView: UICollectionView!
    @IBOutlet weak var projectCollectionView: UICollectionView!
    
    @IBOutlet weak var countriesColl: UICollectionView!
    
    
    
    //MARK:- Variables
    var viewModel = ServiceDetailARVM()
    var serviceID = ""
    var serviceName = ""
    var branchName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetDelegates()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        hitApiServiceDetails()
        setBackWithTitle(titleVal: serviceName)
        navigationController?.navigationBar.isHidden = false
        
       
       
      
    }
    


    // MARK: - Actions
    
    @IBAction func BookAppoint(_ sender: UIButton) {
        
        let vc1 = storyboard?.instantiateViewController(identifier: "AddAppointmentViewController") as! AddAppointmentViewController
        vc1.ServiceIdStr = viewModel.model?.result?.id ?? ""
        vc1.rqstId = generatenumber(length: 8)
        vc1.subject = serviceName
        vc1.professionalId = viewModel.model?.result?.professionalID?.id ?? ""
         navigationController?.pushViewController(vc1, animated: true)
    }
    
    @IBAction func GetInstantQuot(_ sender: UIButton) {
        
        let vc1 = storyboard?.instantiateViewController(identifier: "GetInstantQuotationViewController") as! GetInstantQuotationViewController
        vc1.Professional_service_idStr = viewModel.model?.result?.id ?? ""
        vc1.quotaionNo = generatenumber(length: 8)
        vc1.Date = Singleton.sharedInstance.dateFormatChange(date: Date().toDateStr() ?? "", oldFormat: "yyyy-MM-dd HH:mm:ss", newFormat: "dd MMM yyyy")
        vc1.subject = serviceName
        vc1.salesRep = (viewModel.model?.result?.professionalID?.firstName ?? "") + " \(viewModel.model?.result?.professionalID?.lastName ?? "")"
        vc1.professionalId = viewModel.model?.result?.professionalID?.id ?? ""
        vc1.branchNames = self.branchName
         navigationController?.pushViewController(vc1, animated: true)
    }
    
    
    //MARK: Functions
    
    func SetDelegates()
    {
        AreasCollectionView.delegate=self
        AreasCollectionView.dataSource=self
        
        
        OtherphotosClctnView.delegate=self
        OtherphotosClctnView.dataSource=self
        
        
        RelatedClctnView.delegate=self
        RelatedClctnView.dataSource=self
        
        projectCollectionView.delegate = self
        projectCollectionView.dataSource = self
        
        countriesColl.delegate = self
        countriesColl.dataSource = self
    }
    
    
}

//MARK: Collevtion View Delegates

extension ServiceDtlsViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 1
        if collectionView == AreasCollectionView
        {
            count = viewModel.model?.result?.areaCovered?.count ?? 0
        }else if collectionView == countriesColl{
            count = viewModel.model?.result?.country?.count ?? 0
        }
        else if collectionView == OtherphotosClctnView{
            count = viewModel.model?.result?.otherImages?.count ?? 0
        }
        else if collectionView == RelatedClctnView{
            count = viewModel.model?.result?.relatedImages?.count ?? 0
        }else{
            count = viewModel.model?.result?.serviceProject?.count ?? 0
        }
        
        if (viewModel.model?.result?.otherImages?.count ?? 0) != 0
        {
            otherphotosTitle.isHidden = false
        }else{
            otherphotosTitle.isHidden =  true
            if otherphotosTitle.isHidden ==  true
            {
            otherphotosheight.constant = 0
            }else{otherphotosheight.constant = 138}
            }

//        if(viewModel.model?.result?.relatedImages?.count ?? 0) != 0
//
//         if (viewModel.model?.result?.serviceProject?.count ?? 0) != 0 {
//
//                        projectstitle.isHidden = false
//                    }else{
//                        projectstitle.isHidden = true
//                        if  projectstitle.isHidden == true {
//                            ProjectsCollHeight.constant = 0
//                        }else{ProjectsCollHeight.constant = 180}
//                    }
//
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == OtherphotosClctnView
        {
            let cell = OtherphotosClctnView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OtherPhotosCollectionViewCell
            let imageUrl = URLS.serviceImageUrl(viewModel.model?.result?.otherImages?[indexPath.row].imageName ?? "").getDescription()
            cell.OthersImgVIew.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placeholding"))
            cell.desc.text = viewModel.model?.result?.otherImages?[indexPath.row].imageDescription ?? ""
//            if (viewModel.model?.result?.otherImages?.count ?? 0) != 0{
//                cell.otherspicscellheight.constant = 97
//
//                        }else{
//                            cell.otherspicscellheight.constant = 0
//                        }
                return cell
        }
        
        else if collectionView == RelatedClctnView
        {
            let cell = RelatedClctnView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OtherPhotosCollectionViewCell
            let imageUrl = URLS.serviceImageUrl(viewModel.model?.result?.relatedImages?[indexPath.row].imageName ?? "").getDescription()
            
            cell.OthersImgVIew.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placeholding"))
            cell.desc.text = viewModel.model?.result?.relatedImages?[indexPath.row].imageDescription ?? ""
                return cell
        }
        else if collectionView == projectCollectionView
        {
            let cell = projectCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProjectsServiceCollectionViewCell
            
                cell.numberOfPic.text = "\(String(describing: (self.viewModel.model?.result?.serviceProject?[indexPath.row].projectID?.projectImages?.count ?? 0))) Photos"
            cell.projectName.text = (self.viewModel.model?.result?.serviceProject?[indexPath.row].projectID?.projectName ?? "")
            let imageURL = URLS.projectImageUrl(viewModel.model?.result?.serviceProject?[indexPath.row].projectID?.projectImages?.first?.name ?? "").getDescription()
            cell.imageViews.sd_setImage(with: URL(string : imageURL), placeholderImage: #imageLiteral(resourceName: "Placeholding"))
            
            cell.imageViews.roundCorners([.topLeft, .topRight], radius: 12)
            cell.projectView.roundCornered([.topLeft, .topRight], radius: 12)

            return cell
            
        }else if collectionView == countriesColl {
            let cell = AreasCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AreasCoveredCollectionViewCell
            cell.AreaLabel.text = viewModel.model?.result?.country?[indexPath.row] ?? ""
            
            print(indexPath.row)
            return cell
        }else
        {
            let cell = AreasCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AreasCoveredCollectionViewCell
            cell.AreaLabel.text = viewModel.model?.result?.areaCovered?[indexPath.row] ?? ""
            
            print(indexPath.row)
                   return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == OtherphotosClctnView
        {
            return CGSize(width: 175, height: 225)
        }else if collectionView == RelatedClctnView
        {
            return CGSize(width: 170, height: 225)
        }
        else
        {
            return CGSize(width: 170, height: 225)
        }
    
    }
    
   
    
}

//MARK: API CAll
extension ServiceDtlsViewController{
    func hitApiServiceDetails(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.hitApiServiceDetails(productID: serviceID, completion: { [self] (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                
                
                let durationTime = (self.viewModel.model?.result?.duration ?? "")
                self.DurationVal.text = durationTime
                
                self.PriceVal.text = "AED \(String(self.viewModel.model?.result?.price ?? 0))"
                
                let imageURL = URLS.serviceImageUrl(viewModel.model?.result?.serviceImage ?? "").getDescription()
                self.ImgViewTop.sd_setImage(with: URL(string : imageURL), placeholderImage: #imageLiteral(resourceName: "Placeholding"))
                
                let professionalImage = URLS.profileImageUrl(viewModel.model?.result?.professionalID?.profileImage ?? "").getDescription()
                self.ProfileImgViewTop2.sd_setImage(with: URL(string : professionalImage), placeholderImage: #imageLiteral(resourceName: "Placeholding"))
                
                self.ServiceTitle.text = (viewModel.model?.result?.professionalID?.firstName ?? "") + (" \(viewModel.model?.result?.professionalID?.lastName ?? "")")
                self.ServiceCategory.text = viewModel.model?.result?.serviceCategory?.first?.name ?? ""
                self.ServiceDescrpt.text = viewModel.model?.result?.serviceDescription ?? ""
                
                self.OtherphotosClctnView.reloadData()
                self.RelatedClctnView.reloadData()
                self.AreasCollectionView.reloadData()
                self.projectCollectionView.reloadData()
                self.countriesColl.reloadData()
                
                let imgrel = viewModel.model?.result?.relatedImages?.map({$0.imageName ?? ""})
                
                if imgrel?.count == 0{
                    relatedphotosTitle.isHidden = true
                    relatedpicsHeight.constant = 0
                }
                else{
                    relatedphotosTitle.isHidden = false
                    relatedpicsHeight.constant = 128
                }
            let imgOther = viewModel.model?.result?.otherImages?.map({$0.imageName ?? ""})
            if imgOther?.count == 0{
                otherphotosTitle.isHidden = true
                otherphotosheight.constant = 0
            }
            else{
                otherphotosTitle.isHidden = false
                otherphotosheight.constant = 138
            }
        let imgProj = viewModel.model?.result?.serviceProject?.map({$0.projectID?.projectImages?.first?.name ?? "" })
        if imgProj?.count == 0{
            projectstitle.isHidden = true
            ProjectsCollHeight.constant = 0
        }
        else{
            projectstitle.isHidden = false
            ProjectsCollHeight.constant = 180
            
        }
            
        }else{
                self.view.makeToast(message , position : .center)
            }
        })
    }
    
}
