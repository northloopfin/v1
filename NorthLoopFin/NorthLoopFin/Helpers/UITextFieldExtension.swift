//
//  CustomTextField.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 19/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
extension UITextField {
    func applyAttributesWithValues(placeholderText:String,placeholderColor:UIColor,placeHolderFont:UIFont,textFieldBorderColor:UIColor,textFieldBorderWidth:CGFloat,textfieldCorber:CGFloat){
        self.layer.cornerRadius = textfieldCorber
        self.layer.borderColor = textFieldBorderColor.cgColor
        self.layer.borderWidth = textFieldBorderWidth
        
        var placeHolderAttributes = NSMutableAttributedString()
        placeHolderAttributes = NSMutableAttributedString(string:placeholderText, attributes: [NSAttributedString.Key.font:placeHolderFont])
        placeHolderAttributes.addAttribute(NSAttributedString.Key.foregroundColor, value: placeholderColor, range:NSRange(location:0,length:placeholderText.count))
        self.attributedPlaceholder = placeHolderAttributes
        
    }
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setLeftIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 0, y: 0, width: 60, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    func setRightIcon(_ image: UIImage) {
        let imageView = UIImageView(frame: CGRect(x: 5, y: 12.5, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(imageView)
        // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
        rightView = iconContainerView
        rightViewMode = .always
        rightView?.isUserInteractionEnabled = false
    }
}
