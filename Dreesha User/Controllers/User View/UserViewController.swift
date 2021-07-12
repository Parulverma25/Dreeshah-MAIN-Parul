//
//  UserViewController.swift
//  Dreesha User
//
//  Created by Promatics on 09/03/21.
//

import UIKit

class UserViewController: UIViewController {
    
    //Mark Outlets
    @IBOutlet weak var IMGCorn: UIView!
    @IBOutlet weak var ImgViewUpper: UIImageView!
    @IBOutlet weak var UsertableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //Mark Variables
    var ArrayofLabels: [String]! = []
    var ArrayofImages: [UIImage]! = []
    var viewModel = PersonalInfoViewModel()
    var imageData = Data()
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        UsertableView.delegate=self
        UsertableView.dataSource=self
        UsertableView.reloadData()
        SetSize()
        makeRounded()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if AppUser().user_type ?? "" == "customer" {
            
            hitApiUserDetails()
            navigationItem.title = "User Detail"
            nameLabel.text = "John Doe"
            ImgViewUpper.image = UIImage(named: "testimonial-circle-face04 2")
            ArrayofLabels = ["Dashboard","My Profile" , "My Wishlist" ,"My Albums", "My Bookings" ,"My Orders", "My Quotation" ,"My Quotation Management", "My Payments" ,"Account Settings", "Logout"]
            ArrayofImages = [#imageLiteral(resourceName: "House Main View"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "3"),#imageLiteral(resourceName: "4"),#imageLiteral(resourceName: "5"),#imageLiteral(resourceName: "6"),#imageLiteral(resourceName: "7"),#imageLiteral(resourceName: "8"),#imageLiteral(resourceName: "9"),#imageLiteral(resourceName: "10"),#imageLiteral(resourceName: "11")]
        } else {
            hitApiProffUserDetails()
            navigationItem.title = "Professional"
            nameLabel.text = "Grace Lawerence"
            ImgViewUpper.image = UIImage(named: "proImage")
            ArrayofLabels = ["Dashboard","My Profile" , "Branches" ,"Projects", "My Memberships" ,"My Payment Methods", "Quotation Requests" ,"Quotation Management", "Service Management" ,"Product Management","My Collection" , "Order Management", "Refund Management", "Book Appointment", "Staff & Staff Privileges", "Discount", "Gift Card", "Logout"]
            ArrayofImages = [#imageLiteral(resourceName: "house 1"),#imageLiteral(resourceName: "my-profile"),#imageLiteral(resourceName: "office 2"),#imageLiteral(resourceName: "briefing 2"),#imageLiteral(resourceName: "membership 1"),#imageLiteral(resourceName: "my-payments"),#imageLiteral(resourceName: "my quotation"),#imageLiteral(resourceName: "my-quotation-mgmt"),#imageLiteral(resourceName: "cogwheel 1"),#imageLiteral(resourceName: "icon"),#imageLiteral(resourceName: "Windows") ,#imageLiteral(resourceName: "my-orders"),#imageLiteral(resourceName: "refund 1"),#imageLiteral(resourceName: "my-quotation-mgmt"),#imageLiteral(resourceName: "diamond 3"),#imageLiteral(resourceName: "price-tag 1"),#imageLiteral(resourceName: "gift-card 1"),#imageLiteral(resourceName: "logout 1")]
        }
       
        
        
        
        setBackWithTitle(titleVal : "User Detail")
    }
}

//Mark TableView Delegates
extension UserViewController : UITableViewDelegate, UITableViewDataSource {
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
        var vc = UIViewController()
        
