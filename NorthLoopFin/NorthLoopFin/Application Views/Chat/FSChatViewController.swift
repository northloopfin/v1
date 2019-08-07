//
//  FSChatViewController.swift
//  Finserve
//
//  Created by Ved Pandey on 21/01/16.
//  Copyright © 2016 Daffodil Software Private Limited. All rights reserved.
//

import UIKit
import ZDCChat
import IQKeyboardManagerSwift
class FSChatViewController: ZDCChatViewController
//    ,UITextViewDelegate
{
    var keyboard_Height:CGFloat! = 0.0
    var keyboardAlreadyOpened:Bool = false
    var boolShowMenuIcon:Bool = false
    var sourceViewController:UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        //        FSChatViewStyling.chatViewStyling()
        self.setupInitialView()
//        self.chatUI.chatView.textEntryView.textView.delegate = self
        self.registerForKeyboardNotifications()
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidShow:"), name:UIKeyboardWillShowNotification, object: nil);
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
      self.setupNavigationBar()
      ZDCChat.instance().overlay.hide()
    }
  
    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(true)
      
      //        if self.keyboardAlreadyOpened == true
//        {
//            self.chatUI.chatView.frame.origin.y -= keyboard_Height + self.chatUI.chatView.textEntryView.textViewBackground.frame.height + (keyboard_Height * 0.0385)
//            self.chatUI.chatView.table.frame.size.height -= keyboard_Height + self.chatUI.chatView.textEntryView.textViewBackground.frame.height + (keyboard_Height * 0.0385)
//        }
    }
    
    /**
     * This function setup the Navigation bar
     * @return void
     */
    
    func setupNavigationBar() -> Void {
        UIApplication.shared.isStatusBarHidden = true
        //let navbarAttributes:NSDictionary = NSDictionary(dictionary:
          //  ["UITextAttributeTextColor":UIColor.whiteColor()])
        //UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        //UINavigationBar.appearance().titleTextAttributes = navbarAttributes as! [String : AnyObject]
       // self.navigationController?.navigationBar.titleTextAttributes = navbarAttributes as? [String : AnyObject]
       // UINavigationBar.appearance().barTintColor = UIColor.fs_appBackGroundColor()
        //UINavigationBar.appearance().translucent = false
       
//        if boolShowMenuIcon{
//            self.fs_customizeLeftNavigationBarMenuItem()
//          
//        }
//        else{
//            self.fs_customizeBackButton()
//        }
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
//        let bar:UINavigationBar! =  self.navigationController?.navigationBar
//        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        bar.shadowImage = UIImage()
//        bar.backgroundColor = UIColor.fs_appBackGroundColor()
        
       // self.fs_navigationBarCustomizationWithTitle("Chat With Us")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        ZDCChat.instance().overlay.show()
        if let bar:UINavigationBar? =  self.navigationController?.navigationBar {
            bar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            bar?.backgroundColor = UIColor.clear
            bar?.shadowImage = UIImage()
            bar?.isTranslucent = true
        }
        UIApplication.shared.isStatusBarHidden = false
    }

    
    /**
     
     */
    func setChatAccountKey() {
//        ZDCChat.configure { (defaults) -> Void in
//            defaults?.accountKey = "3mQdNpcDgnVRSwWatyp0mMFZSg2hwVXt"
//            
//        }
        ZDCChat.initialize(withAccountKey: "3mQdNpcDgnVRSwWatyp0mMFZSg2hwVXt")
    }
  
    func startTheChat(){
        // track the event
        ZDCChat.instance().api.trackEvent("Chat button pressed: (no pre-chat form)")
        // start a chat pushed on to the current navigation controller
        // with session config setting all pre-chat fields as not required
        ZDCChat.start(in: self.navigationController!, withConfig: {(config) -> Void in
            config?.preChatDataRequirements.name = ZDCPreChatDataRequirement.notRequired
            config?.preChatDataRequirements.email = ZDCPreChatDataRequirement.notRequired
            config?.preChatDataRequirements.phone = ZDCPreChatDataRequirement.notRequired
            config?.preChatDataRequirements.department = ZDCPreChatDataRequirement.notRequired
            config?.preChatDataRequirements.message = ZDCPreChatDataRequirement.notRequired
            config?.emailTranscriptAction = ZDCEmailTranscriptAction.neverSend
        })
        
    }
    
    /**
     * This function setup the Background View of TableView and UIViewController.
     * @return void
     */
    
    func setupInitialView() ->Void
    {
        //        self.view.backgroundColor = UIColor.fs_appBackGroundColor()
    }
    
