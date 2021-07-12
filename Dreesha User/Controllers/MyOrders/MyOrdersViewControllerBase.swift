//
//  PersonalInformationBaseViewController.swift
//  Dreeshah
//
//  Created by promatics on 23/02/21.
//

import UIKit
import PageMenu

class MyOrdersViewControllerBase: UIViewController {
    
    //MARK:- Variables
    var pageMenu : CAPSPageMenu?
    
    //Mark Outlets
    @IBOutlet weak var backGroundView: SetView!

    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        pageMenuSetUp()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "My Orders")
    }
    
    //MARK:- Function
    func pageMenuSetUp(){
        
        
        var controllerArray : [UIViewController] = []
        
        let vc = storyboard?.instantiateViewController(identifier: "MyOrdersDelieveredViewController") as! MyOrdersDelieveredViewController
        let vc1 = storyboard?.instantiateViewController(identifier: "MyOrderinProgressViewController") as! MyOrderinProgressViewController
        let vc2 = storyboard?.instantiateViewController(identifier: "MyOrdersCancelledViewController") as! MyOrdersCancelledViewController
       
        vc.title = "Orders Delievered"
        controllerArray.append(vc)
        
        vc1.title = "Orders in Progress"
        controllerArray.append(vc1)
        
        vc2.title = "Orders Cancelled"
        controllerArray.append(vc2)

      
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(false),
            .menuItemSeparatorPercentageHeight(0.1)
        ]

        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 8, y: 8, width: self.backGroundView.frame.width - 16, height: self.backGroundView.frame.height - 5), pageMenuOptions: parameters)
        
//        self.backGroundView.addSubview((pageMenu?.view)!)
        
        self.addChild(pageMenu!)
        self.backGroundView.addSubview(pageMenu!.view)
        pageMenu!.didMove(toParent: self)
        
    }


}
