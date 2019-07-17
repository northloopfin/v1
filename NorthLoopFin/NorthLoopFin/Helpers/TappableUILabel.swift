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
    
    func underLineText(fullText:String, underlinedText:String){
        let attributesForUnderLine: [NSAttributedString.Key: Any] = [
            .font : AppFonts.calibri15 ,
            .foregroundColor : Colors.PurpleColor17673149,
            .underlineStyle : NSUnderlineStyle.single.rawValue]
        //let attributesForNormalText: [NSAttributedString.Key: Any] = [
           // .font : AppFonts.calibri15 ,
            //.foregroundColor : Colors.NeonCarrot25414966]
        
        let rangeOfUnderLine = (fullText as NSString).range(of: underlinedText)//(textToSet as NSString).range(of: "Edit Now")
        //let rangeOfNormalText = fullText.range(of: fullText)//(textToSet as NSString).range(of: "Want to change your preferences?")
        //let range = rangeOfNormalText-rangeOfUnderLine
        let attributedText = NSMutableAttributedString(string: fullText)
        attributedText.addAttributes(attributesForUnderLine, range: rangeOfUnderLine)
        self.attributedText = attributedText
    }
    
    func underlineMulyiplePartOfString(fullString: String, underlineString1:String, underlineString2:String){
        let attributesForUnderLine: [NSAttributedString.Key: Any] = [
            .font : AppFonts.calibri15 ,
            .foregroundColor : Colors.PurpleColor17673149,
            .underlineStyle : NSUnderlineStyle.single.rawValue]
        let rangeOfUnderLine1 = (fullString as NSString).range(of: underlineString1)
        let rangeOfUnderLine2 = (fullString as NSString).range(of: underlineString2)
        let attributedText = NSMutableAttributedString(string: fullString)
        attributedText.addAttributes(attributesForUnderLine, range: rangeOfUnderLine1)
        attributedText.addAttributes(attributesForUnderLine, range: rangeOfUnderLine2)
        self.attributedText = attributedText
    }
}
