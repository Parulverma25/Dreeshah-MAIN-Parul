//
//  QuotationRequestsBaseViewController.swift
//  Dreeshah
//
//  Created by promatics on 20/02/21.
//

import UIKit
import PageMenu

class QuotationRequestsBaseViewController: UIViewController {
    
    //MARK:- Variables
    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var backGroundView: SetView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigation()
        
        var controllerArray : [UIViewController] = []

      
        let vc = storyboard?.instantiateViewController(identifier: "AllQuotationRequestsViewController") as! AllQuotationRequestsViewController
        let vc1 = storyboard?.instantiateViewController(identifier: "AllPendingRequestsViewController") as! AllPendingRequestsViewController
        let vc2 = storyboard?.instantiateViewController(identifier: "AllInProgressRequestsViewController") as! AllInProgressRequestsViewController
        let vc3 = storyboard?.instantiateViewController(identifier: "AllModifyRequestsViewController") as! AllModifyRequestsViewController
        
        let vc4 = storyboard?.instantiateViewController(identifier: "AllRejectedRequestsViewController") as! AllRejectedRequestsViewController
        
        let vc5 = storyboard?.instantiateViewController(identifier: "AllApprovedRequestsViewController") as! AllApprovedRequestsViewController
        
        let vc6 = storyboard?.instantiateViewController(identifier: "AllCompletedViewController") as! AllCompletedViewController
        
        let vc7 = storyboard?.instantiateViewController(identifier: "AllCancelRequestsViewController") as! AllCancelRequestsViewController
        vc7.parentNavigationController = self.navigationController

        
        vc.title = "All Requests"
        vc.viewController = self.navigationController
        controllerArray.append(vc)
        
        vc1.title = "New Request"//"Pending"
        vc1.viewController = self.navigationController
        controllerArray.append(vc1)
        
        vc2.title = "In Progress"
        vc2.viewController = self.navigationController
        controllerArray.append(vc2)
        
        vc3.title = "Modify Requests"
        vc3.viewController = self.navigationController
        controllerArray.append(vc3)
        
        vc4.title = "Rejected"
        vc4.viewController = self.navigationController
        controllerArray.append(vc4)
        
        vc5.title = "Approved"
        vc5.viewController = self.navigationController
        controllerArray.append(vc5)
        
        vc6.title = "Completed"
        vc6.viewController = self.navigationController
        controllerArray.append(vc6)
        
        vc7.title = "Closed"
        vc7.viewController = self.navigationController
        controllerArray.append(vc7)

      
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1)
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 8, y: 15, width: self.backGroundView.frame.width - 10, height: self.backGroundView.frame.height - 40), pageMenuOptions: parameters)
        
        
        self.backGroundView.addSubview(pageMenu!.view)
    }
    
    
    func navigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.title = "Quotation Requests"
        setBackBtn()
    }

}
