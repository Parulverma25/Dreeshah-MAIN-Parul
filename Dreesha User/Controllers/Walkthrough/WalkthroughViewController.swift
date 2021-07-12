//
//  WalkthroughViewController.swift
//  Dreesha User
//
//  Created by Promatics on 22/03/21.
//

import UIKit

class WalkthroughViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
//Mark Outlets
    @IBOutlet weak var WalkThroughCollectionViewCell: UICollectionView!
    @IBOutlet weak var Prev: UIButton!
    @IBOutlet weak var NextButtonLabel: UIButton!
    @IBOutlet weak var GetStartButton: SetButton!
    
//MARK Variables
    var ArrLabel1=["Get Inspired" , "Find Products" ,"Hire Professionals"]
    var ArrLabel2=["Lorem Ipsum is simply dummy text of the printing and typescreen Industry","Lorem Ipsum is simply dummy text of the printing and typescreen Industry","Lorem Ipsum is simply dummy text of the printing and typescreen Industry",]
    var ArrImage = [ #imageLiteral(resourceName: "walkthrough-1"), #imageLiteral(resourceName: "walkthrough 2"), #imageLiteral(resourceName: "walkthrough-3")]
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        WalkThroughCollectionViewCell.delegate=self
        WalkThroughCollectionViewCell.dataSource=self
        WalkThroughCollectionViewCell.reloadData()
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: Actions
    @IBAction func PrevBtn(_ sender: Any) {
        let visibleItems: NSArray = self.WalkThroughCollectionViewCell.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        if nextItem.row < ArrImage.count && nextItem.row >= 0{
            self.WalkThroughCollectionViewCell.scrollToItem(at: nextItem, at: .right, animated: true)
        }
    }
    
    @IBAction func NextBtn(_ sender: Any)
    {
        let visibleItems: NSArray = self.WalkThroughCollectionViewCell.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
               if nextItem.row < ArrImage.count {
            self.WalkThroughCollectionViewCell.scrollToItem(at: nextItem, at: .left, animated: true)
        }
    }
    
    @IBAction func GetStartAction(_ sender: Any)   {
       let visibleItems: NSArray = self.WalkThroughCollectionViewCell.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
               if nextItem.row < ArrImage.count {
            self.WalkThroughCollectionViewCell.scrollToItem(at: nextItem, at: .left, animated: true)
               }else if (self.GetStartButton.currentTitle == "GOT IT") {
            let vc = storyboard?.instantiateViewController(identifier: "SelectUserTypeViewController") as! SelectUserTypeViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension WalkthroughViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrLabel1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WalkthroughCollectionViewCell
        cell.Label1.text=ArrLabel1[indexPath.row]
        cell.Label2.text=ArrLabel2[indexPath.row]
        cell.ImageView.image=ArrImage[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        NextButtonLabel.isHidden = (indexPath.row == collectionView.numberOfItems(inSection: 0) - 1)
        Prev.isHidden = (indexPath.row == 0)
        if indexPath.row == 0
        {
            GetStartButton.setTitle("GET STARTED", for: .normal)
        }
        else if indexPath.row == 1{
            GetStartButton.setTitle("LET'S GO", for: .normal)
        }
        else{
            GetStartButton.setTitle("GOT IT", for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.WalkThroughCollectionViewCell.bounds.width / 1 - 1, height: self.WalkThroughCollectionViewCell.bounds.height / 1 - 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
