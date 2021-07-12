//
//  OrderGridViewController.swift
//  Dreeshah
//
//  Created by Promatics on 19/03/21.
//

import UIKit

class OrderGridViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
//MARk Outlets
    @IBOutlet weak var ClctnView: UICollectionView!
    
    //Mark Variables
       var ArrLabel1 = ["Designer Bed","Sofa","Italian Lamp","Tiles"]
       var ArrImg1 = [#imageLiteral(resourceName: "Bed Image 1"),#imageLiteral(resourceName: "Sofa IMG2"),#imageLiteral(resourceName: "Light Img 3"),#imageLiteral(resourceName: "buildingConst")]
                       

    override func viewDidLoad() {
        super.viewDidLoad()
        ClctnView.delegate=self
        ClctnView.dataSource=self
        ClctnView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Order Management")
    }
    
    @IBAction func listView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


//Mark Collection View Delegate Functions
extension OrderGridViewController{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrLabel1.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OrderGridCollectionViewCell
        cell.ImageView1.image=ArrImg1[indexPath.row]
        cell.Label1.text=ArrLabel1[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.ClctnView.bounds.width / 2 - 2, height: self.ClctnView.bounds.height / 2 - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "OrderManageentDetailsViewController") as! OrderManageentDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
