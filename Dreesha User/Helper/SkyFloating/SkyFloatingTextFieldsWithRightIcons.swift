//
//  SkyFloatingTextFieldsWithRightIcons.swift
//  LoanDirect
//
//  Created by promatics on 13/12/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import Foundation
import UIKit

/**
 A beautiful and flexible textfield implementation with support for icon, title label, error message and placeholder.
 */
public enum iconType: Int {
    
    case font
    case image
    
}
open class SkyFloatingLabelTextFieldWithRightIcon: SkyFloatingLabelTextField {
    
    /// A UILabel value that identifies the label used to display the icon
    open var iconLabel:UILabel!
    open var iconImageView: UIImageView!
    /// A UIFont value that determines the font that the icon is using
    @IBInspectable
    open var iconFont:UIFont? {
        didSet {
            self.iconLabel?.font = iconFont
        }
    }
    
    @IBInspectable
    var iconTypeAdapter:Int {
        
        get {
            
            return self.iconType.rawValue
            
        }
        
        set(iconIndex) {
            
            self.iconType = IconType(rawValue: iconIndex) ?? .font
            
        }
    }
    
    open var iconType: IconType = .font {
        
        didSet {
            
            switch self.iconType {
            case .font:
                self.iconLabel.isHidden = false
                self.iconImageView.isHidden = true
                
            case .image:
                self.iconLabel.isHidden = true
                self.iconImageView.isHidden = false
                
            }
        }
    }
    
    @IBInspectable
    dynamic open var iconImage: UIImage? {
        didSet {
            
            iconImageView?.image = iconImage?.withRenderingMode(.alwaysTemplate)
        }
    }
    /// A String value that determines the text used when displaying the icon
    @IBInspectable
    open var iconText:String? {
        didSet {
            self.iconLabel?.text = iconText
        }
    }
    
    /// A UIColor value that determines the color of the icon in the normal state
    @IBInspectable
    open var iconColor:UIColor = UIColor.gray {
        didSet {
            self.updateIconLabelColor()
        }
    }
    
    /// A UIColor value that determines the color of the icon when the control is selected
    @IBInspectable
    open var selectedIconColor:UIColor = UIColor.gray {
        didSet {
            
            self.updateIconLabelColor()
        }
    }
    
    /// A float value that determines the width of the icon
    @IBInspectable open var iconWidth:CGFloat = 20 {
        didSet {
            self.updateFrame()
        }
    }
    
    /// A float value that determines the Right margin of the icon. Use this value to position the icon more precisely horizontally.
    @IBInspectable open var iconMarginRight:CGFloat = 4 {
        didSet {
            self.updateFrame()
        }
    }
    
    /// A float value that determines the bottom margin of the icon. Use this value to position the icon more precisely vertically.
    @IBInspectable
    open var iconMarginBottom:CGFloat = 4 {
        didSet {
            self.updateFrame()
        }
    }
    
    /// A float value that determines the rotation in degrees of the icon. Use this value to rotate the icon in either direction.
    @IBInspectable
    open var iconRotationDegrees:Double = 0 {
        didSet {
            self.iconLabel.transform = CGAffineTransform(rotationAngle: CGFloat(iconRotationDegrees * .pi / 180.0))
            self.iconImageView.transform = CGAffineTransform(rotationAngle: CGFloat(iconRotationDegrees * .pi / 180.0))
        }
    }
    
    // MARK: Initializers
    
    
    convenience public init(frame: CGRect, iconType: IconType) {
        
        self.init(frame: frame)
        
        self.iconType = iconType
        
    }
    
