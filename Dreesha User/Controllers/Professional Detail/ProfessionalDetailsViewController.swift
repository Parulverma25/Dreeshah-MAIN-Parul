//
//  ProfessionalDetailsViewController.swift
//  Dreesha User
//
//  Created by promatics on 3/25/21.
//

import UIKit
import PageMenu

class ProfessionalDetailsViewController: UIViewController {
    var pageMenu : CAPSPageMenu?
    let window = UIApplication.shared.windows.last!
   // MARK:- Outlets
    @IBOutlet var popUpViewOne: UIView!
    @IBOutlet var popViewTwo: UIView!
    @IBOutlet weak var viewToAddPageMenu: UIView!
    
    @IBOutlet weak var ProfNameLbl: UILabel!
    @IBOutlet weak var profLocation: UILabel!
    @IBOutlet weak var profImage: SetImage!
    
    //MARK:- Variables
    var imageOfProf = ""
    var name = ""
    var location = ""
    var mobileNo = ""
    var website = ""
    var professionalID = ""
    var professionalData : ProfessionalListModelElement?
    //MARK:- ViewDidiLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackWithTitle(titleVal: "Personal Information")
        pageMenuSetUp()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }
    
    //MARK:- Functions
    
    func setData(){
        ProfNameLbl.text = name
        profLocation.text = location
        let proimg = URLS.profileImageUrl(imageOfProf).getDescription()
        profImage.sd_setImage(with: URL(string: proimg), placeholderImage: #imageLiteral(resourceName: "Placed"))
    }
    
  //MARK:-Action Button
    
    @IBAction func twoPopCloseBtn(_ sender: UIButton) {
        popViewTwo.removeFromSuperview()
    }
    @IBAction func onePopUpCloseBtn(_ sender: UIButton) {
        popUpViewOne.removeFromSuperview()
    }
    @IBAction func saveBtnTwo(_ sender: Any) {
        popUpViewOne.removeFromSuperview()
    }
    @IBAction func saveBtnOne(_ sender: UIButton) {
        
        popUpViewOne.removeFromSuperview()

        popViewTwo.frame = window.frame
        window.addSubview(popViewTwo)
       // self.view.addSubview(popViewTwo)
    }
    @IBAction func sendMessageBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatwithAdminViewController") as! ChatwithAdminViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func tapCall(_ sender: Any) {
        
        guard let url = URL(string: "telprompt://\(mobileNo)"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
    @IBAction func tapWebsite(_ sender: Any) {
        
       // self.dismiss(animated: true, completion: nil)
        
        if let url = URL(string: website) , UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options:[:], completionHandler:nil)
            
        }else{
            print("Error opening website")
            self.view.makeToast("Website Url is improper")
        }
    }
    //MARK:- Function
    func pageMenuSetUp(){
        
        var controllerArray : [UIViewController] = []
     
        let vc = storyboard?.instantiateViewController(identifier: "AboutProfessionalViewController") as! AboutProfessionalViewController
        let vc1 = storyboard?.instantiateViewController(identifier: "ProjectPDViewController") as! ProjectPDViewController
        let vc2 = storyboard?.instantiateViewController(identifier: "RatingReviewViewController") as! RatingReviewViewController
        vc.title = "About me"
        vc.professionalData = self.professionalData
        controllerArray.append(vc)
        
        vc1.title = "Projects"
        vc1.profID = professionalID
        controllerArray.append(vc1)
        
        vc2.title = "Rating & Reviews"
        controllerArray.append(vc2)
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1)
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 8, y: 8, width: self.viewToAddPageMenu.frame.width - 10, height: self.viewToAddPageMenu.frame.height), pageMenuOptions: parameters)
        self.viewToAddPageMenu.addSubview((pageMenu?.view)!)
    }
}
