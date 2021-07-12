//
//  BranchDetailsViewController.swift
//  Dreeshah
//
//  Created by promatics on 23/02/21.
//

import UIKit

class BranchDetailsViewController: UIViewController {

    var parentNavigationController : UINavigationController?
    var viewModel = PersonalInfoViewModel()


    @IBOutlet weak var noOfBranch: UILabel!
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
        let vc = UIStoryboard(name: "EditProfessionalStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "EditBranchDetailsViewController") as! EditBranchDetailsViewController
        vc.isEdit = true
        vc.viewModelP = viewModel
        parentNavigationController?.pushViewController(vc, animated: true)
    }
}


extension BranchDetailsViewController {
    
    func hitApiUserDetails()  {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiUserDetailsProfessional(user_id: AppUser().user_id){(isSuccess,message) in
        
            if isSuccess{
                let url = URLS.profileImageUrl(self.viewModel.dataModel?.data?.profileImage ?? "").getDescription()
                self.profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                let urld = URLS.profileImageUrl(self.viewModel.dataModel?.data?.logoImage ?? "").getDescription()
                self.ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))

                if (self.viewModel.dataModel?.data?.noOfBranches) == nil{
                    print(self.viewModel.dataModel?.data?.noOfBranches)
                }else{
                self.noOfBranch.text = String((self.viewModel.dataModel?.data?.noOfBranches)!)
                }
            } else {
                self.view.makeToast(message , position : .center)
            }
        }
    }
}
