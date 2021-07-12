//
//  QuotationBaseViewController.swift
//  Dreesha User
//
//  Created by Promatics on 18/03/21.
//

import UIKit
import PageMenu

class QuotationBaseViewController: UIViewController {
    
    //MARK:- Variables
    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var backGroundView: SetView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        pageMenuSetUp()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Quotations Management")
    }
    
    //MARK:- Function
    func pageMenuSetUp(){
        
        
        var controllerArray : [UIViewController] = []
        
        let vc = storyboard?.instantiateViewController(identifier: "QuotationAllViewController") as! QuotationAllViewController
        let vc1 = storyboard?.instantiateViewController(identifier: "QuotationPendingViewController") as! QuotationPendingViewController
        let vc2 = storyboard?.instantiateViewController(identifier: "QuotationInProcessViewController") as! QuotationInProcessViewController
    let vc3 = storyboard?.instantiateViewController(identifier: "QuotationCancelledViewController") as! QuotationCancelledViewController
        
        let vc4 = storyboard?.instantiateViewController(identifier: "QuotationApprovedViewController") as! QuotationApprovedViewController
        
        let vc5 = storyboard?.instantiateViewController(identifier: "QuotationClosedViewController") as! QuotationClosedViewController
       
        vc.title = "All Request"
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

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 8, y: 8, width: self.backGroundView.frame.width - 16, height: self.backGroundView.frame.height - 5), pageMenuOptions: parameters)
            self.backGroundView.addSubview((pageMenu?.view)!)
    }


}
