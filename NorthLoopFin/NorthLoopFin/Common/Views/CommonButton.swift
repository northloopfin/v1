//
//  CommonButton.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 11/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CommonButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
     var isBtnSelected:Bool = false
    
    override var isEnabled:Bool {
        didSet {
            if isEnabled{
                self.backgroundColor = Colors.PurpleColor17673149
            }else{
                self.backgroundColor = Colors.Alto224224224
            }
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // If button in storyboard is Custom, you'll need to set
        // title color for control states and optionally the font
        // I've set mine to System, so uncomment next three lines if Custom
        //self.setTitleColor(tintColor, for: .normal)
        //self.setTitleColor(tintColor.withAlphaComponent(0.3), for: .highlighted)
        //self.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        self.showsTouchWhenHighlighted=true
    }
    override func setTitle(_ title: String?, for state: UIControl.State)
    {
        if let title = title, spacing != 0
        {
            let color = super.titleColor(for: state) ?? UIColor.black
            let attributedTitle = NSAttributedString(
                string: title,
                attributes: [NSAttributedString.Key.kern: spacing,
                             NSAttributedString.Key.foregroundColor: color])
            super.setAttributedTitle(attributedTitle, for: state)
        }
        else
        {
            super.setTitle(title, for: state)
        }
    }
    fileprivate func updateTitleLabel_()
    {
        let states:[UIControl.State] = [.normal, .highlighted, .selected, .disabled]
        for state in states
        {
            let currentText = super.title(for: state)
            self.setTitle(currentText, for: state)
        }
    }
    
    @IBInspectable var spacing:CGFloat = 0 {
        didSet {
            updateTitleLabel_()
        }
    }
}