//    override func keyboardDidShow(aNotification: NSNotification!) {
//        if keyboardAlreadyOpened == false
//        {
//            print("keyboard_Height \(self.keyboardHeight)")
//            keyboardAlreadyOpened  = true
//            if self.keyboard_Height == 0.0
//            {
//                let userInfo:NSDictionary = aNotification.userInfo!
//                let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
//                let keyboardRectangle = keyboardFrame.CGRectValue()
//                keyboard_Height = keyboardRectangle.height
//            }
//            //        self.chatUI.chatView.textEntryView.frame.origin.y -= keyboard_Height + self.chatUI.chatView.textEntryView.textViewBackground.frame.height + 10
//            self.chatUI.chatView.frame.origin.y -= keyboard_Height + self.chatUI.chatView.textEntryView.textViewBackground.frame.height + (keyboard_Height * 0.0385)
//            self.chatUI.chatView.table.frame.size.height -= keyboard_Height + self.chatUI.chatView.textEntryView.textViewBackground.frame.height + (keyboard_Height * 0.0385)
//            print("keyboardDidShow \(self.chatUI.chatView.textEntryView.frame.origin.y)")
//            
//        }
//    }
//    
//    override func keyboardWillHide(aNotification: NSNotification!) {
//        if keyboardAlreadyOpened == true
//        {
//            keyboardAlreadyOpened = false
//            print("keyboardWillHide \(self.chatUI.chatView.textEntryView.frame.origin.y)")
//            //            self.chatUI.chatView.textEntryView.frame.origin.y += keyboard_Height  + self.chatUI.chatView.textEntryView.textViewBackground.frame.height + 10
//            self.chatUI.chatView.frame.origin.y += keyboard_Height + self.chatUI.chatView.textEntryView.textViewBackground.frame.height + (keyboard_Height * 0.0385)
//            self.chatUI.chatView.table.frame.size.height += keyboard_Height + self.chatUI.chatView.textEntryView.textViewBackground.frame.height + (keyboard_Height * 0.0385)
//            print("keyboardWillHide \(self.chatUI.chatView.textEntryView.frame.origin.y)")
//        }
//    }
//    
//    
//    
//    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
//        if text.isEmpty == false
//        {
//            self.chatUI.chatView.textEntryView.sendButton.enabled = true
//            
//        }
//        else
//        {
//            self.chatUI.chatView.textEntryView.sendButton.enabled = false
//        }
//        return true
//    }
//    
//    
//    func textViewDidEndEditing(textView: UITextView) {
//        if textView.text.isEmpty == false
//        {
//            self.chatUI.chatView.textEntryView.sendButton.enabled = true
//            
//        }
//        else
//        {
//            self.chatUI.chatView.textEntryView.sendButton.enabled = false
//        }
//    }
//    
    
    
    
//    override func fs_backButtonClicked(_ sender: Any!) {
////       if ((sourceViewController?.isKindOfClass(FSConnectWithUsViewController)) != nil)
////       {
////        var navigationArray: [AnyObject] = self.navigationController!.viewControllers
////        navigationArray.removeAtIndex(0)
////        self.navigationController!.viewControllers = navigationArray as! [UIViewController]
////        }
//        self.navigationController?.popViewController(animated: true)
//    }
  
 
}