    /**
     Initializes the control
     - parameter frame the frame of the control
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.createIconLabel()
        createIconImageView()
    }
    
    /**
     Intialzies the control by deserializing it
     - parameter coder the object to deserialize the control from
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createIconLabel()
        createIconImageView()
        switch self.iconType {
            
        case .font:
            self.iconLabel.isHidden = false
            self.iconImageView.isHidden = true
            
        case .image:
            self.iconLabel.isHidden = true
            self.iconImageView.isHidden = false
            
        }
    }
    
    // MARK: Creating the icon label
    
    /// Creates the icon label
    fileprivate func createIconLabel() {
        let iconLabel = UILabel()
        iconLabel.backgroundColor = UIColor.clear
        iconLabel.textAlignment = .center
        iconLabel.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        self.iconLabel = iconLabel
        self.addSubview(iconLabel)
        
        self.updateIconLabelColor()
    }
    
    
    // MARK: Creating the icon image view
    
    /// Creates the icon label
    fileprivate func createIconImageView() {
        let iconImageView = UIImageView()
        iconImageView.backgroundColor = .clear
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        self.iconImageView = iconImageView
        addSubview(iconImageView)
        
    }
    
    // MARK: Handling the icon color
    
    /// Update the colors for the control. Override to customize colors.
    override open func updateColors() {
        super.updateColors()
        self.updateIconLabelColor()
    }
    
    fileprivate func updateIconLabelColor() {
        
        if self.hasErrorMessage {
            // self.iconLabel?.textColor = self.errorColor
        } else {
            //            self.iconLabel?.textColor = self.editingOrSelected ? self.selectedIconColor : self.iconColor
            //            self.iconImageView?.tintColor = self.editingOrSelected ? self.selectedIconColor : self.iconColor
            
            if self.text != "" || self.editingOrSelected{
                self.iconLabel?.textColor = self.selectedIconColor
                self.iconImageView?.tintColor = self.selectedIconColor
            }else {
                self.iconLabel?.textColor = self.iconColor
                self.iconImageView?.tintColor = self.iconColor
            }
        }
    }
    
    // MARK: Custom layout overrides
    
    /**
     Calculate the bounds for the textfield component of the control. Override to create a custom size textbox in the control.
     - parameter bounds: The current bounds of the textfield component
     - returns: The rectangle that the textfield component should render in
     */
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        if isLTRLanguage {
            //rect.origin.x += CGFloat(iconWidth + iconMarginLeft)
        } else {
            rect.origin.x -= CGFloat(iconWidth + iconMarginRight)
        }
        rect.size.width -= CGFloat(iconWidth + iconMarginRight)
        return rect
    }
    
    /**
     Calculate the rectangle for the textfield when it is being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        if isLTRLanguage {
            //rect.origin.x += CGFloat(iconWidth + iconMarginLeft)
            
        } else {
            // don't change the editing field X position for RTL languages
        }
        rect.size.width -= CGFloat(iconWidth + iconMarginRight)
        return rect
    }
    
    /**
     Calculates the bounds for the placeholder component of the control. Override to create a custom size textbox in the control.
     - parameter bounds: The current bounds of the placeholder component
     - returns: The rectangle that the placeholder component should render in
     */
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.placeholderRect(forBounds: bounds)
        if isLTRLanguage {
            //rect.origin.x += CGFloat(iconWidth + iconMarginLeft)
            
            
        } else {
            // don't change the editing field X position for RTL languages
        }
        rect.size.width -= CGFloat(iconWidth + iconMarginRight)
        return rect
    }
    
    /// Invoked by layoutIfNeeded automatically
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrame()
    }
    
    fileprivate func updateFrame() {
        let textHeight = self.textHeight()
        let textWidth:CGFloat = self.bounds.size.width
        
        if isLTRLanguage{
            
            switch self.iconType {
            case .font:
                iconLabel.frame = CGRect(
                    x: textWidth - iconWidth,
                    y: bounds.size.height - textHeight - iconMarginBottom,
                    width: iconWidth,
                    height: textHeight
                    
                )
                
            case .image:
                iconImageView.frame = CGRect(
                    x: textWidth - iconWidth,
                    y: bounds.size.height - textHeight - iconMarginBottom,
                    width: iconWidth,
                    height: textHeight
                )
                
            }
            
        }else{
            switch self.iconType {
            case .font:
                iconLabel.frame = CGRect(
                    x: 0,
                    y: bounds.size.height - textHeight - iconMarginBottom,
                    width: iconWidth,
                    height: textHeight
                )
                
            case .image:
                iconImageView.frame = CGRect(
                    x: 0,
                    y: bounds.size.height - textHeight - iconMarginBottom,
                    width: iconWidth,
                    height: textHeight
                )
                
            }
        }
    }
}
