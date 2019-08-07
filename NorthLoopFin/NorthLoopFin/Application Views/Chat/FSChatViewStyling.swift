//
//  FSChatViewStyling.swift
//  Finserve
//
//  Created by Akhil Garg on 21/03/16.
//  Copyright © 2016 Daffodil Software Private Limited. All rights reserved.
//

import Foundation
import ZDCChat
import IQKeyboardManagerSwift

open class FSChatViewStyling: NSObject{
    //
    //    // status bar
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //
    //    // nav bar
    //    NSDictionary *navbarAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
    //    [UIColor whiteColor] ,UITextAttributeTextColor, nil];
    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //    [[UINavigationBar appearance] setTitleTextAttributes:navbarAttributes];
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor brownColor]];
    //    //        [UIColor colorWithRed:0.91f green:0.16f blue:0.16f alpha:1.0f]
    
    
    
    class func chatNavigationStyling(){
        UIApplication.shared.statusBarStyle = .lightContent
        let navbarAttributes:NSDictionary = NSDictionary(dictionary:["UITextAttributeTextColor":UIColor.red])
        UINavigationBar.appearance().tintColor = UIColor.red
        UINavigationBar.appearance().titleTextAttributes = navbarAttributes as! [NSAttributedString.Key : Any]
        UINavigationBar.appearance().barTintColor = UIColor.red
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        //        UINavigationBar.appearance().backgroundColor = UIColor.whiteColor()
        //        UINavigationBar.appearance().opaque = false
    }
    
    class func chatViewStyling(){
        //self.chatNavigationStyling()
        var insets: UIEdgeInsets
        
        //ZDCChatOverlay view
        //ZDCChatOverlay.appearance().overlayBackgroundImage = UIImage(named: "ic_chat_Minimize")
        ZDCChatOverlay.appearance().enabled = false
        
       // ZDCChatOverlay.appearance().typingIndicatorColor = UIColor.clear
       // ZDCChatOverlay.appearance().typingIndicatorHighlightColor = UIColor.darkGray
     //Z DCChatOverlay.appearance().messageCountColor = UIColor.red
        //ZDCChatOverlay.appearance().messageCountFont = UIFont.systemFont(ofSize: 18)
        
        //ZDCChat.instance().shouldResumeOnLaunch = true
        
        //Offline Message form view
        ZDCOfflineMessageView.appearance().formBackgroundColor = UIColor.clear
        
        // Customize the loader appearence
        ZDCLoadingView.appearance().loadingLabelFont = UIFont.boldSystemFont(ofSize: 16.0)
        ZDCLoadingView.appearance().loadingLabelTextColor = Colors.Amour244233239
        ZDCLoadingErrorView.appearance().messageColor = Colors.Amour244233239
        ZDCLoadingErrorView.appearance().messageFont = UIFont.boldSystemFont(ofSize: 14.0)
        ZDCLoadingErrorView.appearance().titleColor = Colors.Amour244233239
        ZDCLoadingErrorView.appearance().titleFont = UIFont.boldSystemFont(ofSize: 16.0)
        
        insets = UIEdgeInsets(top: 10.0, left: 70.0, bottom: 10.0, right: 20.0)
        ZDCJoinLeaveCell.appearance().textInsets = NSValue(uiEdgeInsets: insets)
        ZDCJoinLeaveCell.appearance().textColor = UIColor.black
        ZDCJoinLeaveCell.appearance().textFont = UIFont.boldSystemFont(ofSize: 14)
        
        // Customize the Visitor cell appearence
        insets = UIEdgeInsets(top: 8.0, left: 75.0, bottom: 7.0, right: 15.0)
        ZDCVisitorChatCell.appearance().bubbleInsets = NSValue(uiEdgeInsets: insets)
        insets = UIEdgeInsets(top: 12.0, left: 15.0, bottom: 12.0, right: 15.0)
        ZDCVisitorChatCell.appearance().textInsets = NSValue(uiEdgeInsets: insets)
        ZDCVisitorChatCell.appearance().bubbleColor = Colors.PurpleColor17673149
        ZDCVisitorChatCell.appearance().bubbleCornerRadius = 3.0
        ZDCVisitorChatCell.appearance().textAlignment = NSTextAlignment.left.rawValue as NSNumber
        ZDCVisitorChatCell.appearance().bubbleBorderColor = Colors.PurpleColor17673149
        ZDCVisitorChatCell.appearance().textColor = UIColor.white
        ZDCVisitorChatCell.appearance().textFont = UIFont.systemFont(ofSize: 14.0)
        ZDCVisitorChatCell.appearance().unsentTextColor = UIColor.white
        ZDCVisitorChatCell.appearance().unsentTextFont = UIFont.systemFont(ofSize: 14.0)
        
        // Customize the agent cell
        insets = UIEdgeInsets(top: 8.0, left: 55.0, bottom: 7.0, right: 30.0)
        ZDCAgentChatCell.appearance().bubbleInsets = NSValue(uiEdgeInsets: insets)
        
        insets = UIEdgeInsets(top: 12.0, left: 15.0, bottom: 12.0, right: 15.0)
        ZDCAgentChatCell.appearance().textInsets = NSValue(uiEdgeInsets: insets)
        ZDCAgentChatCell.appearance().bubbleColor = Colors.whiteColor
        ZDCAgentChatCell.appearance().bubbleBorderColor = Colors.Amour244233239
        ZDCAgentChatCell.appearance().bubbleCornerRadius = 3.0
        ZDCAgentChatCell.appearance().textAlignment = NSTextAlignment.left.rawValue as NSNumber
        ZDCAgentChatCell.appearance().textColor = Colors.Taupe776857
        ZDCAgentChatCell.appearance().textFont = UIFont.systemFont(ofSize: 14.0)
        ZDCAgentChatCell.appearance().avatarHeight = 30.0
        ZDCAgentChatCell.appearance().avatarLeftInset = 14.0
        
        ZDCAgentChatCell.appearance().authorColor = UIColor(white: 0.60, alpha: 1.0)
        ZDCAgentChatCell.appearance().authorFont = UIFont.systemFont(ofSize: 12)
        ZDCAgentChatCell.appearance().authorHeight = 25.0
        
        
        ZDCAgentAttachmentCell.appearance().activityIndicatorViewStyle = UIActivityIndicatorView.Style.whiteLarge.rawValue as NSNumber
        ZDCVisitorAttachmentCell.appearance().activityIndicatorViewStyle = UIActivityIndicatorView.Style.whiteLarge.rawValue as NSNumber
        
        // set all view backgrounds transparent
        //        ZDCChatUI.appearance().backgroundColor = UIColor.fs_appBackGroundColor()
        ZDCChatUI.appearance().backChatButtonImage = "Back"
        ZDCChatView.appearance().chatBackgroundColor = Colors.ivory255254247
        ZDCLoadingView.appearance().loadingBackgroundColor = UIColor.clear
        ZDCLoadingErrorView.appearance().errorBackgroundColor = UIColor.clear
        ZDCPreChatFormView.appearance().backgroundColor = UIColor.clear
        ZDCChatUI.appearance().chatBackgroundColor = Colors.ivory255254247
        ZDCTextEntryView.appearance().textEntryColor = Colors.Taupe776857
        //sendButtonImage = "ic_send_button"
    }

   
    
    class func startTheChat(_ nv: UINavigationController,vc:UIViewController) {
        ZDCChat.instance().api.endChat()
        ZDCChat.instance().overlay.hide()

        self.chatViewStyling()
        // track the event
        IQKeyboardManager.shared.enable = false
        ZDCChat.instance().api.trackEvent("Chat button pressed: (no pre-chat form)")
        // start a chat pushed on to the current navigation controller
        // with session config setting all pre-chat fields as not required
        //self.configureChatVC(nv,vc: vc)
        ZDCChat.start(in: nil, withConfig: {(config) -> Void in
            config?.preChatDataRequirements.name = ZDCPreChatDataRequirement.notRequired
            config?.preChatDataRequirements.email = ZDCPreChatDataRequirement.notRequired
            config?.preChatDataRequirements.phone = ZDCPreChatDataRequirement.notRequired
            config?.preChatDataRequirements.department = ZDCPreChatDataRequirement.notRequired
            config?.preChatDataRequirements.message = ZDCPreChatDataRequirement.notRequired
            config?.emailTranscriptAction = ZDCEmailTranscriptAction.neverSend
        })
        let currentUser = UserInformationUtility.sharedInstance.getCurrentUser()
        ZDCChat.updateVisitor { user in
            user?.name = currentUser?.name ?? ""
            user?.email = currentUser?.userEmail ?? ""
        }
        ZDCChat.instance().chatViewController.automaticallyAdjustsScrollViewInsets = false
        ZDCChat.instance().chatViewController.registerForKeyboardNotifications()
            ZDCChat.instance().chatViewController.requiresNavBar = true
        ZDCChat.instance()?.chatViewController.navigationController?.navigationBar.tintColor = Colors.Amour244233239
        ZDCChat.instance()?.chatViewController.navigationController?.navigationBar.barTintColor = Colors.ivory255254247
    }
    
    class func configureChatVC(_ nv: UINavigationController,vc:UIViewController)
    {
        let storyBoard=UIStoryboard(name: "Main", bundle: Bundle.main)
        let chatViewController = storyBoard.instantiateViewController(withIdentifier: "ChatViewController") as!  ChatViewController
        
        ZDCChat.instance().chatViewController = chatViewController
        
    }
    
//    class func showMenuOrBack(_ vc:UIViewController)->Bool{
//        if vc.isKind(of: HomeViewController.self) || vc.isKind(of: FSConnectWithUsViewController.self)
//        {
//            return false
//        }
//        else {
//            return true
//        }
//    }
    
    
    
    
}
