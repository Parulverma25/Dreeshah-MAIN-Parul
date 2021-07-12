//
//  ExteriorViewController.swift
//  Dreesha User
//
//  Created by promatics on 3/22/21.
//

import UIKit

class ExteriorViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
                layout.minimumLineSpacing = 5
                layout.minimumInteritemSpacing = 5
                self.collectionView?.collectionViewLayout = layout
        // Do any additional setup after loading the view.
    }

}
extension ExteriorViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.row % 2 == 0
//        {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ExteriorCollectionViewCell
//            cell.imageHeight.constant = 140
              return cell
//        }
//        else
//        { let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InteriorCollectionViewCell
////            cell.imageHeight.constant = 280
//          return cell
//
//        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            return CGSize(width: self.collectionView.frame.size.width/2 - 10, height: self.collectionView.frame.size.width/2 + 80)
       
      
    }
   
 
}
