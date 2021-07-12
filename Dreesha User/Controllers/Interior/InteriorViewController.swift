//
//  InteriorViewController.swift
//  Dreesha User
//
//  Created by Apple on 20/03/21.
//

import UIKit

class InteriorViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden=true
        
        crossBtn.isHidden = true
        let layout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
                layout.minimumLineSpacing = 5
                layout.minimumInteritemSpacing = 5
                self.collectionView?.collectionViewLayout = layout
               
        searchTxtField.delegate = self
        searchTxtField.addTarget(self, action: #selector(self.textFieldDidBeginEditing(_:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
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
    @IBAction func crossActionBtn(_ sender: UIButton) {
        searchTxtField.text = ""
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension InteriorViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.row % 2 == 0
//        {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InteriorCollectionViewCell
//            cell.imageHeight.constant = 140
              return cell
//
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            return CGSize(width: self.collectionView.frame.size.width/2 - 10, height: self.collectionView.frame.size.width/2 + 80)
       
      
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc  = self.storyboard!.instantiateViewController(withIdentifier: "CatalogueDetailsViewController") as! CatalogueDetailsViewController
        self.navigationController!.pushViewController(vc, animated: true)
    }
   
    
}
