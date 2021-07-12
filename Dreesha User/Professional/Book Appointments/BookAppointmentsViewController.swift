//
//  BookAppointmentsViewController.swift
//  Dreesha User
//
//  Created by Apple on 30/03/21.
//

import UIKit
import PageMenu

class BookAppointmentsViewController: UIViewController {

    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var backgroundView: SetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackWithTitle(titleVal: "Book Appointment")
        pageMenuSetUp()

    }

    
    func pageMenuSetUp(){
        
        
        var controllerArray : [UIViewController] = []

        let vc = storyboard?.instantiateViewController(identifier: "BookAppointmentsAllViewController") as! BookAppointmentsAllViewController
        vc.parentNavigationController = self.navigationController

        let vc1 = storyboard?.instantiateViewController(identifier: "BookPendingViewController") as! BookPendingViewController
        
        
        let vc2 = storyboard?.instantiateViewController(identifier: "BookApprovedViewController") as! BookApprovedViewController
        
        let vc3 = storyboard?.instantiateViewController(identifier: "BookCmpletedViewController") as! BookCmpletedViewController
        vc3.parentNavigationController = self.navigationController
        let vc4 = storyboard?.instantiateViewController(identifier: "BookRejectedProfViewController") as! BookRejectedProfViewController
        vc4.parentNavigationController = self.navigationController

       
        
        vc.title = "All Appointments"
        vc.viewController = self.navigationController
        controllerArray.append(vc)
        
        vc1.title = "Pending"
        vc1.viewController = self.navigationController
        controllerArray.append(vc1)
        
        vc2.title = "Approved"
        vc2.viewController = self.navigationController
        controllerArray.append(vc2)
        
        vc3.title = "Completed"
        vc3.viewController = self.navigationController
        controllerArray.append(vc3)
        
        vc4.title = "Rejected"
        vc4.viewController = self.navigationController
        controllerArray.append(vc4)
       

      
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1)
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 8, y: 8, width: self.backgroundView.frame.width - 16, height: self.backgroundView.frame.height - 5), pageMenuOptions: parameters)
        
        self.backgroundView.addSubview((pageMenu?.view)!)
    }
    
    
}
