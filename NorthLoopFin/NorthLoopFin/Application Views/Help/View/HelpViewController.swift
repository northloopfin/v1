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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
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
            self.openZendeskChat()
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
//            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                } else {
//                    UIApplication.shared.openURL(url)
//                }
//            }
        let urlValue = URL.init(string: urlString)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.navTitle="FAQ"
        vc.url = urlValue
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func moveToLegalStuff(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "LegalStuffViewController") as! LegalStuffViewController
//        self.navigationController?.pushViewController(transactionDetailController, animated: false)
        self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.COMING_SOON.rawValue)
    }
    
    func moveToATMFinder(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "ATMFinderViewController") as! ATMFinderViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    func openZendeskChat(){
        // Pushes the chat widget onto the navigation controller
        
        //FSChatViewStyling.chatViewStyling()
        FSChatViewStyling.startTheChat(self.navigationController!, vc: self)
        
    }

//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
//        self.navigationController?.pushViewController(transactionDetailController, animated: false)
        //IQKeyboardManager.shar
//        ZDCChat.start(in: self.navigationController) { (config) in
//            config?.preChatDataRequirements.name = ZDCPreChatDataRequirement.notRequired
//            config!.preChatDataRequirements.email = ZDCPreChatDataRequirement.notRequired
//            config?.preChatDataRequirements.phone = ZDCPreChatDataRequirement.notRequired
//            config?.preChatDataRequirements.department = ZDCPreChatDataRequirement.notRequired
//            config?.preChatDataRequirements.message = ZDCPreChatDataRequirement.notRequired
//            config?.emailTranscriptAction = ZDCEmailTranscriptAction.neverSend
//        }
//
//        ZDCChatUI.appearance().backChatButtonImage = "Back"
//        ZDCChatUI.appearance().chatBackgroundAnchor = ZDCChatBackgroundAnchor.top.rawValue as NSNumber
//        ZDCChatUI.appearance().chatBackgroundImage="oval"
//
 
    
    @objc func popController(){
       // self.navigationController?.popViewController(animated: false)
    }
}
