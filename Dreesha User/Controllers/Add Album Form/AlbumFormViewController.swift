//
//  AlbumFormViewController.swift
//  Dreesha User
//
//  Created by Promatics on 11/03/21.
//

import UIKit
import iOSDropDown
class AlbumFormViewController: UIViewController, Image_VideoPickerDelegate {
   
    
    
    //MARK: OUTLETs
    @IBOutlet weak var AlbumName: SkyFloatingLabelTextField!
    @IBOutlet weak var AlbumCategory: DropDown!
    @IBOutlet weak var AddAlbumCollectionView: UICollectionView!
    
    //MARK: Variables
    var viewModel = AddAlbumViewModel()
    
    var imagePicker = ImagePickerViewControler()
    var SubstrVal = ""
    var imageData = Data()
    var videoData = Data()
    var ArrImg = [ #imageLiteral(resourceName: "Bed Image 1"), #imageLiteral(resourceName: "Kitchen"), #imageLiteral(resourceName: "ford_gt_4k_3") ]
    var arrnewImg = [UIImage]()
    var arrImageData = [Data]()
    var arrImageName = [String]()
    var arrImageType = [String]()
    var selectedImage = UIImage()
    var imageParam = [String]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        AddAlbumCollectionView.delegate=self
        AddAlbumCollectionView.dataSource=self
        AddAlbumCollectionView.reloadData()

        AlbumCategory.didSelect { (name, index, id) in
            self.SubstrVal = self.viewModel.SubModel?.data?[index].id ?? ""
        }
        
        self.hideKeyboardWhenTappedAround()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "Add New Album")
        AddAlbumCollectionView.reloadData()
        Subcategory()
    }
    
    
    @IBAction func SubmitBtn(_ sender: SetButton) {
        if self.AlbumName.text?.replacingOccurrences(of: " ", with: "") == "" {
            self.view.makeToast("Please Enter Album Name!" , position : .center)
        }
        else if self.AlbumCategory.text == "" {
            self.view.makeToast("Please Enter Album Category!" , position : .center)
        }else{
        hitApiaddAlbum()
    }
}
    
    @IBAction func CrossbuttonTapped(_ sender: UIButton) {
       
        arrnewImg.remove(at: sender.tag)
        arrImageData.remove(at: sender.tag)
        arrImageName.remove(at: sender.tag)
        arrImageType.remove(at: sender.tag)
        imageParam.remove(at: sender.tag)
        AddAlbumCollectionView.reloadData()
    }
    

    @IBAction func AddNewFile(_ sender: UIButton) {
        imagePicker.Image_Videos_PickerDelegate = self
        imagePicker.showImage_videoPicker(viewController: self)
    }
    
    func disFinishPickingforVid(imgData: Data, img: UIImage) {
        arrnewImg.append(img)
             arrImageData.append(img.jpegData(compressionQuality: 0.6)!)
             arrImageName.append(GenerateUniqueName())
             arrImageType.append("image/jpeg")
             imageParam.append("album_images")
             
             AddAlbumCollectionView.reloadData()
    }
    
    func didFinishVideoPickingforvid(videoData: Data, thumbnail: UIImage) {
        arrnewImg.append(thumbnail)
        arrImageData.append(videoData)
      
              arrImageName.append(GenerateUniqueVideoName())
              arrImageType.append("video/mp4")
              imageParam.append("album_images")
              AddAlbumCollectionView.reloadData()
    }
    
}


extension AlbumFormViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrnewImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AddAlbumCollectionViewCell
        cell.AddAlbumImageView.image = arrnewImg[indexPath.row]
        cell.CrossBtn.tag = indexPath.row
        cell.CrossBtn.addTarget(self, action: #selector(CrossbuttonTapped(_:)), for: .touchUpInside)
        return cell
    }
}

//MARK:- API CALL
extension AlbumFormViewController {
func hitApiaddAlbum(){
    Indicator.shared.showProgressView(self.parent?.view ?? self.view)
    
    viewModel.hitaddAlbum( subCat: SubstrVal, imageParam: imageParam, AlbumName: AlbumName.text?.replacingOccurrences(of: " ", with: "") ?? "", imageName: arrImageName, imageData: arrImageData, imageMime: arrImageType) { (isSuccess , message ) in
        Indicator.shared.hideProgressView()
        if isSuccess{
            self.view.makeToast(message , position : .center)
            self.AddAlbumCollectionView.reloadData()
            self.navigationController?.popViewController(animated: true)
    }else
        {
        self.view.makeToast(message , position : .center)
    }
}
}
    
    
    func Subcategory(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitserviceSubCategories { (isSuccess, message) in

            Indicator.shared.hideProgressView()
            if isSuccess{
                let SubcategoryNames = self.viewModel.SubModel?.data?.map({$0.name ?? ""})
                
                self.AlbumCategory.optionArray = SubcategoryNames ?? []
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
}
