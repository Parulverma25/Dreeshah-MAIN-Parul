//
//  setButton.swift
//  Dreesha User
//
//  Created by Promatics on 10/03/21.
//

import Foundation

import UIKit

@IBDesignable class SetButton: UIButton {



    @IBInspectable

    open var BorderColor:UIColor = UIColor.lightGray {

        didSet {

            self.UpdateBorder()

        }

    }

    

    @IBInspectable

    open var BorderWidth:CGFloat = 0 {

        didSet {

            self.UpdateBorder()

        }

    }

    

    @IBInspectable

    open var isCircle:Bool = false {

        didSet {

            self.UpdateCornerRadious()

        }

    }

    

    @IBInspectable

    open var CornerRadius:CGFloat = 0 {

        didSet {

            self.UpdateCornerRadious()

        }

    }

    

    @IBInspectable

    open var EnableShadow:Bool = false {

        didSet {

            self.SetShadow()

        }

    }

    

    @IBInspectable

    open var ShadowColor:UIColor = UIColor.lightGray {

        didSet {

            self.SetShadow()

        }

    }

    

    @IBInspectable

    open var ShadowRadius:CGFloat = 0 {

        didSet {

            self.SetShadow()

        }

    }

    

    @IBInspectable

    open var ShadowOpacity:Float = 0 {

        didSet {

            self.SetShadow()

        }

    }

    

    @IBInspectable

    open var ShadowOffsetX:CGFloat = 0 {

        didSet {

            self.SetShadow()

        }

    }

    

    @IBInspectable

    open var ShadowOffsetY:CGFloat = 0 {

        didSet {

            self.SetShadow()

        }

    }

    

    @IBInspectable

    open var SoundOnTap:Bool = false{

        didSet {

            

        }

    }

    

    @IBInspectable

    open var BounceButton:Bool = false{

        didSet {

            

        }

    }

    

    @IBInspectable

    open var LeftPaddingSize:CGFloat = 0 {

        didSet {

            self.SetPadding()

        }

    }

    

    @IBInspectable

    open var RightPaddingSize:CGFloat = 0 {

        didSet {

            self.SetPadding()

        }

    }

    

    @IBInspectable

    open var TopPaddingSize:CGFloat = 0 {

        didSet {

            self.SetPadding()

        }

    }

    

    @IBInspectable

    open var BottomPaddingSize:CGFloat = 0 {

        didSet {

            self.SetPadding()

        }

    }

    

    func SetPadding(){

        

        self.titleEdgeInsets = UIEdgeInsets(top: TopPaddingSize, left: LeftPaddingSize, bottom: BottomPaddingSize, right: RightPaddingSize)

    }

    

    func UpdateBorder(){

        

        self.layer.borderWidth = BorderWidth

        self.layer.borderColor = BorderColor.cgColor

        self.layer.masksToBounds = true

        

    }

    

    func UpdateCornerRadious(){

        if isCircle {

            self.layer.cornerRadius = self.frame.size.height/2

        }else {

            self.layer.cornerRadius = CornerRadius

        }

    }

    

    func SetShadow(){

        

        if EnableShadow {

            self.layer.masksToBounds = false

            self.layer.shadowColor = ShadowColor.cgColor

            self.layer.shadowOpacity = ShadowOpacity

            self.layer.shadowOffset = CGSize(width: ShadowOffsetX, height: ShadowOffsetY)

            self.layer.shadowRadius = ShadowRadius

        }

        

    }

    

}



extension UIButton {

    func setTitleWithOutAnimation(_ title: String?) {

        UIView.setAnimationsEnabled(false)

        

        setTitle(title, for: .normal)

        

        layoutIfNeeded()

        UIView.setAnimationsEnabled(true)

    }

}

