//
//  ParentDiscountViewController.swift
//  Dreesha User
//
//  Created by Apple on 31/03/21.
//

import UIKit
import PageMenu

class ParentDiscountViewController: UIViewController {

    @IBOutlet weak var backgroundView: SetView!
    var pageMenu : CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        pageMenuSetUp()

    }
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Discount")
    }
    
    func pageMenuSetUp() {
        var controllerArray : [UIViewController] = []
        
        let vc = storyboard?.instantiateViewController(identifier: "DiscountViewController") as! DiscountViewController
        vc.parentNavigationController = self.navigationController
        vc.title = "Discount Codes"
        controllerArray.append(vc)
        
        
        let vc3 = storyboard?.instantiateViewController(identifier: "AutomaticDiscountViewController") as! AutomaticDiscountViewController
        vc3.parentNavigationController = self.navigationController
        vc3.title = "Automatic Discounts"
        controllerArray.append(vc3)
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 8, y: 8, width: self.backgroundView.frame.width - 14, height: self.backgroundView.frame.height - 5), pageMenuOptions: parameters)
            
        self.addChild(pageMenu!)
        self.backgroundView.addSubview(pageMenu!.view)
        pageMenu!.didMove(toParent: self)
        
//        self.backgroundView.addSubview((pageMenu?.view)!)
    }


}
