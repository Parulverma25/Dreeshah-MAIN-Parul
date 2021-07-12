//
//  ProfServiceDetailsViewController.swift
//  Dreesha User
//
//  Created by Apple on 26/03/21.
//

import UIKit

class ServiceCellCell: UICollectionViewCell {
    @IBOutlet weak var serviceImage: UIImageView!
    
}
class ServiceAreaCoveredCell: UICollectionViewCell
{
    @IBOutlet weak var areaCoverLbl : UILabel!
}
//MARK:- MAIN CLASS
class ProfServiceDetailsViewController: UIViewController {

    @IBOutlet weak var collectionViewAreaCoverd: UICollectionView!
    @IBOutlet weak var projectCollectionView: UICollectionView!
    
    @IBOutlet weak var countriesColl: UICollectionView!
    
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var collection2: UICollectionView!
    @IBOutlet weak var serviceImage: SetImage!
    
    @IBOutlet weak var duration: UIButton!
    @IBOutlet weak var projectView: SetView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var projectNoPhotos: UILabel!
    @IBOutlet weak var areacoverLBL: UILabel!
    @IBOutlet weak var myProjectName: UILabel!
    @IBOutlet weak var state: UIButton!
    @IBOutlet weak var relatedphotos: UILabel!
    @IBOutlet weak var areaCoverdHeight: NSLayoutConstraint!
    @IBOutlet weak var otherPhotosLbl: UILabel!
    @IBOutlet weak var otherPhotosHeight: NSLayoutConstraint!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var projectslbl: UILabel!
    @IBOutlet weak var relatedphotosheight: NSLayoutConstraint!
    @IBOutlet weak var projectheight: NSLayoutConstraint!
    @IBOutlet weak var mainPageHeight : NSLayoutConstraint!
    @IBOutlet weak var mainImg: SetImage!
    var mainPageHeightsss = 1100
    //MARK:- variable
    var headerVal = ["Other Photos" , "Related Photos"]
    var ArrImg = [ #imageLiteral(resourceName: "1IMG"), #imageLiteral(resourceName: "2IMG"), #imageLiteral(resourceName: "3IMG"),#imageLiteral(resourceName: "buildingConst"), #imageLiteral(resourceName: "1IMG"), #imageLiteral(resourceName: "2IMG"), #imageLiteral(resourceName: "3IMG"),#imageLiteral(resourceName: "buildingConst"), #imageLiteral(resourceName: "1IMG"), #imageLiteral(resourceName: "2IMG"), #imageLiteral(resourceName: "3IMG"),#imageLiteral(resourceName: "buildingConst")]
    var viewType = ""
    var relatedImg = [UIImage]()
    var otherImg = [UIImage]()
    var projects = ProjectBySubCategoryModel()
    var serviceImg = UIImage()
    var serviceName = ""
    var servicePrice = ""
    var serviceDuration = ""
    var serviceCountries = [String]()
    var serviceCities = [String]()
    var productID : String!
    var viewModel = ServiceDetailARVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceImage.roundCorners([.bottomLeft, .bottomRight], radius: 40)
        bgView.backgroundColor = .blue
        mainPageHeight.constant = CGFloat(mainPageHeightsss)
        if viewType == "Preview"{
            setDataForPreview()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        if viewType != "Preview"{
            hitApiServiceDetails()
        }
        mainPageHeight.constant = CGFloat(mainPageHeightsss)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func setDataForPreview(){
        self.serviceImage.image = serviceImg
        self.productName.text = serviceName
        self.price.text = servicePrice
      //  self.state.setTitle(serviceCountries.joined(separator: ", "), for: .normal)
        self.duration.setTitle(serviceDuration, for: .normal)
        self.collection2.reloadData()
        self.collectionView2.reloadData()
        self.collectionViewAreaCoverd.reloadData()
        self.projectCollectionView.reloadData()
        self.countriesColl.reloadData()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}



extension UIImageView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

extension UIView {

    func roundCornered(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}


//MARK:- Collection View Delegates
extension ProfServiceDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collection2
        {   if(viewType == "Preview"){
            return relatedImg.count
        }else{
            if self.viewModel.model?.result?.relatedImages?.count  == 0
            {
                mainPageHeightsss = mainPageHeightsss - 120
                self.relatedphotos.text = ""
                self.relatedphotosheight.constant = 0
            }
            return (self.viewModel.model?.result?.relatedImages?.count ?? 0 )!
        }
        }else if collectionView == collectionView2
        {   if viewType == "Preview"{
            return otherImg.count
        }else{
            if self.viewModel.model?.result?.otherImages?.count == 0
            {
                mainPageHeightsss = mainPageHeightsss - 120
                self.otherPhotosLbl.text = ""
                self.otherPhotosHeight.constant = 0
            }
            return (self.viewModel.model?.result?.otherImages?.count ?? 0 )!
        }
        }else if collectionView == projectCollectionView
        {   if viewType == "Preview"{
            return projects.count
        }else{
            if self.viewModel.model?.result?.serviceProject?.count == 0
            {
                mainPageHeightsss = mainPageHeightsss - 140
                projectslbl.text = ""
                projectheight.constant = 0
            }
            print("PROJECTSSSSS;;;;;;;+++\((self.viewModel.model?.result?.serviceProject?.count ?? 0)!)")
            return (self.viewModel.model?.result?.serviceProject?.count ?? 0)!
        }
        }
        else
        {   if viewType == "Preview"{
            return serviceCities.count
        }else if collectionView == countriesColl{
            return (self.viewModel.model?.result?.country?.count ?? 0)
        }else{
            if self.viewModel.model?.result?.areaCovered?.count == 0
            {
                mainPageHeightsss = mainPageHeightsss - 60
                areacoverLBL.text = ""
                areaCoverdHeight.constant = 0
            }
           print("COVERED AREA======>>>>\((self.viewModel.model?.result?.areaCovered?.count ?? 0)!)")
            return (self.viewModel.model?.result?.areaCovered?.count ?? 0)!
        }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collection2
        {
        let cell = collection2.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! ServiceCellCell
            if viewType == "Preview"{
                cell.serviceImage.image = relatedImg[indexPath.row]
            }else{
            let imageURL = URLS.serviceImageUrl(self.viewModel.model?.result?.relatedImages?[indexPath.row].imageName ?? "").getDescription()
            cell.serviceImage.sd_setImage(with: URL(string : imageURL), placeholderImage: #imageLiteral(resourceName: "Placehold"))
            }
            return cell
        }else if collectionView == collectionView2
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCellCell
            if viewType == "Preview"{
                cell.serviceImage.image = otherImg[indexPath.row]
            }else{
                let imageURL = URLS.serviceImageUrl(self.viewModel.model?.result?.otherImages?[indexPath.row].imageName ?? "").getDescription()
                cell.serviceImage.sd_setImage(with: URL(string : imageURL), placeholderImage: #imageLiteral(resourceName: "Placehold"))
            }
            return cell
        }else if collectionView == projectCollectionView
        {
            let cell = projectCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProjectsServiceCollectionViewCell
            if viewType == "Preview"{
                cell.projectName.text = projects[indexPath.row].projectName
                cell.numberOfPic.text = "\(String(describing: projects[indexPath.row].projectImages?.count)) images"
                let imgUrl = URLS.projectImageUrl(projects[indexPath.row].projectImages?[0].name ?? "").getDescription()
                cell.imageViews.sd_setImage(with: URL(string: imgUrl), placeholderImage: #imageLiteral(resourceName: "Placehold"))
            }else{
                cell.numberOfPic.text = "\(String(describing: (self.viewModel.model?.result?.serviceProject?[indexPath.row].projectID?.projectImages?.count ?? 0))) Photos"
            cell.projectName.text = (self.viewModel.model?.result?.serviceProject?[indexPath.row].projectID?.projectName ?? "")
            let imageURL = URLS.projectImageUrl(viewModel.model?.result?.serviceProject?[indexPath.row].projectID?.projectImages?.first?.name ?? "").getDescription()
            cell.imageViews.sd_setImage(with: URL(string : imageURL), placeholderImage: #imageLiteral(resourceName: "Placehold"))
            }
            cell.imageViews.roundCorners([.topLeft, .topRight], radius: 12)
            cell.projectView.roundCornered([.topLeft, .topRight], radius: 12)

            return cell
            
        }else if collectionView == countriesColl{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceAreaCoveredCell
            if viewType == "Preview"{
                cell.areaCoverLbl.text = serviceCountries[indexPath.row]
            }else{
                cell.areaCoverLbl.text = (self.viewModel.model?.result?.country?[indexPath.row] ?? "")
            }
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceAreaCoveredCell
            if viewType == "Preview"{
                cell.areaCoverLbl.text = serviceCities[indexPath.row]
            }else{
                cell.areaCoverLbl.text = (self.viewModel.model?.result?.areaCovered?[indexPath.row] ?? "")
            }
            return cell
        }
          
        
        
    }
}
//MARK:- API CALL
extension ProfServiceDetailsViewController
{
    func hitApiServiceDetails(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.hitApiServiceDetails(productID: productID, completion: { [self] (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.price.text = "AED \((self.viewModel.model?.result?.price)!)"
                self.productName.text = (self.viewModel.model?.result?.serviceName)!
                let countryNm = (self.viewModel.model?.result?.country?.joined(separator: ","))!
                //self.state.setTitle(countryNm, for: .normal)
                let durationTime = (self.viewModel.model?.result?.duration)!
                self.duration.setTitle(durationTime, for: .normal)
                let imageURL = URLS.serviceImageUrl(viewModel.model?.result?.serviceImage ?? "").getDescription()
                self.serviceImage.sd_setImage(with: URL(string : imageURL), placeholderImage:#imageLiteral(resourceName: "Placehold"))
                let imageURL1 = URLS.projectImageUrl(viewModel.model?.result?.serviceProject?.first?.projectID?.projectImages?.first?.name ?? "").getDescription()
                
                self.collection2.reloadData()
                self.collectionView2.reloadData()
                self.collectionViewAreaCoverd.reloadData()
                self.projectCollectionView.reloadData()
                self.countriesColl.reloadData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        })
    }
}
