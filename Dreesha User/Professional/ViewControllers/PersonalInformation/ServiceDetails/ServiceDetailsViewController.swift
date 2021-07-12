//
//  ServiceDetailsViewController.swift
//  Dreeshah
//
//  Created by promatics on 23/02/21.
//

import UIKit


class ServiceCountryAndCityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
}

class ServicesCityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
}


class ServiceListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var serviceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}




class ServiceDetailsViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var serviceList: UILabel!
    @IBOutlet weak var serviceCost: UILabel!
    
    @IBOutlet weak var cityCollectionView: UICollectionView!
    @IBOutlet weak var countryCollectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var profileImageView: SetImage!
    
    @IBOutlet weak var ProfileLogoImage: SetImage!
    
    @IBOutlet weak var subServiceTable: UITableView!
    
    @IBOutlet weak var subSerTableHeight: NSLayoutConstraint!
    
    
    //MARK:- Variables
    var headerVal = ["Countries" , "Cities"]
    var countryName = ["e" , "f"]
    var Cities = ["g" , "h"]
    var serviceNameArray: [String] = []
    var serviceIdArray: [String] = []
    var resultServiceNameArray: [String] = []
    var resultServiceIdArray: [String] = []
    
    var parentNavigationController : UINavigationController?
    var viewModel = PersonalInfoViewModel()
    var serviceModel = SignupViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "Personal Information")
        hitApiUserDetails()
        
    }
    
    func serviceListData() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        serviceModel.hitServiceList(search: "") { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess {
                self.resultServiceNameArray.removeAll()
                self.resultServiceIdArray.removeAll()
//                self.serviceNameArray = (self.serviceModel.serviceModel?.data?.first(where: {$0.id == self.viewModel.dataModel?.data?.serviceDetails?.servicesProducts})?.name)!
                
                self.serviceNameArray = (self.serviceModel.serviceModel.map({$0.name ?? "" }))
                print(self.serviceNameArray)
                self.serviceIdArray = (self.serviceModel.serviceModel.map({$0.id ?? "" }))
                print(self.serviceIdArray)
                
                
                self.resultServiceNameArray = self.viewModel.dataModel?.data?.serviceCategories.map({$0.name ?? ""}) ?? []
                
                self.resultServiceIdArray = self.viewModel.dataModel?.data?.serviceCategories.map({$0.id ?? ""}) ?? []
                
//                for i in 0..<(self.viewModel.dataModel?.data?.serviceCategories.count ?? 0) {
//                    for j in 0..<self.serviceIdArray.count {
//                        if self.viewModel.dataModel?.data?.serviceCategories[i] == self.serviceIdArray[j] {
//                            self.resultServiceNameArray.append(self.serviceNameArray[j])
//                            self.resultServiceIdArray.append(self.serviceIdArray[j])
//                        }
//                    }
//                }
                print(self.resultServiceNameArray)
                self.tableView.reloadData()
                self.updateTableHeight(tableName: self.tableView, tableHeight: self.tableHeight)
            }
        }
    }
    
    @IBAction func editBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "EditProfessionalStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "EditServiceDetailsViewController") as! EditServiceDetailsViewController
        vc.isEdit = true
        vc.viewModelP = viewModel
        vc.countryName = countryName
        vc.cityName = Cities
        vc.editServiceNameArray = resultServiceNameArray
        vc.editSubServiceNameArray = viewModel.dataModel?.data?.serviceSubcategories.map({$0.name ?? ""}) ?? []
        vc.editSubServiceIDArray = viewModel.dataModel?.data?.serviceSubcategories.map({$0.id ?? ""}) ?? []
        vc.EditServiceIdArray = resultServiceIdArray
        parentNavigationController?.pushViewController(vc, animated: true)
    }
}


//MARK:- Collection View Delegates
extension ServiceDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return headerVal.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCollectionReusableView", for: indexPath)as! headerCollectionReusableView
//        header.countryName.text = headerVal[indexPath.row]
//        return header
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cityCollectionView {
            return Cities.count
        }
        return countryName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == countryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCountryAndCityCollectionViewCell
            cell.nameLabel.text = countryName[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServicesCityCollectionViewCell
            cell.nameLabel.text = Cities[indexPath.row]
            return cell
        }
    }
}


extension ServiceDetailsViewController {
    
    func hitApiUserDetails()  {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiUserDetailsProfessional(user_id: AppUser().user_id){(isSuccess,message) in
        
            if isSuccess{
                //self.serviceList.text = self.viewModel.dataModel?.data?.serviceDetails?.servicesProducts
                let url = URLS.profileImageUrl(self.viewModel.dataModel?.data?.profileImage ?? "").getDescription()
                self.profileImageView.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                let urld = URLS.profileImageUrl(self.viewModel.dataModel?.data?.logoImage ?? "").getDescription()
                self.ProfileLogoImage.sd_setImage(with: URL(string: urld), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                self.serviceCost.text = self.viewModel.dataModel?.data?.serviceDetails?.serviceCost
                self.countryName.removeAll()
                self.Cities.removeAll()
                
                self.countryName.insert(contentsOf: (self.viewModel.dataModel?.data?.serviceDetails?.serviceCountry)!, at: 0)
                self.Cities.insert(contentsOf: (self.viewModel.dataModel?.data?.serviceDetails?.serviceCity)!, at: 0)
                self.serviceListData()
                self.cityCollectionView.reloadData()
                self.subServiceTable.reloadData()
                self.updateTableHeight(tableName: self.subServiceTable, tableHeight: self.subSerTableHeight)
                self.countryCollectionView.reloadData()
            } else {
                self.view.makeToast(message)
            }
        }
    }
}




//MARK:- Table View Delegates

extension ServiceDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == subServiceTable{
            return viewModel.dataModel?.data?.serviceSubcategories.count ?? 0
        }else{
            return resultServiceNameArray.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ServiceListTableViewCell
        if tableView == subServiceTable{
            cell.serviceLabel.text = viewModel.dataModel?.data?.serviceSubcategories[indexPath.row].name ?? ""
        }else{
            cell.serviceLabel.text = resultServiceNameArray[indexPath.row]
        }
        
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

