//
//  MyAccountViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 11/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
//import Firebase

class MyAccountViewController: BaseViewController {
    @IBOutlet weak var customViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var customView: CommonTable!
    @IBOutlet weak var nameLbl: LabelWithLetterSpace!
    @IBOutlet weak var accountNumberLbl: LabelWithLetterSpace!
    @IBOutlet weak var rountingNumberLbl: LabelWithLetterSpace!
    @IBOutlet weak var swiftNumberLbl: LabelWithLetterSpace!
    var presenter:AccountPresenter!
    var resetPresenter:ResetPasswordPresenter!
    var twoFApresenter:TwoFAPresenter!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.customView.delegate=self
        self.presenter = AccountPresenter.init(delegate: self)
        self.resetPresenter = ResetPasswordPresenter.init(delegate: self)
        self.presenter.sendFetchTransferDetailRequest()
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
        dataSource.append(AppConstants.ProfileOptions.APPSETTINGS.rawValue)
        dataSource.append(AppConstants.ProfileOptions.CHANGEADDRESS.rawValue)
        dataSource.append(AppConstants.ProfileOptions.CHANGEPASSWORD.rawValue)
        dataSource.append(AppConstants.ProfileOptions.CHANGEPHONENUMBER.rawValue)
        dataSource.append(AppConstants.ProfileOptions.LOGOUT.rawValue)


        customView.dataSource = dataSource
        customViewHeightConstraint.constant = CGFloat(dataSource.count*70)
        self.setNavigationBarTitle(title: "My Account")
        self.setupRightNavigationBar()
        self.nameLbl.textColor = Colors.Taupe776857
        self.accountNumberLbl.textColor = Colors.Taupe776857
        self.rountingNumberLbl.textColor = Colors.Taupe776857
        self.swiftNumberLbl.textColor = Colors.Taupe776857
        
        
        //set font
        self.nameLbl.font = AppFonts.textBoxCalibri16
        self.accountNumberLbl.font = AppFonts.textBoxCalibri16
        self.rountingNumberLbl.font = AppFonts.textBoxCalibri16
        self.swiftNumberLbl.font = AppFonts.textBoxCalibri16
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
            // send reset password API request
            self.sendResetPasswordAPIRequest()
        case 3:
            self.twoFApresenter.sendTwoFARequest(sendToAPI: false)
        case 4:
            self.logoutUser()
        default:
            break
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
    func moveToSettings(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
}

extension MyAccountViewController:UserTransferDetailDelegate{
    func didFetchUserTransactionDetail(data: UserTransferDetailData) {
        let domesticAccountDetails = data.transferDetails.domestic
        let internationalAccountDetails = data.transferDetails.international
        self.nameLbl.text = "Name: "+domesticAccountDetails.bankName
        self.accountNumberLbl.text = "Account No: "+domesticAccountDetails.accountNumber
        self.rountingNumberLbl.text = "Routing No: "+domesticAccountDetails.routing
        self.swiftNumberLbl.text = "Swift No: "+internationalAccountDetails.swift
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
