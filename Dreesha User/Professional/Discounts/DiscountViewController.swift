//
//  DiscountViewController.swift
//  Dreesha User
//
//  Created by Apple on 31/03/21.
//

import UIKit
import PageMenu

class DiscountViewController: UIViewController {

    var parentNavigationController : UINavigationController?

    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var backgroundView: SetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageMenuSetUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Discount")
    }
    
    
    func pageMenuSetUp(){
        var controllerArray : [UIViewController] = []
        
        let vc = storyboard?.instantiateViewController(identifier: "DiscountsAllViewController") as! DiscountsAllViewController
        vc.childNavigationController = parentNavigationController
        vc.title = "All"
        controllerArray.append(vc)
        
        let vc1 = storyboard?.instantiateViewController(identifier: "DiscountsActiveViewController") as! DiscountsActiveViewController
        vc1.childNavigationController = parentNavigationController
        vc1.title = "Active"
        controllerArray.append(vc1)
        
        let vc2 = storyboard?.instantiateViewController(identifier: "DiscountscheduledViewController") as! DiscountscheduledViewController
        vc2.childNavigationController = parentNavigationController
        vc2.title = "Scheduled"
        controllerArray.append(vc2)
        
        let vc3 = storyboard?.instantiateViewController(identifier: "DiscountsExpiredViewController") as! DiscountsExpiredViewController
        vc3.childNavigationController = parentNavigationController
        vc3.title = "Expired"
        controllerArray.append(vc3)
        
        
        let parameters: [CAPSPageMenuOption] = [.menuItemSeparatorWidth(4.3), .useMenuLikeSegmentedControl(false), .menuItemSeparatorPercentageHeight(0.1), .bottomMenuHairlineColor(UIColor(red: 0.0/255.0, green: 00.0/255.0, blue: 0.0/255.0, alpha: 0.5)), .menuMargin(40.0), .menuHeight(40.0), .menuItemFont(UIFont(name: "Poppins-Regular", size: 14.0)!)]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 8, width: self.backgroundView.frame.width - 5, height: self.backgroundView.frame.height - 5), pageMenuOptions: parameters)
        
        self.backgroundView.addSubview((pageMenu?.view)!)
    }
}
