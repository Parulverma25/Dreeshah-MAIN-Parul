//
//  ContactDetailsViewController.swift
//  Dreeshah
//
//  Created by promatics on 23/02/21.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    var parentNavigationController : UINavigationController?
    var viewModel = PersonalInfoViewModel()

    @IBOutlet weak var nameEnglish: UILabel!
    @IBOutlet weak var nameArabic: UILabel!
    @IBOutlet weak var branchEmail: UILabel!
    @IBOutlet weak var branchWebsite: UILabel!
    @IBOutlet weak var mobileNo: UILabel!
    @IBOutlet weak var businessMobileNo: UILabel!
    @IBOutlet weak var instaAcc: UILabel!
    @IBOutlet weak var youtubeAcc: UILabel!
    @IBOutlet weak var profileImageView: SetImage!
    @IBOutlet weak var ProfileLogoImage: SetImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "Personal Information")
        hitApiUserDetails()
    }

    @IBAction func editBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "EditProfessionalStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "EditContactDetailsViewController") as! EditContactDetailsViewController
        vc.isEdit = true
        vc.viewModel = viewModel
        parentNavigationController?.pushViewController(vc, animated: true)
    }
}


extension ContactDetailsViewController {
    
    func hitApiUserDetails()  {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiUserDetailsProfessional(user_id: AppUser().user_id){(isSuccess,message) in
        
            if isSuccess{
                let url = URLS.profileImageUrl(self.viewModel.dataModel?.data?.profileImage ?? "").getDescription()
                self.profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                let urld = URLS.profileImageUrl(self.viewModel.dataModel?.data?.logoImage ?? "").getDescription()
                self.ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                self.nameEnglish.text = self.viewModel.dataModel?.data?.contactDetails?.coOrdinatorEng
                self.nameArabic.text = self.viewModel.dataModel?.data?.contactDetails?.coOrdinatorArabic
                self.branchEmail.text = self.viewModel.dataModel?.data?.contactDetails?.branchEmail
                self.branchWebsite.text = self.viewModel.dataModel?.data?.contactDetails?.branchWebsite
                self.mobileNo.text = ((self.viewModel.dataModel?.data?.contactDetails?.countryCode)! + "-" + (self.viewModel.dataModel?.data?.contactDetails?.mobileNumber)!)
                self.businessMobileNo.text = ((self.viewModel.dataModel?.data?.contactDetails?.businessCountryCode)! + "-" + (self.viewModel.dataModel?.data?.contactDetails?.businessMobileNumber)!)
                self.instaAcc.text = self.viewModel.dataModel?.data?.contactDetails?.instaAcc
                self.youtubeAcc.text = self.viewModel.dataModel?.data?.contactDetails?.youtubeChannel
            } else {
                self.view.makeToast(message)
            }
        }
    }
}
