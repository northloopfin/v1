//
//  MyAccountViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 11/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import Firebase

class MyAccountViewController: BaseViewController {
    @IBOutlet weak var customViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var customView: CommonTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.customView.delegate=self

    }
    override func viewDidLayoutSubviews() {
        let shadowOffst = CGSize.init(width: 0, height: -55)
        let shadowOpacity = 0.1
        let shadowRadius = 49
        let shadowColor = Colors.Zorba161149133
        self.customView.containerView.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }
    
    func prepareView(){
        
        var dataSource:[String] = []
        dataSource.append(AppConstants.ProfileOptions.APPSETTINGS.rawValue)
        dataSource.append(AppConstants.ProfileOptions.CHANGEADDRESS.rawValue)
        dataSource.append(AppConstants.ProfileOptions.CHANGEPASSWORD.rawValue)
        dataSource.append(AppConstants.ProfileOptions.CHANGEPHONENUMBER.rawValue)
        dataSource.append(AppConstants.ProfileOptions.LOGOUT.rawValue)


        customView.dataSource = dataSource
        customViewHeightConstraint.constant = CGFloat(dataSource.count*70)
        self.setNavigationBarTitle(title: "My Account")
        self.setupRightNavigationBar()
    }
}

extension MyAccountViewController:CommonTableDelegate{
    func didSelectOption(optionVal: Int) {
        switch optionVal {
        case 0:
            self.moveToSettings()
        case 1:
            self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.COMING_SOON.rawValue)
        case 2:
            self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.COMING_SOON.rawValue)
        case 3:
            self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.COMING_SOON.rawValue)
        case 4:
            self.logoutUser()
        default:
            break
        }
    }
    
    func logoutUser(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserInformationUtility.sharedInstance.deleteCurrentUser()
            self.moveToWelcome()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    func moveToWelcome(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    func moveToSettings(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
}
