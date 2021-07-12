//
//  PersonalInformationBaseViewController.swift
//  Dreeshah
//
//  Created by promatics on 23/02/21.
//

import UIKit
import PageMenu

class PersonalInformationBaseViewController: UIViewController {
    
    //MARK:- Variables
    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var backGroundView: SetView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackWithTitle(titleVal: "Personal Information")
        pageMenuSetUp()
    }
    
    //MARK:- Function
    func pageMenuSetUp(){
        
        
        var controllerArray : [UIViewController] = []

        let vc = storyboard?.instantiateViewController(identifier: "GeneralDetailsViewController") as! GeneralDetailsViewController
        vc.parentNavigationController = self.navigationController

        let vc1 = storyboard?.instantiateViewController(identifier: "AddressDetailsProfessionalViewController") as! AddressDetailsProfessionalViewController
        vc1.parentNavigationController = self.navigationController
        
        let vc2 = storyboard?.instantiateViewController(identifier: "ContactDetailsViewController") as! ContactDetailsViewController
        vc2.parentNavigationController = self.navigationController
        
        let vc3 = storyboard?.instantiateViewController(identifier: "BuisenessDetailsViewController") as! BuisenessDetailsViewController
        vc3.parentNavigationController = self.navigationController
        
        let vc4 = storyboard?.instantiateViewController(identifier: "ServiceDetailsViewController") as! ServiceDetailsViewController
        vc4.parentNavigationController = self.navigationController
        
        let vc5 = storyboard?.instantiateViewController(identifier: "BranchDetailsViewController") as! BranchDetailsViewController
        vc5.parentNavigationController = self.navigationController
        
        vc.title = "General Details"
        controllerArray.append(vc)
        
        vc1.title = "Address Details"
        controllerArray.append(vc1)
        
        vc2.title = "Contact Details"
        controllerArray.append(vc2)
        
        vc3.title = "Business Details"
        controllerArray.append(vc3)
        
        vc4.title = "Service Details"
        controllerArray.append(vc4)
        
        vc5.title = "Branch Details"
        controllerArray.append(vc5)
       

      
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1)
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 8, y: 15, width: self.backGroundView.frame.width - 10, height: self.backGroundView.frame.height - 35), pageMenuOptions: parameters)
        
        self.backGroundView.addSubview((pageMenu?.view)!)
    }


}
