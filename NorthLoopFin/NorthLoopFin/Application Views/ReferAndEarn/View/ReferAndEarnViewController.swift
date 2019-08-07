//
//  ReferAndEarnViewController.swift
//  NorthLoopFin
//
//  Created by Admin on 7/28/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import FirebaseDynamicLinks
import FirebaseAuth


class ReferAndEarnViewController: BaseViewController {
    typealias CreateLinkHandler = (_ url:URL?) -> Void

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func shareClicked(_ sender: Any) {
//        let myWebsite = NSURL(string:"https://nolobank.com")
        makeTheLink { (url) in
            if url != nil{
                let currentUser = UserInformationUtility.sharedInstance.getCurrentUser()
                var title = ""
                if let name = currentUser?.name{
                    title = "\(name), wants to invite you to bank with North Loop"
                }
                let urlsToShare = [ title, "\nSign up in 2 minutes and get $10! Use my link to get started: ", url as Any ]
                let activityViewController = UIActivityViewController(activityItems: urlsToShare as [Any], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                self.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeTheLink(completionHandler: @escaping CreateLinkHandler){
//        guard let referrerName = Auth.auth().currentUser?.displayName else { completionHandler(nil); return }
        let currentUser = UserInformationUtility.sharedInstance.getCurrentUser()

        guard let uid = currentUser?.userID else {
            completionHandler(nil);
            return
        }
        let link = URL(string: "https://northloopbank.page.link/?invitedby=\(uid)")
        let referralLink = DynamicLinkComponents(link: link!, domainURIPrefix: "https://northloopbank.page.link")
        
        referralLink?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.northloop.NorthLoop")
//            referralLink.iOSParameters?.minimumAppVersion = "1.0.1"
        referralLink?.iOSParameters?.appStoreID = AppConstants.AppStoreID
            
        referralLink?.shorten { (shortURL, warnings, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completionHandler(nil)
                }
                completionHandler(shortURL)
            }
    }
    
    
}
