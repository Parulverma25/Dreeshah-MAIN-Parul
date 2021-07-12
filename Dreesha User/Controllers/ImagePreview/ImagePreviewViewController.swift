//
//  ImagePreviewViewController.swift
//  VSFileManager
//
//  Created by promatics on 3/17/1400 AP.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var imagePreviewCollection: UICollectionView!
    @IBOutlet weak var shareBtn: UIButton!
    
    //MARK:- Varibales
    
    var imageArray = [UIImage]()
    var sliderImages = [String]()
    var startIndex: Int = 0
    var onceOnly = false

    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePreviewCollection.delegate = self
        imagePreviewCollection.dataSource = self
        imagePreviewCollection.reloadData()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        imagePreviewCollection.setNeedsLayout()
        imagePreviewCollection.layoutIfNeeded()
    }
    
    //MARK:- IbACtions
    
    @IBAction func tapShare(_ sender: UIButton) {
        
        guard let indexPath = self.imagePreviewCollection.indexPathsForVisibleItems.first else {
            return
        }
        if var topController = UIApplication.shared.windows.first?.rootViewController{
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            let vc = UIActivityViewController(activityItems: [imageArray[indexPath.row]], applicationActivities: [])
            topController.present(vc, animated: true, completion: nil)
        }
        
        print("Share code")
    }
    
    
    @IBAction func tapDone(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- Collection View Delegates
extension ImagePreviewViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagePreviewCollectionViewCell", for: indexPath) as! imagePreviewCollectionViewCell
        
        
        let image = UIImageView()
        
        cell.image.sd_setImage(with: URL(string: sliderImages[indexPath.row]), placeholderImage: #imageLiteral(resourceName: "Placehold"))
        cell.imageScrollView.setup()
        
        image.sd_setImage(with: URL(string: sliderImages[indexPath.row]), placeholderImage: #imageLiteral(resourceName: "Placehold"))

        cell.imageScrollView.display(image: image.image ?? #imageLiteral(resourceName: "Placehold"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: imagePreviewCollection.frame.width , height: imagePreviewCollection.frame.height)
        
    }
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if !onceOnly {
                //set the row and section you need.
                let indexToScrollTo = IndexPath(row: startIndex, section: 0)
                self.imagePreviewCollection.scrollToItem(at: indexToScrollTo, at: .right, animated: false)
                onceOnly = true
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

