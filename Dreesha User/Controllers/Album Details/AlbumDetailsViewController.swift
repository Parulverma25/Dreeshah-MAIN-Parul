
import UIKit
import AVKit
import AVFoundation

class AlbumDetailsViewController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource, ImagePickerDelegete {
   
    var albumArrayImages = [UIImage]()

    //MARK:- Outlets
    
    @IBOutlet weak var VideoView: AvpVideoPlayer!
    @IBOutlet weak var ImgView1: UIImageView!
    @IBOutlet weak var editBtn1: UIButton!
    @IBOutlet weak var TrashBtn2: UIButton!
    @IBOutlet weak var Lbl1: UILabel!
    @IBOutlet weak var Lbl2: UILabel!
    @IBOutlet weak var AlbmDtlClctnView: UICollectionView!
    
    //MARK: Variables
    var imageUrl = ""
    let itemsPerRow: CGFloat = 3
    var imagePicker = ImagePickerViewControler()
    var viewModel =  AlbumDetailsViewModel()
    var imageData = Data()
    var AlbumIdValStr = ""
    var AlbumMediaIdValStr = ""
    var newimg = UIImage()
    var ImageName = String()
    var ImageType = String()
    var imageParam = String()
    
    //MARK: View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden=true
        AlbmDtlClctnView.delegate=self
        AlbmDtlClctnView.dataSource=self
        AlbmDtlClctnView.reloadData()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    /**
     Parul Verma edited this code on 12-7-21
     */
    
    /*
     Now the change is edited from abhishek's end.
     */
    
    /**
     Check it now again.
     */
    
    
    
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "Album Details")
        hitApiAlbumDetailsList()
    }
    
    //MARK:- Custom Methods
    
    func playVideo(videoUrl:String){
        VideoView.configure(url: videoUrl)
        VideoView.isLoop = false
        VideoView.play()
    }
    
    //Mark:-Edit Button
    
    @IBAction func EditBtn1(_ sender: UIButton) {
        imagePicker.imagePickerDelegete = self
        imagePicker.showImagePicker(viewController: self)
    }
    
    @IBAction func TrashBtn(_ sender: Any) {
        deleteAlbum(AlbumID: AlbumIdValStr, AlbumMediaID: AlbumMediaIdValStr)
    }
    
    func disFinishPicking(imgData: Data, img: UIImage) {
        ImgView1.image=img
        imageData = img.jpegData(compressionQuality: 0.6)!
        hitApieditAlbum()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        AlbumMediaIdValStr = viewModel.model?.result.albumImages.first?.id ?? ""
        imageUrl = URLS.albumImageUrl(self.viewModel.getAlbumDetailsData()?.result.albumImages[indexPath.row].image ?? "").getDescription()
        ImgView1.sd_setImage(with: URL(string : imageUrl), placeholderImage: #imageLiteral(resourceName: "Placehold"))
        
        if self.viewModel.getAlbumDetailsData()?.result.albumImages[indexPath.row].mediaType == "video/mp4"{
            self.playVideo(videoUrl: imageUrl)
            self.VideoView.isHidden = false
            self.ImgView1.isHidden = true
        }
        else{
            self.VideoView.isHidden = true
            self.ImgView1.isHidden = false
        }
        
        AlbumMediaIdValStr =  viewModel.model?.result.albumImages[indexPath.row].id ?? ""
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getAlbumDetailsData()?.result.albumImages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Album Detail Cell", for: indexPath) as! AlbumDetailCollectionViewCell
       
        if viewModel.model?.result.albumImages[indexPath.row].mediaType != "video/mp4"{
            cell.videoIcon.isHidden = true
            imageUrl = URLS.albumImageUrl(self.viewModel.getAlbumDetailsData()?.result.albumImages[indexPath.row].image ?? "").getDescription()
            cell.ImgView1Cell.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
        }
        else{
            cell.videoIcon.isHidden = false
            cell.ImgView1Cell.image = self.viewModel.model?.result.albumImages[indexPath.row].thumbnail ?? #imageLiteral(resourceName: "videoPlaceholder")
        }
        
        return cell
    }
}


extension AlbumDetailsViewController : UICollectionViewDelegateFlowLayout{
    
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


//MARK:- API Call
extension AlbumDetailsViewController{
    
    //MARK: ALBUMS DetailList API
    
    func hitApiAlbumDetailsList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiAlbumDetails(Album_id: AlbumIdValStr){(isSuccess , message) in
            if isSuccess{
                self.Lbl1.text = self.viewModel.getAlbumDetailsData()?.result.albumName
                self.Lbl2.text = self.viewModel.model?.result.subCategoryID?.name
                let imageUrl = URLS.albumImageUrl(self.viewModel.getAlbumDetailsData()?.result.albumImages.first?.image ?? "").getDescription()
                if self.viewModel.getAlbumDetailsData()?.result.albumImages.first?.mediaType == "video/mp4"{
                    self.VideoView.isHidden = false
                    self.ImgView1.isHidden = true
                    self.playVideo(videoUrl: imageUrl)
                }
                else{
                    self.VideoView.isHidden = true
                    self.ImgView1.isHidden = false
                    self.ImgView1.sd_setImage(with: URL(string : imageUrl),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
                }
                
                self.AlbmDtlClctnView.reloadData()
            }else{
                if message == "Error while fetching" {
                    self.showAlertWithAction(Title: "Dreeshah", Message: "Album Deleted!", ButtonTitle: "OK") {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }else{
                    self.view.makeToast(message , position : .center)
                }
            }
        }
    }
    
    //MARK: ALBUMS EDIT API
    func hitApieditAlbum(){
        
        viewModel.hiteditAlbum(AlbumID: AlbumIdValStr, AlbumMediaID: AlbumMediaIdValStr ,imageName: GenerateUniqueName(), imageData: imageData, imageMime: "image/jpeg")
        { (isSuccess , message ) in
            
            if isSuccess{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    let url = URLS.albumImageUrl(self.viewModel.getAlbumDetailsData()?.result.albumImages.first?.image ?? "" ).getDescription()
                    self.ImgView1.sd_setImage(with: URL(string: url),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
                    self.hitApiAlbumDetailsList()
                }
            }
            else {
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    
    //MARK: DELETE Album API
    func deleteAlbum(AlbumID : String , AlbumMediaID : String){
        viewModel.hitDeleteAlbum(Album_id: AlbumID , Album_media_id: AlbumMediaID) { (isSuccess, message) in
            if isSuccess{
                self.view.makeToast( "File Deleted!" , position : .center)
                self.AlbmDtlClctnView.reloadData()
                self.AlbumMediaIdValStr = self.viewModel.getAlbumDetailsData()?.result.albumImages.first?.id ?? ""
                self.hitApiAlbumDetailsList()
            }
            else
            {
                self.view.makeToast(message , position : .center)
                
            }
        }
    }
}

