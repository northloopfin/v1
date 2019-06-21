//
//  MyAccountViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 11/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import AlertHelperKit

class MyAccountViewController: BaseViewController {
    @IBOutlet weak var customViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var customView: CommonTable!
    
    var resetPresenter:ResetPasswordPresenter!
    var twoFApresenter:TwoFAPresenter!

    // var to track which option is clicked
    var isChangePhoneClicked:Bool=false
    var isChangeAddressClicked:Bool=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.customView.delegate=self
        self.resetPresenter = ResetPasswordPresenter.init(delegate: self)
        self.twoFApresenter = TwoFAPresenter.init(delegate: self)

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
        dataSource.append(AppConstants.ProfileOptions.ACCOUNTDETAIL.rawValue)
        dataSource.append(AppConstants.ProfileOptions.CHANGEADDRESS.rawValue)
        dataSource.append(AppConstants.ProfileOptions.CHANGEPASSWORD.rawValue)
        dataSource.append(AppConstants.ProfileOptions.CHANGEPHONENUMBER.rawValue)
        dataSource.append(AppConstants.ProfileOptions.APPSETTINGS.rawValue)
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
            self.moveToAccountDetail()
        case 1:
            //change address
            self.isChangeAddressClicked=true
            self.isChangePhoneClicked=false
            self.showConfirmPopUp()
        case 2:
            // send reset password API request
            self.sendResetPasswordAPIRequest()
        case 3:
            //change Phone Number
            self.isChangePhoneClicked=true
            self.isChangeAddressClicked=false
            self.showConfirmPopUp()
        case 4:
            //go to settings page
            self.moveToSettings()
        case 5:
            self.logoutUser()
        default:
            break
        }
    }
    
    //Show popup before changing Phone
    func showConfirmPopUp(){
        
        var params = Parameters(
            title: AppConstants.ErrorHandlingKeys.CONFIRM_TITLE.rawValue,
            message: AppConstants.ErrorMessages.CONFIRM_MESSAGE_TO_CHANGE_ADDRESS.rawValue,
            cancelButton: "Cancel",
            otherButtons: ["Confirmed"]
        )
        if self.isChangePhoneClicked{
            params = Parameters(
                title: AppConstants.ErrorHandlingKeys.CONFIRM_TITLE.rawValue,
                message: AppConstants.ErrorMessages.CONFIRM_MESSAGE_TO_CHANGE_PHONE.rawValue,
                cancelButton: "Cancel",
                otherButtons: ["Confirmed"]
            )
        }
        
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                print("Cancel: \(buttonIndex)")
            default:
                self.performActionAccordingToSelectedOptionToChange()
            }
        }
    }
    
    func performActionAccordingToSelectedOptionToChange(){
        if self.isChangePhoneClicked{
            self.moveToOTP()
        }else if self.isChangeAddressClicked{
            self.moveTo2FA()
        }
    }
    
    //Send Reset Password API request with email as parameter
    func sendResetPasswordAPIRequest(){
        if let user:User = UserInformationUtility.sharedInstance.getCurrentUser(){
            self.resetPresenter.sendResetPasswordRequesy(username: user.userEmail)
        }
    }
    
    func logoutUser(){
       
            UserInformationUtility.sharedInstance.deleteCurrentUser()
            self.moveToWelcome()
    }
    
    func moveToWelcome(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    func moveToAccountDetail(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "AccountDetailViewController") as! AccountDetailViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    func moveToSettings(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}


extension MyAccountViewController: ResetPasswordDelegate{
    func didSentResetPasswordRequest(){
        self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.RESET_EMAIL_SENT.rawValue)
    }
}
extension MyAccountViewController:TwoFADelegates{
    func didGetOTP() {
        //move to OTP screen
        self.moveToOTP()
    }
    
    func moveToOTP(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        vc.screenWhichInitiatedOTP = AppConstants.Screens.CHANGEPHONE
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func moveTo2FA(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Select2FAModeViewController") as! Select2FAModeViewController
        vc.screenWhichInitiated = AppConstants.Screens.CHANGEADDRESS
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
