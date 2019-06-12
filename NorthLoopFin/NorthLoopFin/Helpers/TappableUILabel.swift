//
//  TappableUILabel.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 31/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

public typealias Closure = (() -> ())
private var tappableKey : UInt8 = 0
private var actionKey : UInt8 = 1

extension UILabel {
    
    @objc var callback: Closure {
        get {
            return objc_getAssociatedObject(self, &actionKey) as! Closure
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var gesture: UITapGestureRecognizer {
        get {
            return UITapGestureRecognizer(target: self, action: #selector(tapped))
        }
    }
    
    var tappable: Bool! {
        get {
            return objc_getAssociatedObject(self, &tappableKey) as? Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tappableKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            self.addTapGesture()
        }
    }
    
    fileprivate func addTapGesture() {
        if (self.tappable) {
            self.gesture.numberOfTapsRequired = 1
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(gesture)
        }
    }
    
    @objc private func tapped() {
        callback()
    }
}
