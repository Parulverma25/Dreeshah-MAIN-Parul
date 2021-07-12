//
//  CAPSPageMenuConfiguration.swift
//  PageMenuConfigurationDemo
//
//  Created by Matthew York on 3/5/17.
//  Copyright © 2017 Aeron. All rights reserved.
//

import UIKit

public class CAPSPageMenuConfiguration {
    open var menuHeight : CGFloat = 34.0
    open var menuMargin : CGFloat = 15.0
    open var menuItemWidth : CGFloat = 80
    open var selectionIndicatorHeight : CGFloat = 3.0
    open var scrollAnimationDurationOnMenuItemTap : Int = 500 // Millisecons
    open var selectionIndicatorColor : UIColor = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
    open var selectedMenuItemLabelColor : UIColor = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
    open var unselectedMenuItemLabelColor : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    open var scrollMenuBackgroundColor : UIColor = UIColor.white
    open var viewBackgroundColor : UIColor = UIColor.white
    open var bottomMenuHairlineColor : UIColor = UIColor.white
    open var menuItemSeparatorColor : UIColor = UIColor.white
    
    open var menuItemFont : UIFont = UIFont.systemFont(ofSize: 16)
    open var menuItemSeparatorPercentageHeight : CGFloat = 0
    open var menuItemSeparatorWidth : CGFloat = 0
    open var menuItemSeparatorRoundEdges : Bool = false
    
    open var addBottomMenuHairline : Bool = true
    open var menuItemWidthBasedOnTitleTextWidth : Bool = true
    open var titleTextSizeBasedOnMenuItemWidth : Bool = true
    open var useMenuLikeSegmentedControl : Bool = false
    open var centerMenuItems : Bool = true
    open var enableHorizontalBounce : Bool = true
    open var hideTopMenuBar : Bool = false
    
    public init() {
        
    }
}
