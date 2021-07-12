//
//  MyProfileViewController.swift
//  Dreesha User
//
//  Created by Apple on 25/03/21.
//

import UIKit

class MyProfileViewController: UIViewController {

    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userView: UIView!
    
    var ArrayofLabels: [String]! = []
    var viewModel = PersonalInfoViewModel()
    var ArrayofImages: [UIImage]! = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        SetSize()
        makeRounded()
        ArrayofImages = [#imageLiteral(resourceName: "personalInformation.png"),#imageLiteral(resourceName: "changePassword.png")]
        ArrayofLabels = ["Personal Information", "Change Password"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "Professional")
        
        hitApiUserDetails()
        
    }
}

extension MyProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayofLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserTableViewCell
        cell.LabelView.text=ArrayofLabels[indexPath.row]
        cell.ImgView.image=ArrayofImages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let vc = UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "PersonalInformationBaseViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func makeRounded() {

//        ImgViewUpper.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
//        ImgViewUpper.layer.borderColor = UIColor.black.cgColor
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.clipsToBounds = true
        SetSize()
    }
    
    func SetSize(){
        userView.layer.cornerRadius = 30;
        userView.layer.masksToBounds = true;
    }
}

extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }

    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }

    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }

    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}

extension MyProfileViewController {
    
    func hitApiUserDetails()  {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiUserDetailsProfessional(user_id: AppUser().user_id){(isSuccess,message) in
        
            if isSuccess{
                let url = URLS.profileImageUrl(self.viewModel.dataModel?.data?.profileImage ?? "").getDescription()
                self.userImage.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                self.userNameLabel.text = "\(self.viewModel.dataModel?.data?.firstName ?? "")  \(self.viewModel.dataModel?.data?.lastName ?? "")"
               
                }else {
                self.view.makeToast(message , position : .center)
            }
        }
    }
}
