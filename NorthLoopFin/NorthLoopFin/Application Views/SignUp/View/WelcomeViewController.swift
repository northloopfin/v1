//
//  WelcomeViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 19/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import Crashlytics

class WelcomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        self.moveToLogin()
        
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        self.moveToNextScreen()
    }
    
    func moveToLogin(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "ScanIDViewController") as! ScanIDViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    func moveToNextScreen(){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SetPasswordViewController") as! SetPasswordViewController
                self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
}

