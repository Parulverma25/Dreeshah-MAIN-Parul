//
//  MyProfileBaseViewController.swift
//  Dreesha User
//
//  Created by Admin on 30/03/21.
//

import UIKit
import PageMenu
class MyProfileBaseViewController: UIViewController {
    
    //MARK:- Variables
    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var backGroundView: SetView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        pageMenuSetUp()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "My Profile")
    }
    
    //MARK:- Function
    func pageMenuSetUp(){
        
        
        var controllerArray : [UIViewController] = []
        
        let vc = storyboard?.instantiateViewController(identifier: "PersonalViewViewController") as! PersonalViewViewController
        
        vc.title = "Personal Information"
        controllerArray.append(vc)
        
        if AppUser().addCount == 0 {
            let vc1 = storyboard?.instantiateViewController(identifier: "AddAdressViewController") as! AddAdressViewController
            vc1.comefrom = "new"
            vc1.title = "Address"
            controllerArray.append(vc1)
        }else{
            let vc1 = storyboard?.instantiateViewController(identifier: "AddressViewController") as! AddressViewController
            vc1.title = "Address"
            controllerArray.append(vc1)
        }
        
      
        let vc2 = storyboard?.instantiateViewController(identifier: "ChangePassViewController") as! ChangePassViewController
             
        vc2.title = "Change Password"
        controllerArray.append(vc2)

      
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
