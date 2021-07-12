//
//  CatalogueDetailsViewController.swift
//  Dreesha User
//
//  Created by promatics on 3/23/21.
//

import UIKit

class CatalogueDetailsViewController: UIViewController {

    @IBOutlet weak var collectionViewForOther: UICollectionView!
    @IBOutlet weak var collectionViewForGalary: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        setBackWithTitle(titleVal: "Catalogue Details")
    }
}
extension CatalogueDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if collectionView == collectionViewForGalary
      {
        let cell = collectionViewForGalary.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CatalogueGalaryCollectionViewCell
      return cell
      }else
      {
        let cell = collectionViewForOther.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CatalogueOtherProjectsCollectionViewCell
        return cell
      }
              

        
    }
    

   
 
}

