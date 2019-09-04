//
//  LostCardDeliveryViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 23/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class LostCardDeliveryViewController: BaseViewController {
    
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var standardDeliveryView: UIView!
    @IBOutlet weak var rushDeliveryView: UIView!
    @IBOutlet weak var continueButton: CommonButton!
    @IBOutlet weak var standardImageView: UIImageView!
    @IBOutlet weak var rushImageView: UIImageView!
    @IBOutlet weak var rushLabel: LabelWithLetterSpace!
    @IBOutlet weak var standardLabel: LabelWithLetterSpace!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var standardDayLabel: LabelWithLetterSpace!
    @IBOutlet weak var rushDayLabel: LabelWithLetterSpace!
    var presenter:LostCardPresenter!
    var toIssueNewCard:Bool!
    private var isRushDeliverySelected = false
    private var isStandardDeliverySelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: temp value change to actual value afterwards
        toIssueNewCard = false
        
        self.presenter = LostCardPresenter.init(delegate: self)
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Lost Card")
        self.prepareView()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 700)
    }
    
    func prepareView(){
        let standardViewTap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnStandardView))
        standardDeliveryView.addGestureRecognizer(standardViewTap)
        
        let rushViewTap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnRushView))
        rushDeliveryView.addGestureRecognizer(rushViewTap)
        continueButton.isEnabled = false
        self.deliveryAddressTextView()
    }
    func deliveryAddressTextView()
    {
        //shown link button in textview
        
        let simpleString = "Card will be shipped to your registered address"
//        let stringForLink = "Change address"
        let attributedString = NSMutableAttributedString(string: simpleString)
        
//        attributedString.setAttributes([.link:"link"], range: NSRangeFromString(stringForLink))
//        attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "Calibri", size: CGFloat(14.0))!
//            , NSAttributedString.Key.foregroundColor : UIColor.darkText], range: NSRangeFromString(simpleString))
//
//        attributedString.setAttributes([NSAttributedString.Key.font : UIFont(name: "Calibri", size: CGFloat(14.0))!
//            , NSAttributedString.Key.foregroundColor : Colors.PurpleColor17673149], range: NSRangeFromString(stringForLink))
        
        addressTextView.attributedText = attributedString
        addressTextView.isUserInteractionEnabled = true
        addressTextView.isEditable = false
        
        addressTextView.linkTextAttributes = [
            .foregroundColor: Colors.PurpleColor17673149,
            //.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
    @IBAction func continueButtonAction(_ sender: Any) {
        if isStandardDeliverySelected || isRushDeliverySelected
        {
            self.presenter.sendLostCardRequest(toExpedite:isRushDeliverySelected, toIssueNewCard:toIssueNewCard)
        }
    }
    
    @objc func handleTapOnStandardView()
    {
        //changed border color and shadow when view selected
        standardDeliveryView.layer.borderColor = Colors.PurpleColor17673149.cgColor
        standardDeliveryView.layer.borderWidth = 2
        standardDeliveryView.layer.shadowColor = Colors.PurpleColor17673149.cgColor
        standardDeliveryView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        standardDeliveryView.layer.shadowOpacity = 0.09
        standardDeliveryView.layer.shadowRadius = 12.0
        standardLabel.textColor = Colors.PurpleColor17673149
        standardDayLabel.textColor = standardLabel.textColor
        standardImageView.image = UIImage(named: "biggerCheckedBox")
        
        
        rushDeliveryView.layer.borderWidth = 0
        rushLabel.textColor = UIColor.black
        rushDayLabel.textColor = UIColor.init(red: 120, green: 120, blue: 120)

        rushImageView.image = nil
        rushDeliveryView.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha: 1.0).cgColor
        rushDeliveryView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        rushDeliveryView.layer.shadowOpacity = 0.06
        rushDeliveryView.layer.shadowRadius = 10.0
        
        continueButton.isEnabled = true
        isStandardDeliverySelected = true
        isRushDeliverySelected = false
    }
    
    @objc func handleTapOnRushView()
    {
        //changed border color and shadow when view selected
        rushDeliveryView.layer.borderColor = Colors.PurpleColor17673149.cgColor
        rushDeliveryView.layer.borderWidth = 2
        rushDeliveryView.layer.shadowColor = Colors.PurpleColor17673149.cgColor
        rushDeliveryView.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        rushDeliveryView.layer.shadowOpacity = 0.09
        rushDeliveryView.layer.shadowRadius = 12.0
        rushLabel.textColor = Colors.PurpleColor17673149
        rushDayLabel.textColor = rushLabel.textColor
        rushImageView.image = UIImage(named: "biggerCheckedBox")
        
        
        standardDeliveryView.layer.borderWidth = 0
        standardLabel.textColor = UIColor.black
        standardDayLabel.textColor = UIColor.init(red: 120, green: 120, blue: 120)
        standardImageView.image = nil
        standardDeliveryView.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha: 1.0).cgColor
        standardDeliveryView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        standardDeliveryView.layer.shadowOpacity = 0.06
        standardDeliveryView.layer.shadowRadius = 10.0
        
        continueButton.isEnabled = true
        isStandardDeliverySelected = false
        isRushDeliverySelected = true
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
extension LostCardDeliveryViewController:LostCardDelegates{
    func didSentLostCardRequest() {
        self.moveToConfrimationScreen()
    }
    
    func moveToConfrimationScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LostCardConfirmationViewController") as! LostCardConfirmationViewController
        vc.message = "Your card is on its way! We have sent an email confirming."
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
