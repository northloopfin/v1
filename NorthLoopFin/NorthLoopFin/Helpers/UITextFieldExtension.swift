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
        placeHolderAttributes.addAttribute(NSAttributedString.Key.foregroundColor, value: placeholderColor, range:NSRange(location:0,length:placeholderText.utf8CString.count))
        self.attributedPlaceholder = placeHolderAttributes
        
    }
}
