//
//  HomeViewController.swift
//  Dreesha User
//
//  Created by Apple on 18/03/21.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var collectionViewForRoom: UICollectionView!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionViewForSliders: UICollectionView!
    @IBOutlet weak var collectionViewForProfessionals: UICollectionView!
    @IBOutlet weak var collationViewForProducts: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        crossBtn.isHidden = true
        pageControl.currentPage = 0
        pageControl?.numberOfPages = 8
        searchTxtField.delegate = self
        searchTxtField.addTarget(self, action: #selector(HomeViewController.textFieldDidBeginEditing(_:)), for: .editingChanged)
        // Do any additional setup after loading the view.
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
    @IBAction func sideMenuBtn(_ sender: UIButton) {
       
       
    }
    @IBAction func interiorBtn(_ sender: Any) {
        let vc  = self.storyboard!.instantiateViewController(withIdentifier: "InteriorViewController") as! InteriorViewController
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func crossActionBtn(_ sender: UIButton) {
        searchTxtField.text = ""
    }
    @IBAction func exteriorBtn(_ sender: UIButton) {
        let vc  = self.storyboard!.instantiateViewController(withIdentifier: "ExteriorViewController") as! ExteriorViewController
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}

//MARK:- Extention
extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
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
        }else if collectionView == collationViewForProducts
        {
            let cell = collationViewForProducts.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OurProductsCollectionViewCell
                   return cell
        }else if collectionView == collectionViewForProfessionals
        {
            let cell = collectionViewForProfessionals.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfessionalsCollectionViewCell
                   return cell
        }else
        {
            let cell = collectionViewForSliders.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SlidersCollectionViewCell
//            pageControl.currentPage = indexPath.row
            print(indexPath.row)
                   return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        return CGSize(width: self.collectionView.frame.size.width/2 - 20, height: self.collectionView.frame.size.width/2 + 30)
        if collectionView == collectionViewForSliders
        {
            return CGSize(width: self.collectionViewForSliders.frame.size.width, height: self.collectionViewForSliders.frame.size.height)
       
        } else if collectionView == collectionViewForRoom {
            return CGSize(width: self.collectionViewForRoom.frame.size.width / 4.57, height: self.collectionViewForRoom.frame.size.height * 0.5)
        }else if collectionView == collationViewForProducts
        {
            return CGSize(width: 150, height: 220)
        }else
        {
            return CGSize(width: 150, height: 190)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewForProfessionals
        {
            let vc  = self.storyboard!.instantiateViewController(withIdentifier: "ProfessionalDetailsViewController") as! ProfessionalDetailsViewController
            self.navigationController!.pushViewController(vc, animated: true)
        }else
        {
            let vc  = self.storyboard!.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
}
extension HomeViewController : UIScrollViewDelegate{
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
            let pageWidth = self.collectionViewForSliders.frame.size.width
            pageControl.currentPage = Int(self.collectionViewForSliders.contentOffset.x / pageWidth)
        }
    }
