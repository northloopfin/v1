//
//  SettingsViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 11/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    @IBOutlet weak var customViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var customView: CommonTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        customView.delegate=self
        // Do any additional setup after loading the view.
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
        dataSource.append(AppConstants.SettingsOptions.NOTIFICATIONSETTINGS.rawValue)
        dataSource.append(AppConstants.SettingsOptions.PRIVACYPREFERENCES.rawValue)
        dataSource.append(AppConstants.SettingsOptions.MARKETINGPREFERENCES.rawValue)
        customView.dataSource = dataSource
        customViewHeightConstraint.constant = CGFloat(dataSource.count*70)
        self.setNavigationBarTitle(title: "Settings")
        self.setupRightNavigationBar()
    }
}

extension SettingsViewController:CommonTableDelegate{
    func didSelectOption(optionVal: Int) {
        switch optionVal {
        case 0:
            print("Notification")
            self.moveToNotificationSettings()
        case 1:
            self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.COMING_SOON.rawValue)
        case 2:
            //self.moveToDirectDeposit()
            self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.COMING_SOON.rawValue)
        default:
            break
        }
    }
    func moveToNotificationSettings(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "NotificationSettingsViewController") as! NotificationSettingsViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
//    func moveToNewPin(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "NewPinViewController") as! NewPinViewController
//        self.navigationController?.pushViewController(transactionDetailController, animated: false)
//    }
//    func moveToDirectDeposit(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "DirectDepositViewController") as! DirectDepositViewController
//        self.navigationController?.pushViewController(transactionDetailController, animated: false)
//    }
//    func moveToLostInsufficient(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "LostInsufficientViewController") as! LostInsufficientViewController
//        self.navigationController?.pushViewController(transactionDetailController, animated: false)
//    }
//    func moveToConfirmed(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "ConfirmedViewController") as! ConfirmedViewController
//        self.navigationController?.pushViewController(transactionDetailController, animated: false)
//    }
//    func moveToMyOffer(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "MyOffersViewController") as! MyOffersViewController
//        self.navigationController?.pushViewController(transactionDetailController, animated: false)
//    }
//    func moveToAddAccount(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "AddAccountViewController") as! AddAccountViewController
//        self.navigationController?.pushViewController(transactionDetailController, animated: false)
//    }
//    
    
    
}
