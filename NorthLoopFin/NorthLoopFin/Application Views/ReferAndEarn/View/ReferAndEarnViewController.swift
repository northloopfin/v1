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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func shareClicked(_ sender: Any) {
        let myWebsite = NSURL(string:"https://nolobank.com")
        let urlsToShare = [ myWebsite ]
        let activityViewController = UIActivityViewController(activityItems: urlsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeTheLink() {
//        guard let referrerName = Auth.auth().currentUser?.displayName else { return }
//        let subject = "\(referrerName) wants you to play MyExampleGame!"
//        let invitationLink = invitationUrl?

//        guard let uid = Auth.auth().currentUser?.uid else { return nil }
//        let link = URL(string: "https://mygame.example.com/?invitedby=\(uid)")
//        if let referralLink = DynamicLinkComponents(link: link!, domainURIPrefix: "example.page.link") {
//            
//            referralLink.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.example.ios")
//            referralLink.iOSParameters?.minimumAppVersion = "1.0.1"
//            referralLink.iOSParameters?.appStoreID = "123456789"
//            
//            referralLink.androidParameters = DynamicLinkAndroidParameters(packageName: "com.example.android")
//            referralLink.androidParameters?.minimumVersion = 125
//            
//            referralLink.shorten { (shortURL, warnings, error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                    return nil
//                }
//                return shortURL
//            }
//        } else {
//            return nil
//        }
    }
    
    
}
