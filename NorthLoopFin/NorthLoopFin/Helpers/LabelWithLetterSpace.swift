//
//  UILableExtension.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 17/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
import UIKit

open class LabelWithLetterSpace : UILabel {
    
    @IBInspectable open var characterSpacing:CGFloat = 1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }        
    }
}

