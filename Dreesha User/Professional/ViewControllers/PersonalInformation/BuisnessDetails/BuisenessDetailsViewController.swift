//
//  BuisenessDetailsViewController.swift
//  Dreeshah
//
//  Created by promatics on 23/02/21.
//

import UIKit
import SDWebImage


class BusinessCountryCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
}

class BusinessCityCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
}

class BuisenessDetailsViewController: UIViewController {
    
    //MARK:- Outlets
    
    
    @IBOutlet weak var establishmentYear: UILabel!
    @IBOutlet weak var branchLicence: UILabel!
    @IBOutlet weak var licenceNo: UILabel!
    @IBOutlet weak var noOfEmp: UILabel!
    
    @IBOutlet weak var certificateImage: UIImageView!
    
    @IBOutlet weak var countryCollectionView: UICollectionView!
    
    @IBOutlet weak var cityCollectionView: UICollectionView!
    @IBOutlet weak var profileImageView: SetImage!
    @IBOutlet weak var ProfileLogoImage: SetImage!
    
    //MARK:- Variables
    var headerVal = ["Countries" , "Cities"]
    var countryName = ["a" , "b"]
    var Cities = ["c" , "d"]
    
    var parentNavigationController : UINavigationController?
    var viewModel = PersonalInfoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "Personal Information")
        hitApiUserDetails()
    }
    
    @IBAction func editBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "EditProfessionalStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "EditBuisnessDetailsViewController") as! EditBuisnessDetailsViewController
        vc.isEdit = true
        vc.viewModelP = viewModel
        vc.countryName = countryName
        vc.cityName = Cities
        parentNavigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Collection View Delegates
extension BuisenessDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return headerVal.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCollectionReusableView", for: indexPath)as! headerCollectionReusableView
//        header.countryName.text = headerVal[indexPath.section]
//        return header
//    }
//    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == countryCollectionView{
            return countryName.count
        }else{
            return Cities.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCityCollectionViewCell", for: indexPath) as! CountryCityCollectionViewCell
//        if indexPath.section == 0 {
//            cell.countryName.text = countryName[indexPath.row]
//        } else {
//            cell.countryName.text = Cities[indexPath.row]
//        }
//        return cell
        
        if collectionView == countryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BusinessCountryCell
            cell.nameLabel.text = countryName[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BusinessCityCell
            cell.nameLabel.text = Cities[indexPath.row]
            return cell
        }
    }
    
    
}



extension BuisenessDetailsViewController {
    
    func hitApiUserDetails()  {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiUserDetailsProfessional(user_id: AppUser().user_id){(isSuccess,message) in
        
            if isSuccess{
                let url = URLS.profileImageUrl(self.viewModel.dataModel?.data?.profileImage ?? "").getDescription()
                self.profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                let urld = URLS.profileImageUrl(self.viewModel.dataModel?.data?.logoImage ?? "").getDescription()
                self.ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                self.establishmentYear.text = String(self.viewModel.dataModel?.data?.businessDetails?.branchYear ?? 0)
                self.licenceNo.text = self.viewModel.dataModel?.data?.businessDetails?.licenceNumber
                self.noOfEmp.text = self.viewModel.dataModel?.data?.businessDetails?.noOfEmp
                self.branchLicence.text = self.viewModel.dataModel?.data?.businessDetails?.branchLicence
                
                self.certificateImage.sd_setImage(with: URL(string: URLS.certificateImageUrl((self.viewModel.dataModel?.data?.businessDetails?.branchLicence)!).getDescription()), placeholderImage: UIImage(named: "placeholder.png"))

                self.countryName.removeAll()
                self.Cities.removeAll()
                
                self.countryName.insert(contentsOf: (self.viewModel.dataModel?.data?.businessDetails?.issuedInCountries)!, at: 0)
                
                self.Cities.insert(contentsOf: (self.viewModel.dataModel?.data?.businessDetails?.issuedInCities)!, at: 0)
                self.countryCollectionView.reloadData()
                self.cityCollectionView.reloadData()
            } else {
                self.view.makeToast(message)
            }
        }
    }
}
