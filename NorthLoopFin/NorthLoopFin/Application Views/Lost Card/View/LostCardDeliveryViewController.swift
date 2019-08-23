//
//  LostCardDeliveryViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 23/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class LostCardDeliveryViewController: UIViewController {

    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var standardDeliveryView: UIView!
    @IBOutlet weak var rushDeliveryView: UIView!
    @IBOutlet weak var continueButton: RippleButton!
    @IBOutlet weak var standardImageView: UIImageView!
    @IBOutlet weak var rushImageView: UIImageView!
    @IBOutlet weak var rushLabel: LabelWithLetterSpace!
    @IBOutlet weak var standardLabel: LabelWithLetterSpace!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        // Do any additional setup after loading the view.
    }
    func prepareView(){
        let standardViewTap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnStandardView))
        standardDeliveryView.addGestureRecognizer(standardViewTap)
        
        let rushViewTap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnRushView))
        rushDeliveryView.addGestureRecognizer(rushViewTap)
        self.deliveryAddressTextView()
    }
    func deliveryAddressTextView()
    {
        let simpleString = "Your new North Loop Visa Debit Card will be sent to 134, Broadway, NY."
        let stringForLink = "Change address"
        let attributedString = NSMutableAttributedString(string: simpleString+"   "+stringForLink )
        
        attributedString.setAttributes([.link:"link"], range: NSRangeFromString(stringForLink))
        attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "Calibri", size: CGFloat(14.0))!
            , NSAttributedString.Key.foregroundColor : UIColor.darkText], range: NSRangeFromString(simpleString))
        
        attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "Calibri", size: CGFloat(14.0))!
            , NSAttributedString.Key.foregroundColor : Colors.PurpleColor17673149], range: NSRangeFromString(stringForLink))
        
        addressTextView.attributedText = attributedString
        addressTextView.isUserInteractionEnabled = true
        addressTextView.isEditable = false
        
        addressTextView.linkTextAttributes = [
            .foregroundColor: Colors.PurpleColor17673149,
            //.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
    @IBAction func continueButtonAction(_ sender: Any) {
    }
    
    @objc func handleTapOnStandardView()
    {
        standardDeliveryView.layer.borderColor = Colors.PurpleColor17673149.cgColor
        standardDeliveryView.layer.borderWidth = 2
        standardDeliveryView.layer.shadowColor = Colors.PurpleColor17673149.cgColor
        standardDeliveryView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        standardDeliveryView.layer.shadowOpacity = 0.09
        standardDeliveryView.layer.shadowRadius = 12.0
        standardLabel.textColor = Colors.PurpleColor17673149
        standardImageView.image = UIImage(named: "biggerCheckedBox")
        
        
        rushDeliveryView.layer.borderWidth = 0
        rushLabel.textColor = UIColor.darkText
        rushImageView.image = nil
        rushDeliveryView.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha: 1.0).cgColor
        rushDeliveryView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        rushDeliveryView.layer.shadowOpacity = 0.06
        rushDeliveryView.layer.shadowRadius = 10.0
    }
    
    @objc func handleTapOnRushView()
    {
        rushDeliveryView.layer.borderColor = Colors.PurpleColor17673149.cgColor
        rushDeliveryView.layer.borderWidth = 2
        rushDeliveryView.layer.shadowColor = Colors.PurpleColor17673149.cgColor
        rushDeliveryView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        rushDeliveryView.layer.shadowOpacity = 0.09
        rushDeliveryView.layer.shadowRadius = 12.0
        rushLabel.textColor = Colors.PurpleColor17673149
        rushImageView.image = UIImage(named: "biggerCheckedBox")
        
        
        standardDeliveryView.layer.borderWidth = 0
        standardLabel.textColor = UIColor.darkText
        standardImageView.image = nil
        standardDeliveryView.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha: 1.0).cgColor
        standardDeliveryView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        standardDeliveryView.layer.shadowOpacity = 0.06
        standardDeliveryView.layer.shadowRadius = 10.0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
