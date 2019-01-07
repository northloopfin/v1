//
//  WelcomeViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 19/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import Auth0

class WelcomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        self.showSignUp()
    }
    
    func showSignUp(){
        guard let clientInfo = plistValues(bundle: Bundle.main) else { return }
        SessionManager.shared.patchMode = true
        Auth0
            .webAuth()
            .scope("openid profile offline_access read:current_user update:current_user_metadata")
            .audience("https://" + clientInfo.domain + "/api/v2/")
            .start {
                switch $0 {
                case .failure(let error):
                    print("Error: \(error)")
                case .success(let credentials):
                    if(!SessionManager.shared.store(credentials: credentials)) {
                        print("Failed to store credentials")
                    } else {
                        SessionManager.shared.retrieveProfile { error in
                            DispatchQueue.main.async {
                                guard error == nil else {
                                    print("Failed to retrieve profile: \(String(describing: error))")
                                    return
                                }
                                //self.performSegue(withIdentifier: "ShowProfileNonAnimated", sender: nil)
                                self.moveToNextScreen()
                            }
                        }
                    }
                }
        }
    }
    
    func moveToNextScreen(){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SignUpFormViewController") as! SignUpFormViewController
                self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }

    /// Get values for Auth0 signup from plist
    ///
    /// - Parameter bundle: Main Bundle
    /// - Returns: clientId,domain
    
    func plistValues(bundle: Bundle) -> (clientId: String, domain: String)? {
        guard
            let path = bundle.path(forResource: "Auth0", ofType: "plist"),
            let values = NSDictionary(contentsOfFile: path) as? [String: Any]
            else {
                print("Missing Auth0.plist file with 'ClientId' and 'Domain' entries in main bundle!")
                return nil
        }
        
        guard
            let clientId = values["ClientId"] as? String,
            let domain = values["Domain"] as? String
            else {
                print("Auth0.plist file at \(path) is missing 'ClientId' and/or 'Domain' entries!")
                print("File currently has the following entries: \(values)")
                return nil
        }
        return (clientId: clientId, domain: domain)
    }

}
