//
//  HelpViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import ZDCChat
import IQKeyboardManagerSwift

class HelpViewController: BaseViewController {
    @IBOutlet weak var containerView: CommonTable!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    var twoFApresenter:TwoFAPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.twoFApresenter = TwoFAPresenter.init(delegate: self)
    }
    override func viewDidLayoutSubviews() {
        let shadowOffst = CGSize.init(width: 0, height: -55)
        let shadowOpacity = 0.1
        let shadowRadius = 49
        let shadowColor = Colors.PurpleColor17673149
        self.containerView.delegate=self
        self.containerView.containerView.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }
    
    /// Prepare View For display
    func prepareView(){
        var dataSource:[String] = []
        dataSource.append(AppConstants.HelpOptions.FAQ.rawValue)
        dataSource.append(AppConstants.HelpOptions.CHATWITHUS.rawValue)
        dataSource.append(AppConstants.HelpOptions.ATMFINDER.rawValue)
        dataSource.append(AppConstants.HelpOptions.LEGALSTUFF.rawValue)
        
        containerView.dataSource = dataSource
        containerViewHeightConstraint.constant = CGFloat(dataSource.count*70)
        self.setNavigationBarTitle(title: "Help")
        self.setupRightNavigationBar()
    }
}

extension HelpViewController:CommonTableDelegate{
    func didSelectOption(optionVal:Int) {
        switch optionVal {
        case 0:
            self.moveToFAQ()
        case 1:
            // check for biometric
            //self.openZendeskChat()
            self.initiateBiometric()
        case 2:
            self.moveToATMFinder()
        case 3:
            self.moveToLegalStuff()
        default:
            break
        }
    }
    
    func moveToFAQ(){
        let urlString:String = AppConstants.FAQURL
        let urlValue = URL.init(string: urlString)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.navTitle="FAQ"
        vc.url = urlValue
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func moveToLegalStuff(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "LegalStuffViewController") as! LegalStuffViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    func moveToATMFinder(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "ATMFinderViewController") as! ATMFinderViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    func initiateBiometric(){
        if BioMetricHelper.isDeviceSupportedforAuth(){
            //yes
            BioMetricHelper.isValidUer(reasonString: "Authenticate for Northloop") {[unowned self] (isSuccess, stringValue) in
                if isSuccess
                {
                    self.openZendeskChat()
                }
                else
                {
                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: stringValue?.description ?? "invalid")
                }
            }
        }else{
            //call 2fa and move to OTP screen
            self.twoFApresenter.sendTwoFARequest(sendToAPI: false)
            
        }
    }
    func openZendeskChat(){
        // Pushes the chat widget onto the navigation controller
        FSChatViewStyling.startTheChat(self.navigationController!, vc: self)
    }
    
    @objc func popController(){
        self.navigationController?.popViewController(animated: false)
    }
}

extension HelpViewController:TwoFADelegates{
    func didGetOTP() {
        //move to OTP screen
        self.moveToOTP()
    }
    
    func moveToOTP(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        vc.screenWhichInitiatedOTP = AppConstants.Screens.CHAT
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
