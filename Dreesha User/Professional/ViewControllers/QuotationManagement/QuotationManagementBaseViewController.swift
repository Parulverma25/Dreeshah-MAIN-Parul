//
//  QuotationManagementBaseViewController.swift
//  Dreesha User
//
//  Created by Apple on 26/03/21.
//

import UIKit
import PageMenu


class QuotationManagementBaseViewController: UIViewController {

    var pageMenu : CAPSPageMenu?

    @IBOutlet weak var bgView: SetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageMenuSetUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Quotation Management")
    }
    
    
    func pageMenuSetUp() {
        var controllerArray : [UIViewController] = []

      
        let vc = storyboard?.instantiateViewController(identifier: "AllQuotationManagementViewController") as! AllQuotationManagementViewController
        let vc1 = storyboard?.instantiateViewController(identifier: "PendingQuotationManagementViewController") as! PendingQuotationManagementViewController
        let vc2 = storyboard?.instantiateViewController(identifier: "InProcessQuotationManagementViewController") as! InProcessQuotationManagementViewController
        let vc3 = storyboard?.instantiateViewController(identifier: "CancelledQuotationManagementViewController") as! CancelledQuotationManagementViewController
        
        let vc4 = storyboard?.instantiateViewController(identifier: "ApprovedQuotationManagementViewController") as! ApprovedQuotationManagementViewController
        
        let vc5 = storyboard?.instantiateViewController(identifier: "ClosedQuotationManagementViewController") as! ClosedQuotationManagementViewController

       // vc7.parentNavigationController = self.navigationController

        
        vc.title = "All Requests"
        controllerArray.append(vc)
        
        vc1.title = "Pending"
        controllerArray.append(vc1)
        
        vc2.title = "In Process"
        controllerArray.append(vc2)
        
        vc3.title = "Cancelled"
        controllerArray.append(vc3)
        
        vc4.title = "Approved"
        controllerArray.append(vc4)
        
        vc5.title = "Closed"
        controllerArray.append(vc5)
       

      
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1)
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 8, y: 15, width: self.bgView.frame.width - 10, height: self.bgView.frame.height - 30), pageMenuOptions: parameters)
        
        
        self.bgView.addSubview(pageMenu!.view)
    }
}
