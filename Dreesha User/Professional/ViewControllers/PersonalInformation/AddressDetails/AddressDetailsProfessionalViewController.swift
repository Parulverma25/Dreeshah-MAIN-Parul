//
//  AddressDetailsViewController.swift
//  Dreeshah
//
//  Created by promatics on 23/02/21.
//

import UIKit

class AddressDetailsProfessionalViewController: UIViewController {

    var parentNavigationController : UINavigationController?
    var viewModel = PersonalInfoViewModel()

    @IBOutlet weak var pincode: UILabel!
    @IBOutlet weak var AdressLine1: UILabel!
    @IBOutlet weak var addressLine2: UILabel!
    @IBOutlet weak var landmark: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var profileImageView: SetImage!
    @IBOutlet weak var ProfileLogoImage: SetImage!
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var firstName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "Personal Information")
        hitApiUserDetails()
    }
    
    
    @IBAction func editBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "EditProfessionalStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "EditAddressDetailsViewController") as! EditAddressDetailsViewController
        vc.isEdit = true
        vc.viewModel = viewModel
        parentNavigationController?.pushViewController(vc, animated: true)
    }
    
}



extension AddressDetailsProfessionalViewController {
    
    func hitApiUserDetails()  {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiUserDetailsProfessional(user_id: AppUser().user_id){(isSuccess,message) in
        
            if isSuccess{
                let url = URLS.profileImageUrl(self.viewModel.dataModel?.data?.profileImage ?? "").getDescription()
                self.profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                let urld = URLS.profileImageUrl(self.viewModel.dataModel?.data?.logoImage ?? "").getDescription()
                self.ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                self.pincode.text = String(self.viewModel.dataModel?.data?.professionalAddress?.pincode ?? 0)
                
                self.AdressLine1.text = self.viewModel.dataModel?.data?.professionalAddress?.addressLine1 ?? ""
                
                self.addressLine2.text = self.viewModel.dataModel?.data?.professionalAddress?.addressLine2 ?? ""
                
                self.firstName.text = self.viewModel.dataModel?.data?.professionalAddress?.addrFirstName ?? ""
                self.lastName.text = self.viewModel.dataModel?.data?.professionalAddress?.addrLastName ?? ""
                
                self.countryName.text = self.viewModel.dataModel?.data?.professionalAddress?.country ?? ""
                
                self.phoneNumber.text = "\(self.viewModel.dataModel?.data?.professionalAddress?.countryPhCode ?? "")-\(self.viewModel.dataModel?.data?.professionalAddress?.phoneNumber ?? "")"
                
                
//                self.houseNo.text = self.viewModel.dataModel?.data?.professionalAddress?.houseNo
//                self.area.text = self.viewModel.dataModel?.data?.professionalAddress?.area
                self.landmark.text = self.viewModel.dataModel?.data?.professionalAddress?.landmark
                self.city.text = self.viewModel.dataModel?.data?.professionalAddress?.city
                self.state.text = self.viewModel.dataModel?.data?.professionalAddress?.state
            } else {
                self.view.makeToast(message , position : .center)
            }
        }
    }
}
