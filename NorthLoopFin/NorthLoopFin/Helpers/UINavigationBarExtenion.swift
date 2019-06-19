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
    /// - Parameter tint: tint color (default is .white).
    func makeTransparent(withTint tint: UIColor = .white) {
        isTranslucent = true
        backgroundColor = .clear
        barTintColor = .clear
        setBackgroundImage(UIImage(), for: .default)
        tintColor = tint
        titleTextAttributes = [.foregroundColor: tint]
        shadowImage = UIImage()
    }
    func makeNormal() {
        isTranslucent = true
        shadowImage = nil
        tintColor = nil
        setBackgroundImage(nil, for: .default)
    }
//    func setupRightNavigationBar(vc:UIViewController,callBack:goback){
//        let leftBarItem = UIBarButtonItem()
//        leftBarItem.style = UIBarButtonItem.Style.plain
//        leftBarItem.target = self
//        leftBarItem.image = UIImage(named: "Back")?.withRenderingMode(.alwaysOriginal)
//        leftBarItem.action = #selector(goback.self)
//        vc.navigationItem.leftBarButtonItem = leftBarItem
//    }
}
