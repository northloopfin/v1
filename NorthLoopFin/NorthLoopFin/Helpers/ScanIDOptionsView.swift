//
//  ScanIDOptionsView.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 26/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
import UIKit

class ScanIDOptionsView: UIView {
    
    private var scrollView: UIScrollView?
    var delegate:UIViewController?
    
    @IBInspectable
    var wordsArray: [String] = [String]() {
        didSet {
            createButtons()
        }
    }
    
    private func createButtons() {
        scrollView?.removeFromSuperview()
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        self.addSubview(scrollView!)
        scrollView!.backgroundColor = UIColor.clear
        
        let padding: CGFloat = 20
        var currentWidth: CGFloat = 0
        for text in wordsArray {
            let button = UIButton(frame: CGRect(x:currentWidth, y: 0.0, width: 100, height: 34))
            button.setTitle(text, for: .normal)
            button.sizeToFit()
            let buttonWidth = button.frame.size.width
            currentWidth = currentWidth + buttonWidth + padding
            self.updateUIForUnSelectedButton(view: button)
            button.addTarget(self, action: #selector(self.handleButton(_:)), for: .touchUpInside)
            scrollView!.addSubview(button)
        }
        scrollView!.contentSize = CGSize(width:currentWidth,height:scrollView!.frame.size.height)
    }
    
    
    // Handle Action
    
    @objc func handleButton(_ sender: AnyObject) {
        
        //change background color and other UI
        let selectedButton=sender as! UIButton
        selectedButton.layer.borderWidth=0.0
        selectedButton.setTitleColor(UIColor.white, for: .normal)
        selectedButton.backgroundColor = UIColor.init(red: 213, green: 186, blue: 154)
        selectedButton.setImage(UIImage.init(named: "whiteCheck"), for: .normal)
        selectedButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        selectedButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        selectedButton.imageView?.transform = CGAffineTransform(scaleX: -5.0, y: 1.0)
        
    }
    
    private func updateUIForUnSelectedButton(view:UIButton){
        let textFont = UIFont.init(name: "Calibri", size: 16.0)
        let textColor = UIColor.init(red: 155, green: 155, blue: 155)
        let buttonBorder  = 5.0
        let buttonBorderColor = UIColor.init(red: 226, green: 226, blue: 226)
        
        view.setTitleColor(textColor, for: .normal)
        view.titleLabel?.font = textFont
        view.layer.cornerRadius = CGFloat(buttonBorder)
        view.layer.borderColor = buttonBorderColor.cgColor
        view.layer.borderWidth = 1.0
        self.addTextSpacing(0.43, button: view)
    }
    
    func addTextSpacing(_ letterSpacing: CGFloat,button:UIButton){
        let attributedString = NSMutableAttributedString(string: (button.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: (button.titleLabel?.text!.count)!))
        button.setAttributedTitle(attributedString, for: .normal)
    }
}
