//
//  ProductGridViewController.swift
//  Dreesha User
//
//  Created by Apple on 26/03/21.
//

import UIKit

class ProductGridCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var image1: SetImage!
    
    @IBOutlet weak var comPrice: UILabel!
    @IBOutlet weak var priceOfProduct: UILabel!
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var stateName: UIButton!
    @IBOutlet weak var duration: UIButton!
    @IBOutlet weak var priceOfService: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var discriptions: UILabel!
    @IBOutlet weak var outsideBtn : UIButton!

    @IBOutlet weak var AddToCollectionBtns: UIButton!
    
}



class ProductGridViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nameLabel: UILabel!
    var ArrLabel1 = ["Designer Bed","Sofa","Italian Lamp","Tiles"]
    var ArrImg1 = [ #imageLiteral(resourceName: "1IMG"), #imageLiteral(resourceName: "2IMG"), #imageLiteral(resourceName: "3IMG"),#imageLiteral(resourceName: "buildingConst")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CurrentSession.shared.isServiceListProfesstional {
            nameLabel.text = "Service List"
        } else {
            nameLabel.text = "Product List"
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CurrentSession.shared.isServiceListProfesstional {
            setBackWithTitle(titleVal: "Service List")
        } else {
            setBackWithTitle(titleVal: "Product List")
        }
    }
    
    @IBAction func AddToCollectionBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SelectCollectionViewController") as! SelectCollectionViewController
        vc.productIDVal = ""
    }
    
    
    
    
    @IBAction func listBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addProduct(_ sender: Any) {
        if CurrentSession.shared.isServiceListProfesstional {
            
        } else {
            let vc = self.storyboard?.instantiateViewController(identifier: "AddProductViewController") as! AddProductViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


extension ProductGridViewController : UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrLabel1.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductGridCollectionCell
        cell.image1.image=ArrImg1[indexPath.row]
        if CurrentSession.shared.isServiceListProfesstional {
            cell.serviceView.isHidden = false
            cell.productView.isHidden = true
        } else {
            cell.serviceView.isHidden = true
            cell.productView.isHidden = false
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width / 2 - 2, height: self.collectionView.bounds.height / 1.5 - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if CurrentSession.shared.isServiceListProfesstional {
            let vc = self.storyboard?.instantiateViewController(identifier: "ProfServiceDetailsViewController") as! ProfServiceDetailsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(identifier: "ProfProductDetailsViewController") as! ProfProductDetailsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
