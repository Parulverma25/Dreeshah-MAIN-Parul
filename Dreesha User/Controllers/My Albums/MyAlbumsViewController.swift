//
//  MyAlbumsViewController.swift
//  Dreesha User
//
//  Created by Promatics on 11/03/21.
//

import UIKit

class MyAlbumsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    let itemsPerRow: CGFloat = 3
    var albumArrayLabel =  ["Kitchen","Garden","Outdoor","Pool","Eatery","Living Room","Dining Room" ,"Store Room"]
    var albumArrayImages = [ #imageLiteral(resourceName: "Outside"), #imageLiteral(resourceName: "Sofas"), #imageLiteral(resourceName: "Garden"), #imageLiteral(resourceName: "Pool"), #imageLiteral(resourceName: "Kitchen"), #imageLiteral(resourceName: "Stairs"), #imageLiteral(resourceName: "Outside"), #imageLiteral(resourceName: "Sofas") ]
    @IBOutlet weak var AlbumClctnview: UICollectionView!
    @IBOutlet weak var AlbumSearchBar: UISearchBar!
    
    //MARK: Variable
    var viewModel = MyAlbumsViewModel()
    
    //MY Album View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden=true
        AlbumClctnview.delegate=self
        AlbumClctnview.dataSource=self
        AlbumClctnview.reloadData()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "My Albums")
        albumListing()
    }
    
    //Mark Button Outlet
    @IBAction func albmBtn1(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AlbumFormViewController") as! AlbumFormViewController

        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getAlbumlistData()?.result.count ??  0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Albums Cell", for: indexPath) as! MyAlbumsCollectionViewCell
        cell.Albmlbl1.text = viewModel.model?.result[indexPath.row]?.albumName ?? ""
        if (self.viewModel.model?.result[indexPath.row]?.albumImages.first??.mediaType ?? "").lowercased() == "video/mp4"{
            cell.videoIcon.isHidden = false
            cell.AlbumImgView.image = (self.viewModel.model?.result[indexPath.row]?.albumImages.first!)?.thumbnail ?? UIImage(named: "videoPlaceholder")
        }
        else{
            cell.videoIcon.isHidden = true
            let url = URLS.albumImageUrl(self.viewModel.model?.result[indexPath.row]?.albumImages.first??.image ?? "").getDescription()
            cell.AlbumImgView.sd_setImage(with: URL(string: url),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
            
            cell.AlbumImgView.layer.cornerRadius = 15
        }
        
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch (indexPath.row) {
        case 0:
          let  vc = storyboard?.instantiateViewController(withIdentifier: "AlbumDetailsViewController") as! AlbumDetailsViewController
            vc.AlbumIdValStr = viewModel.getAlbumlistData()?.result[indexPath.row]?.id ?? ""
            vc.AlbumMediaIdValStr = viewModel.getAlbumlistData()?.result[indexPath.row]?.albumImages.first??.id ?? ""
            vc.hidesBottomBarWhenPushed=true
            
            navigationController?.pushViewController(vc, animated: true)
        
        default:
           let vc = storyboard?.instantiateViewController(withIdentifier: "AlbumDetailsViewController") as! AlbumDetailsViewController
            vc.AlbumIdValStr = viewModel.getAlbumlistData()?.result[indexPath.row]?.id ?? ""
            vc.hidesBottomBarWhenPushed=true
            navigationController?.pushViewController(vc, animated: true)
        }
}
}

extension MyAlbumsViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/2 - 2, height: collectionViewWidth/2 - 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
//MARK:- API CALL
extension MyAlbumsViewController {
    func albumListing(){
        
        viewModel.apiAlbumList(Limit: "15", Offset: "0" ) { (isSucess, message) in
            if isSucess{
                self.AlbumClctnview.reloadData()
                }
            else{
                if message == "no records"{
                    self.AlbumClctnview.reloadData()
                    tableCollectionErrors(view: self.AlbumClctnview, text: "No album is created yet")
                }else{
                    self.showDefaultAlert(Message: message)
                }
            }
        }
    }
}
