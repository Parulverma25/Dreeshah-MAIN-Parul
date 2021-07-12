//
//  QuotatioinsRequestBaseViewController.swift
//  Dreesha User
//
//  Created by Promatics on 18/03/21.
//

import UIKit
import PageMenu

class OrdersBaseViewContoller: UIViewController {
    
    //MARK:- Variables
    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var backGroundView: SetView!

    override func viewDidLoad() {
        super.viewDidLoad()

        pageMenuSetUp()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Order Management")
    }
    
    //MARK:- Function
    func pageMenuSetUp(){
        
        
        var controllerArray : [UIViewController] = []
        
        let vc = storyboard?.instantiateViewController(identifier: "NewOrdersViewController") as! NewOrdersViewController
        let vc1 = storyboard?.instantiateViewController(identifier: "OngoingOrdersViewController") as! OngoingOrdersViewController
        let vc2 = storyboard?.instantiateViewController(identifier: "CompletedOrdersViewController") as! CompletedOrdersViewController
        let vc3 = storyboard?.instantiateViewController(identifier: "CancelledOrdersViewController") as! CancelledOrdersViewController
       
        
        vc.title = "New Order"
        controllerArray.append(vc)
        
        vc1.title = "Ongoing Order"
        controllerArray.append(vc1)
        
        vc2.title = "Completed Order"
        controllerArray.append(vc2)
        
        vc3.title = "Cancelled Order"
        controllerArray.append(vc3)
        
        
        
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
