//
//  BookingsBaseViewController.swift
//  Dreesha User
//
//  Created by Promatics on 17/03/21.
//

import UIKit
import PageMenu
class BookingsBaseViewController: UIViewController {
    
    //MARK:- Variables
    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var backGroundView: SetView!

    override func viewDidLoad() {
        super.viewDidLoad()

       
        pageMenuSetUp()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Book Appointment")
    }
    
    //MARK:- Function
    func pageMenuSetUp(){
        
        
        var controllerArray : [UIViewController] = []
        
        let vc = storyboard?.instantiateViewController(identifier: "BookinginProgressViewController") as! BookinginProgressViewController
        let vc1 = storyboard?.instantiateViewController(identifier: "BookingCancelledViewController") as! BookingCancelledViewController
        let vc2 = storyboard?.instantiateViewController(identifier: "BookingsApproveViewController") as! BookingsApproveViewController
        let vc3 = storyboard?.instantiateViewController(identifier: "MyBookingDelieveredViewController") as! MyBookingDelieveredViewController
        let vc4 = storyboard?.instantiateViewController(identifier: "BookingsRejectedViewController") as! BookingsRejectedViewController
       
        vc.title = "All Appointments"
        controllerArray.append(vc)
        
        vc1.title = "Pending"
        controllerArray.append(vc1)
        
        vc2.title = "Approved"
        controllerArray.append(vc2)
        
        vc3.title = "Completed"
        controllerArray.append(vc3)
        
        vc4.title = "Rejected"
        controllerArray.append(vc4)

      
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1)
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 8, y: 8, width: self.backGroundView.frame.width - 16, height: self.backGroundView.frame.height - 5), pageMenuOptions: parameters)
        
        self.addChild(pageMenu!)
        self.backGroundView.addSubview(pageMenu!.view)
        pageMenu!.didMove(toParent: self)
        
//        self.backGroundView.addSubview((pageMenu?.view)!)
        
        
        
    }


}
