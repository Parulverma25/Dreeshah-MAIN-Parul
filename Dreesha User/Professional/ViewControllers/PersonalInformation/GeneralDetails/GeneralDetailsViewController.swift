//
//  GeneralDetailsViewController.swift
//  Dreeshah
//
//  Created by promatics on 23/02/21.
//

import UIKit
import PageMenu
import SDWebImage


class CertificateGenralTableCell: UITableViewCell {
    
    @IBOutlet weak var certificateName: UILabel!
    @IBOutlet weak var certiImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}



class GeneralDetailsViewController: UIViewController {
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var branchNameEnglish: UILabel!
    @IBOutlet weak var branchNameArabic: UILabel!
    @IBOutlet weak var branchType: UILabel!
    @IBOutlet weak var branchBrief: UILabel!
    @IBOutlet weak var branchCategory: UILabel!
    @IBOutlet weak var certificateLabel: UILabel!
    @IBOutlet weak var imageCertificate: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileImageView: SetImage!
    @IBOutlet weak var ProfileLogoImage: SetImage!
    
    
    var viewModel = PersonalInfoViewModel()
    var typeModel = BranchTypeAndCategoryViewModel()

    var typeNameArray: [String] = []
    var typeidNameArray: [String] = []
    var categoryNameArray: [String] = []
    var categoryidNameArray: [String] = []
    
    
    var certificateArray: [String] = []
    
    var parentNavigationController : UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "Personal Information")
        hitApiUserDetails()
    }

    func branchTypeData() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        typeModel.hitBranchType { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            print(message)
            if isSuccess {
                self.typeNameArray = (self.typeModel.typeModelData?.data?.map({$0.name ?? ""}))!
                self.typeidNameArray = (self.typeModel.typeModelData?.data?.map({$0.id ?? ""}))!
                
                for i in 0..<self.typeidNameArray.count {
                    if self.typeidNameArray[i] == self.viewModel.dataModel?.data?.branchTypeID {
                        self.branchType.text = self.typeNameArray[i]
                        self.branchCategoryData(id: self.typeidNameArray[i])
                        return
                    }
                }
                
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    func branchCategoryData(id: String) {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        typeModel.hitBranchCategory(typeId: id) { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess {
                self.categoryNameArray = (self.typeModel.categoryModel?.data?.map({$0.name ?? ""}))!
                self.categoryidNameArray = (self.typeModel.categoryModel?.data?.map({$0.id ?? ""}))!
                
                for i in 0..<self.categoryidNameArray.count {
                    if self.categoryidNameArray[i] == self.viewModel.dataModel?.data?.branchCategoryID {
                        self.branchCategory.text = self.categoryNameArray[i]
                        return
                    }
                }
                
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    @IBAction func editBtn(_ sender: Any) {
        CurrentSession.shared.isProfesstionalSignUp = false
        
        let vc = UIStoryboard(name: "EditProfessionalStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "EditGeneralDeatilsViewController") as! EditGeneralDeatilsViewController
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "GeneralDetailViewController") as! GeneralDetailViewController
        vc.isEdit = true
        vc.viewModelP = viewModel
        vc.branchTypeVal = self.branchType.text ?? ""
        vc.branchCat = self.branchCategory.text ?? ""
        parentNavigationController?.pushViewController(vc, animated: true)
    }
}




extension GeneralDetailsViewController {
    
    func hitApiUserDetails()  {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiUserDetailsProfessional(user_id: AppUser().user_id){(isSuccess,message) in
        
            if isSuccess{
                print(message)
                print(self.viewModel)
                self.certificateArray.removeAll()
                let url = URLS.profileImageUrl(self.viewModel.dataModel?.data?.profileImage ?? "").getDescription()
                self.profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                let urld = URLS.profileImageUrl(self.viewModel.dataModel?.data?.logoImage ?? "").getDescription()
                self.ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                self.firstName.text = self.viewModel.dataModel?.data?.firstName
                self.lastName.text = self.viewModel.dataModel?.data?.lastName
                self.email.text = self.viewModel.dataModel?.data?.email
                self.branchNameEnglish.text = self.viewModel.dataModel?.data?.branchNameEn
                self.branchNameArabic.text = self.viewModel.dataModel?.data?.branchNameAr
                self.branchBrief.text = self.viewModel.dataModel?.data?.branchBrief
                for i in 0..<(self.viewModel.dataModel?.data?.certificateAwards?.count ?? 0) {
                    self.certificateArray.append((self.viewModel.dataModel?.data?.certificateAwards?[i].image ?? ""))
                self.branchTypeData()
                self.tableView.reloadData()
                }
            } else {
                self.view.makeToast(message , position : .center)
            }
        }
    }
}





//MARK:- Table View Delegates

extension GeneralDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return certificateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CertificateGenralTableCell
        self.viewHeightConstraint.constant = CGFloat(525 + (41 * certificateArray.count))
        cell.certificateName.text = certificateArray[indexPath.row]
        cell.certiImage.sd_setImage(with: URL(string: URLS.certificateImageUrl(certificateArray[indexPath.row]).getDescription()), placeholderImage: UIImage(named: "placeholder.png"))
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
