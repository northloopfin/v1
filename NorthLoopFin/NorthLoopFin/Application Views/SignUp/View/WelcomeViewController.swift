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
    var auth0Mngr:Auth0ApiCallManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        auth0Mngr = Auth0ApiCallManager.init(delegate: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.isLoginScreenOpened = true
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SignUpFormViewController") as!  SignUpFormViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        self.showSignUp()
    }
    
    func showSignUp(){
        auth0Mngr.auth0SignUp()
    }
    
    func moveToNextScreen(){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SignUpFormViewController") as! SignUpFormViewController
                self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
}

extension WelcomeViewController:Auth0Delegates{
    func didLoggedIn() {
        print("Logged In")
        self.moveToNextScreen()
    }
    
    func didRetreivedProfile() {
        
    }
    
    func didUpdatedProfile() {
        
    }
    
    func didLoggedOut() {
        
    }
    
    func didFailed(err: Error) {
        self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: err.localizedDescription)
    }
}