        if AppUser().user_type ?? "" == "customer" {
            switch (indexPath.row) {
            case 0:
                vc = storyboard?.instantiateViewController(withIdentifier: "UserDashboardViewController") as! UserDashboardViewController
                vc.hidesBottomBarWhenPushed = true
            case 1:
                vc = storyboard?.instantiateViewController(withIdentifier: "MyProfileBaseViewController") as! MyProfileBaseViewController
                vc.hidesBottomBarWhenPushed = true
            case 2:
                vc = storyboard?.instantiateViewController(withIdentifier: "MyWishlistViewController") as! MyWishlistViewController
                vc.hidesBottomBarWhenPushed = true
            case 3:
                vc = storyboard?.instantiateViewController(withIdentifier: "MyAlbumsViewController") as! MyAlbumsViewController
                vc.hidesBottomBarWhenPushed = true
            case 4:
                vc = storyboard?.instantiateViewController(withIdentifier: "BookingsBaseViewController") as! BookingsBaseViewController
                vc.hidesBottomBarWhenPushed = true
            case 5:
                vc = storyboard?.instantiateViewController(withIdentifier: "MyOrdersViewControllerBase") as! MyOrdersViewControllerBase
                vc.hidesBottomBarWhenPushed = true
            case 6:
                vc = storyboard?.instantiateViewController(withIdentifier: "QuotatioinsRequestBaseViewController") as! QuotatioinsRequestBaseViewController
                vc.hidesBottomBarWhenPushed = true
            case 7:
                vc = storyboard?.instantiateViewController(withIdentifier: "QuotationBaseViewController")  as! QuotationBaseViewController
                vc.hidesBottomBarWhenPushed = true
            case 8:
                vc = storyboard?.instantiateViewController(withIdentifier: "AddCardViewController") as! AddCardViewController
                vc.hidesBottomBarWhenPushed = true
            case 9:
                print("")
            case 10:
                vc = storyboard?.instantiateViewController(withIdentifier: "SelectUserTypeViewController") as! SelectUserTypeViewController
                vc.hidesBottomBarWhenPushed = true
            default:
                vc.hidesBottomBarWhenPushed = true
            }
        }
        else {
            switch (indexPath.row) {
            case 0:
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "DashboardViewController")
            
            case 1:
                vc = storyboard?.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
                vc.hidesBottomBarWhenPushed = true
                
            case 2:
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "AddedBranchesViewController")
                
            case 3:
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "ProjectListingViewController")
            
            case 4:
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "MembershipPlanViewController")
                
            case 5:
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "AddPaymentMethodViewController")
                
            case 6:
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "QuotationRequestsBaseViewController")
                
            case 7:
                vc = storyboard?.instantiateViewController(withIdentifier: "QuotationBaseViewController")  as! QuotationBaseViewController
                
            
            case 8:
                CurrentSession.shared.isServiceListProfesstional = true
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController")
                vc.hidesBottomBarWhenPushed = true
            case 9:
                CurrentSession.shared.isServiceListProfesstional = false
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController")
                vc.hidesBottomBarWhenPushed = true
                
            case 10:
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "MyCollectionViewController")
            case 11:
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "OrdersBaseViewContoller")
            
            case 12:
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "RefundManagementViewController")
            
            case 13:
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "BookAppointmentsViewController")
                
            case 14:
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "StaffListViewController")
                
            
            case 15:
                vc =  UIStoryboard(name:"Professional", bundle: nil).instantiateViewController(withIdentifier: "ParentDiscountViewController")
                
            case 16: break
                
            case 17:
                vc = storyboard?.instantiateViewController(withIdentifier: "SelectUserTypeViewController") as! SelectUserTypeViewController
                vc.hidesBottomBarWhenPushed = true
                
                
            default:
                vc.hidesBottomBarWhenPushed = true
//                navigationController?.popToRootViewController(animated: true)
            
            }
        }
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
    }
}
    

extension UserViewController{

    func makeRounded() {
        ImgViewUpper.layer.masksToBounds = false
        ImgViewUpper.layer.cornerRadius = ImgViewUpper.frame.height / 2
        ImgViewUpper.clipsToBounds = true
        SetSize()
    }

    func SetSize(){
        IMGCorn.layer.cornerRadius = 30;
        IMGCorn.layer.masksToBounds = true;
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



extension UserViewController{
    
    func hitApiUserDetails()  {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiUserDetails(user_id: AppUser().user_id){(isSuccess,message) in
        
            if isSuccess{
                let url =   URLS.profileImageUrl(self.viewModel.getUserDetails()?.profileImage  ?? "" ).getDescription()
                self.ImgViewUpper.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                self.nameLabel.text = (self.viewModel.model?.firstName ?? "") + " \(self.viewModel.model?.lastName ?? "")"
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func hitApiProffUserDetails()  {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiUserDetailsProfessional(user_id: AppUser().user_id){(isSuccess,message) in
        
            if isSuccess{
                let url = URLS.profileImageUrl(self.viewModel.dataModel?.data?.profileImage ?? "").getDescription()
                self.ImgViewUpper.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "profilePlaceHolder"))
                self.nameLabel.text = "\(self.viewModel.dataModel?.data?.firstName ?? "")  \(self.viewModel.dataModel?.data?.lastName ?? "")"
               
                }else {
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    
    
}
