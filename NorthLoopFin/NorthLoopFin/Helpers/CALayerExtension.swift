//
//  ViewUtility.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 17/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

extension CALayer {
    func addShadow() {
        self.shadowOffset = .zero
        self.shadowOpacity = 0.2
        self.shadowRadius = 10
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }
    func addShadowAndRoundedCorners(roundedCorner:CGFloat,shadowOffset:CGSize,shadowOpacity:Float,shadowRadius:CGFloat,shadowColor:CGColor){
        self.shadowOffset = shadowOffset
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
        self.shadowColor = shadowColor
        self.masksToBounds = false
        if roundedCorner != 0{
            addShadowWithRoundedCorners()
        }
    }
    private func addShadowWithRoundedCorners() {
        if let contents = self.contents {
            masksToBounds = false
            sublayers?.filter{ $0.frame.equalTo(self.bounds) }
                .forEach{ $0.roundCorners(radius: self.cornerRadius) }
            self.contents = nil
            if let sublayer = sublayers?.first,
                sublayer.name == AppConstants.contentLayerName {
                
                sublayer.removeFromSuperlayer()
            }
            let contentLayer = CALayer()
            contentLayer.name = AppConstants.contentLayerName
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
        }
    }
}
