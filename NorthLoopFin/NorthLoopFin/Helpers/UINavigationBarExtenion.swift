//
//  UINavigationBarExtenion.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 18/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        //let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        let gradientLayer = CAGradientLayer.init(frame: updatedFrame, colors: colors)
        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
    }
    func setTitleFont(_ font: UIFont, color: UIColor = .black) {
        var attrs = [NSAttributedString.Key: Any]()
        attrs[.font] = font
        attrs[.foregroundColor] = color
        titleTextAttributes = attrs
    }
}
