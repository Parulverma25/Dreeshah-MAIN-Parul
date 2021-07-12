//
//  HomeViewController.swift
//  Dreesha User
//
//  Created by Apple on 18/03/21.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController, UITextFieldDelegate {
    //MARK:- OUTLETS
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var collectionViewForRoom: UICollectionView!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var collectionViewForRecentlyProfessional: UICollectionView!
    @IBOutlet weak var collectionViewForOurService: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionViewForPhotographer: UICollectionView!
    @IBOutlet weak var collectionViewForSliders: UICollectionView!
    @IBOutlet weak var collectionViewForAdvertisement: UICollectionView!
    @IBOutlet weak var collectionViewForProfessionals: UICollectionView!
    @IBOutlet weak var viewForSliders: SetView!
    @IBOutlet weak var collationViewForProducts: UICollectionView!
    @IBOutlet weak var viewallforServices: UIButton!
    
    
    //MARK: VARAIBLES
    var viewModel = ProductViewModel()
    var isFetching = false
    var ServiceviewModel = HomeViewModel()
    var professionalVM = ProfessionalListViewModel()
    var offset = 0
    var iconClick = true
    var sliderImages = [UIImage(named: "Home IMG"), UIImage(named: "Home IMG")]
    var profImages = [UIImage(named: "Liam"), UIImage(named: "Diana"), UIImage(named: "James")]
    var proffNames = ["Liam", "Diana", "James"]
    var advertImages = [UIImage(named: "home-2609600_960_720 1"), UIImage(named: "home-2609600_960_720 1")]
    //MARK: View DID Load
    override func viewDidLoad() {
        super.viewDidLoad()
        crossBtn.isHidden = true
        navigationController?.navigationBar.isHidden = true
        let angle = CGFloat.pi/2
            pageControl.transform = CGAffineTransform(rotationAngle: angle)
        pageControl.currentPage = 0
        pageControl?.numberOfPages = 8
        searchTxtField.delegate = self
        searchTxtField.addTarget(self, action: #selector(HomeViewController.textFieldDidBeginEditing(_:)), for: .editingChanged)
        // Do any additional setup after loading the view.
        collectionViewForAdvertisement.delegate = self
        collectionViewForAdvertisement.dataSource = self
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField == searchTxtField {
                if searchTxtField.text == ""
                {
                    crossBtn.isHidden = true
                }else{
                    crossBtn.isHidden = false
                }
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
//        offset=0
//        if CurrentSession.shared.isUser {
//            hitApiServicesList()
//            hitApiProductsList()
//
//        } else if CurrentSession.shared.isProfesstional {
//            //hitApiProductsListPro()
//        }
        ServiceviewModel.Servicemodel = []
        professionalVM.dataModel = []
        hitApiServicesList()
        
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        hitApiProductsList()
  
        hitApiRecentProfessioanlList()
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if  isFetching{
            self.offset += 10
            hitApiProductsList()
        }
    }
    
    // MARK:- Action Button
    
    
    @IBAction func ViewProdAllBtn(_ sender: UIButton) {
        
        
        self.tabBarController?.selectedIndex = 1
        
        
    }
    
    
    
    
    
    
    @IBAction func sideMenuBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SideMenuViewController") as! SideMenuViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.viewController = self
        transitionVc(vc: vc, duration: 0.5, type: .fromLeft)
    }
    
    
    @IBAction func interiorBtn(_ sender: Any) {
        let vc  = self.storyboard!.instantiateViewController(withIdentifier: "InteriorViewController") as! InteriorViewController
        vc.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func viewallServicesAct(_ sender: Any) {
        
       let vc =  UIStoryboard(name:"ServicesStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ServicesViewController") as! ServicesViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func ViewAllProfessionals(_ sender: UIButton) {
        let vc =  UIStoryboard(name:"ServicesStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ProfessionalsViewController") as! ProfessionalsViewController
         vc.hidesBottomBarWhenPushed = true
         navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func viewRecentJoinedProfessionals(_ sender: Any) {
        
        let vc =  UIStoryboard(name:"ServicesStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ProfessionalsViewController") as! ProfessionalsViewController
         vc.hidesBottomBarWhenPushed = true
        vc.comefrom = "recently"
        
         navigationController?.pushViewController(vc, animated: true)
    }
    
 
    
    @IBAction func crossActionBtn(_ sender: UIButton) {
        searchTxtField.text = ""
       }
    
    @IBAction func exteriorBtn(_ sender: UIButton) {
        let vc  = self.storyboard!.instantiateViewController(withIdentifier: "ExteriorViewController") as! ExteriorViewController
        vc.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(vc, animated: true)
    }
}



//MARK: Extention
extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if collectionView == collationViewForProducts
        {
            count = viewModel.getProductListData()?.count ?? 0
        }
        else if collectionView == collectionViewForSliders{
            count = self.sliderImages.count
        }else if collectionView == collectionViewForOurService{
            count = ServiceviewModel.getServiceListData()?.count ?? 0
        }
        else if collectionView == collectionViewForProfessionals{
            count = self.proffNames.count
        }else if collectionView == collectionViewForRecentlyProfessional{
            count = self.professionalVM.getprofessionalInfo()?.count ?? 0
        }
        else if collectionView == collectionViewForPhotographer{
            count = self.proffNames.count
        }
        else if collectionView == collectionViewForAdvertisement{
            count = advertImages.count
        }
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewForRoom
        {
            let cell = collectionViewForRoom.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
            if indexPath.row == 7
            {
                cell.imageToSet.image = #imageLiteral(resourceName: "Plus Blue Circle")
                cell.specNamesLbl.text = "View All"
                cell.specNamesLbl.textColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
            }
                return cell
        }
        
        else if collectionView == collationViewForProducts
        {
            let cell = collationViewForProducts.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OurProductsCollectionViewCell
            let imageUrl = URLS.productImgUrl(viewModel.getProductListData()?[indexPath.row].productMedia?.first?.name ?? "").getDescription()
            cell.productImage.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placeholding"))
            cell.productName.text = (viewModel.getProductListData()?[indexPath.row].productTitle ?? "")
            cell.productPrice.text = " AED \(viewModel.getProductListData()?[indexPath.row].pricing?.costPerItem ?? 0 ) "
                return cell
        }
        
        else if collectionView == collectionViewForProfessionals
        {
            let cell = collectionViewForProfessionals.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfessionalsCollectionViewCell
            cell.profileImg.image = profImages[indexPath.row]
            cell.professionalName.text = proffNames[indexPath.row]
                   return cell
        }
        
        else if collectionView == collectionViewForRecentlyProfessional
        {
            let cell = collectionViewForRecentlyProfessional.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfessionalsCollectionViewCell
            
            let img = URLS.profileImageUrl(professionalVM.getprofessionalInfo()?[indexPath.row]?.profileImage ?? "").getDescription()
            cell.profileImg.sd_setImage(with: URL(string: img), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
            cell.professionalName.text = (professionalVM.getprofessionalInfo()?[indexPath.row]?.firstName ?? "") + " \(professionalVM.getprofessionalInfo()?[indexPath.row]?.lastName ?? "")"
                   return cell
            
        }
        
        else if collectionView == collectionViewForPhotographer
        {
            let cell = collectionViewForPhotographer.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotographerHVCCollectionViewCell
            cell.profileImage.image = profImages[indexPath.row]
            cell.photographerName.text = proffNames[indexPath.row]
                   return cell
            
        }
        else if collectionView == collectionViewForOurService
        {
            let cell = collectionViewForOurService.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OurServiceCollectionViewCell
            if ServiceviewModel.Servicemodel.isEmpty{
                
            }else{
                
                cell.ServicesTitleLbl.text = ServiceviewModel.getServiceListData()?[indexPath.row].serviceName ?? ""
                let imageUrl = URLS.ServiceImgUrl(ServiceviewModel.getServiceListData()?[indexPath.row].serviceImage ?? "").getDescription()
                cell.ServicesImgView.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                
                       
            }
            
            return cell
            
        }
        
        else if collectionView == collectionViewForAdvertisement
        {
            let cell = collectionViewForAdvertisement.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AdvertisementHVCCollectionViewCell
            cell.advImage.image = advertImages[indexPath.row]
    
                   return cell
        }
        
        else
        {
            let cell = collectionViewForSliders.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SlidersCollectionViewCell
            cell.imageInSlider.image = sliderImages[indexPath.row]
            pageControl.currentPage = indexPath.row
            print(indexPath.row)
                   return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionViewForSliders
        {
            return CGSize(width: self.viewForSliders.frame.size.width, height: self.viewForSliders.frame.size.height)
        }
        else if collectionView == collectionViewForRoom {
            return CGSize(width: self.collectionViewForRoom.frame.size.width / 4.57, height: self.collectionViewForRoom.frame.size.height * 0.5)
        }
        else if collectionView == collationViewForProducts
        {
            return CGSize(width: 170, height: 225)
        }
        else if collectionView == collectionViewForOurService
        {
            return CGSize(width: 175, height: 225)
        }
        else if collectionView == collectionViewForAdvertisement
        {
            return CGSize(width: 180 , height: collectionViewForAdvertisement.frame.height)
        }
        else
        {
            return CGSize(width: 150, height: 190)
        }
}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewForProfessionals
        {
            let  vc1 = storyboard?.instantiateViewController(withIdentifier: "ProfessionalDetailsViewController") as! ProfessionalDetailsViewController
             vc1.hidesBottomBarWhenPushed = true
            
            vc1.professionalData = professionalVM.getprofessionalInfo()?[indexPath.row]
            
            vc1.professionalID = professionalVM.getprofessionalInfo()?[indexPath.row]?.id ?? ""
            
            vc1.name = (professionalVM.getprofessionalInfo()?[indexPath.row]?.firstName ?? "") + " \(professionalVM.getprofessionalInfo()?[indexPath.row]?.lastName ?? "")"
            vc1.imageOfProf = (professionalVM.getprofessionalInfo()?[indexPath.row]?.profileImage ?? "")
            vc1.mobileNo = (professionalVM.getprofessionalInfo()?[indexPath.row]?.contactDetails?.mobileNumber ?? "")
            vc1.website = (professionalVM.getprofessionalInfo()?[indexPath.row]?.contactDetails?.branchWebsite ?? "")
            
            navigationController?.navigationBar.isHidden = false
            navigationController?.pushViewController(vc1 , animated: true)
        }
        else if collectionView == collationViewForProducts
        {
            let  vc1 = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
             vc1.hidesBottomBarWhenPushed = true
            vc1.ProductIdStr = viewModel.getProductListData()?[indexPath.row].id ?? ""
            vc1.Professional_IDStr = viewModel.getProductListData()?[indexPath.row].professionalID ?? ""
            
            navigationController?.navigationBar.isHidden = false
             navigationController?.pushViewController(vc1 , animated: true)
        }
    }
    
}


extension HomeViewController : UIScrollViewDelegate{
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
            let pageWidth = self.collectionViewForSliders.frame.size.width
            pageControl.currentPage = Int(self.collectionViewForSliders.contentOffset.x / pageWidth)
        }
    }



extension UIViewController {
func transitionVc(vc: UIViewController, duration: CFTimeInterval, type: CATransitionSubtype)
                {
                    let customVcTransition = vc
                    let transition = CATransition()
                    transition.duration = duration
                    transition.type = CATransitionType.push
                    transition.subtype = type
                    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                    view.window!.layer.add(transition, forKey: kCATransition)
                    present(customVcTransition, animated: false, completion: nil)
                    }
}


extension UIImage {
    
    class func outlinedEllipse(size: CGSize, color: UIColor, lineWidth: CGFloat = 1.0) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else
        {
            return nil
        }
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth * 0.5, dy: lineWidth * 0.5)
        context.addEllipse(in: rect)
        context.strokePath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

//MARK:- API Call
extension HomeViewController{
    func hitApiProductsList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiProductList(limit: "10", offset: String(self.offset)){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.isFetching = true
                self.collationViewForProducts.reloadData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func hitApiServicesList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        ServiceviewModel.apiServiceList(limit: "10", offset: String(self.offset)){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.collectionViewForOurService.reloadData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func hitApiRecentProfessioanlList(){
        professionalVM.apiGetRecentlyProfessionalList(limit: "10", offset: "0", Search: "") { (isSuccess, message) in
            if isSuccess{
                self.collectionViewForRecentlyProfessional.reloadData()
            }else{
//                self.view.makeToast(message , position : .center)
            }
        }
    }
    
}
