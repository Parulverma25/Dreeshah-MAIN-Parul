//
//  PersonalViewViewController.swift
//  Dreesha User
//
//  Created by Promatics on 10/03/21.
//

import UIKit

class PersonalViewViewController: UIViewController {
    //Mark Outlets
    @IBOutlet weak var PImgview: UIImageView!
    @IBOutlet weak var aboutview: UIView!
    @IBOutlet weak var nameview: UIView!
    @IBOutlet weak var Needhlpview: UILabel!
    @IBOutlet weak var Chatwithadmin: UIButton!
    @IBOutlet weak var FirstNameLabel: UILabel!
    @IBOutlet weak var LastNameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PhoneNoLabel: UILabel!
    
    //MARK: Variables
    var viewModel = PersonalInfoViewModel()
    var imageData = Data()
    
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        Stylize()
        self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "My Profile")
        hitApiUserDetails()
    }
    
    //Mark Actions
    @IBAction func EditBtn1(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.Verifycount = ((viewModel.getUserDetails()?.emailVerified) != nil)
    }
    
    @IBAction func chatAdminBtn1(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatwithAdminViewController") as! ChatwithAdminViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func Stylize(){
        //IMG Style
        PImgview.layer.cornerRadius = PImgview.frame.height / 2
        PImgview.clipsToBounds = true
        PImgview.clipsToBounds = true
        Chatwithadmin.layer.cornerRadius = 17
        Chatwithadmin.layer.masksToBounds=true
    }
}

extension PersonalViewViewController{
    
    func hitApiUserDetails()  {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiUserDetails(user_id: AppUser().user_id){(isSuccess,message) in
        
            if isSuccess{
                self.FirstNameLabel.text =  self.viewModel.getUserDetails()?.firstName
                self.LastNameLabel.text = self.viewModel.getUserDetails()?.lastName
                self.EmailLabel.text=self.viewModel.getUserDetails()?.email
                self.PhoneNoLabel.text=self.viewModel.getUserDetails()?.phoneNumber
                let url =   URLS.profileImageUrl(self.viewModel.getUserDetails()?.profileImage  ?? "" ).getDescription()
                self.PImgview.sd_setImage(with: URL(string: url),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
                
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    
}
