//
//  WaitListViewController.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 16/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class WaitListViewController: BaseViewController {

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var okBtn: CommonButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func okBtnClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
        if let _:User = UserInformationUtility.sharedInstance.getCurrentUser(){
            UserInformationUtility.sharedInstance.deleteCurrentUser()
            self.moveToWelcome()
        }
    }
    
    func moveToWelcome(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        //self.navigationController?.pushViewController(transactionDetailController, animated: false)
        var initialNavigationController1:UINavigationController
        
        initialNavigationController1 = UINavigationController(rootViewController:vc)
        initialNavigationController1.navigationBar.makeTransparent()
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = initialNavigationController1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            GIFHUD.shared.dismiss(completion: {
                print("GiFHUD dismissed")
            })
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarTitle(title: "Wait")
        //self.setupRightNavigationBar()
        self.navigationItem.hidesBackButton = true
        
        // A UIImageView with async loading
        //let imageView = UIImageView()
//        self.imageView.loadGif(name: "queue")
    }
}
