//
//  QuotatioinsRequestBaseViewController.swift
//  Dreesha User
//
//  Created by Promatics on 18/03/21.
//

import UIKit
import PageMenu

class QuotatioinsRequestBaseViewController: UIViewController {
    
    //MARK:- Variables
    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var backGroundView: SetView!

    override func viewDidLoad() {
        super.viewDidLoad()

        pageMenuSetUp()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Quotations Request")
    }
    
    //MARK:- Function
    func pageMenuSetUp(){
        
        
        var controllerArray : [UIViewController] = []
        
        let vc = storyboard?.instantiateViewController(identifier: "QuotationReqAllViewController") as! QuotationReqAllViewController
        let vc1 = storyboard?.instantiateViewController(identifier: "QuotationReqPendingViewController") as! QuotationReqPendingViewController
        let vc2 = storyboard?.instantiateViewController(identifier: "QuotationInProgressViewController") as! QuotationInProgressViewController
        let vc3 = storyboard?.instantiateViewController(identifier: "QuotationModifyRequestsViewController") as! QuotationModifyRequestsViewController
        let vc4 = storyboard?.instantiateViewController(identifier: "QuotationReqRejectedViewController") as! QuotationReqRejectedViewController
        let vc5 = storyboard?.instantiateViewController(identifier: "QuotationReqApprovedViewController") as! QuotationReqApprovedViewController
        let vc6 = storyboard?.instantiateViewController(identifier: "QuotationReqCompletedViewController") as! QuotationReqCompletedViewController
        let vc7 = storyboard?.instantiateViewController(identifier: "QuotationReqClosedViewController") as! QuotationReqClosedViewController
        
        vc.title = "My Request"
        controllerArray.append(vc)
        
        vc1.title = "New Requests"
        controllerArray.append(vc1)
        
        vc2.title = "In Progress"
        controllerArray.append(vc2)
        
        vc3.title = "Modify Requests"
        controllerArray.append(vc3)
        
        vc4.title = "Rejected"
        controllerArray.append(vc4)
        
        vc5.title = "Approved"
        controllerArray.append(vc5)
        
        vc6.title = "Completed"
        controllerArray.append(vc6)
        
        vc7.title = "Closed"
        controllerArray.append(vc7)
        
        
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
