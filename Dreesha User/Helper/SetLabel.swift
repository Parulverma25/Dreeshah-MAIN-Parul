//
//  SetLabel.swift
//  Pracup
//
//  Created by Apple on 07/01/21.
//  Copyright © 2021 promatics. All rights reserved.
//

import Foundation
import UIKit

class SetLabel: UILabel {
    
    @IBInspectable open var BorderColor:UIColor = UIColor.lightGray {
        didSet {
            self.UpdateBorder()
        }
    }
    
    @IBInspectable open var BorderWidth:CGFloat = 0 {
        didSet {
            self.UpdateBorder()
        }
    }
    
    @IBInspectable open var isCircle:Bool = false {
        didSet {
            self.UpdateCornerRadious()
        }
    }

    @IBInspectable open var CornerRadius:CGFloat = 0 {
        didSet {
            self.UpdateCornerRadious()
            
        }
    }
    
    @IBInspectable open var EnableShadow:Bool = false {
        didSet {
            self.SetShadow()
        }
    }
    
    @IBInspectable open var SetShadowColor:UIColor = UIColor.lightGray {
        didSet {
            self.SetShadow()
        }
    }
    
    @IBInspectable open var ShadowRadius:CGFloat = 0 {
        didSet {
            self.SetShadow()
        }
    }
    
    @IBInspectable open var ShadowOpacity:Float = 0 {
        didSet {
            self.SetShadow()
        }
    }

    @IBInspectable open var ShadowOffsetX:CGFloat = 0 {
        didSet {
            self.SetShadow()
        }
    }
    
    @IBInspectable open var ShadowOffsetY:CGFloat = 0 {
        didSet {
            self.SetShadow()
        }
    }
    
    @IBInspectable open var BounceButton:Bool = false
    
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
    
//    @IBInspectable open var SetGardient:Bool = false {
//        didSet {
//            self.updateGardient()
//        }
//    }
    
    func SetShadow(){
        
        if EnableShadow {
            
            self.layer.masksToBounds = false
            
            self.layer.shadowColor = SetShadowColor.cgColor
            
            self.layer.shadowOpacity = ShadowOpacity
            
            self.layer.shadowOffset = CGSize(width: ShadowOffsetX, height: ShadowOffsetY)
            
            self.layer.shadowRadius = ShadowRadius
            
        }
        
    }
    
//    private func updateGardient() {
//
//        self.setGradientColor(with: [UIColor.appLightGreen, UIColor.appLightBlue])
//
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(self.BounceButton){
            self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
                
                self.transform = CGAffineTransform.identity
                
            }, completion: nil)
        }

        super.touchesBegan(touches, with: event)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isUserInteractionEnabled = true
        super.touchesEnded(touches, with: event)
    }
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    var insets: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        }
        set {
            topInset = newValue.top
            leftInset = newValue.left
            bottomInset = newValue.bottom
            rightInset = newValue.right
        }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var adjSize = super.sizeThatFits(size)
        adjSize.width += leftInset + rightInset
        adjSize.height += topInset + bottomInset
        
        return adjSize
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += leftInset + rightInset
        contentSize.height += topInset + bottomInset
        
        return contentSize
    }
}

/*
@IBDesignable class DesignableLabel: UILabel {
    @IBInspectable var CornerRadius :CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = CornerRadius
        }
    }
    @IBInspectable var BorderWidth :CGFloat = 0.0 {
        didSet{
            self.layer.borderWidth = BorderWidth
        }
    }
    @IBInspectable var BorderColor :UIColor = .clear {
        didSet{
            self.layer.borderColor = BorderColor.cgColor
        }
    }
    @IBInspectable
    open var isRoundCorner:Bool = false {
        didSet {
            if isRoundCorner {
                self.layer.cornerRadius = self.frame.size.height/2
            }else {
                self.layer.cornerRadius = CornerRadius
            }
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    open var isCircle:Bool = false {
        didSet { setNeedsLayout() }
        /*
        didSet {
            if isCircle {
                self.layer.cornerRadius = self.frame.size.width/2
            }else {
                self.layer.cornerRadius = CornerRadius
            }
            self.layer.masksToBounds = true
        }
        */
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if isCircle {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = UIBezierPath(ovalIn:
                CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height
            )).cgPath
            layer.mask = shapeLayer
        }
        else {
            layer.mask = nil
        }

    }
}
*/
