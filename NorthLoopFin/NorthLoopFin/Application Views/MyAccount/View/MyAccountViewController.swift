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
    @IBOutlet weak var tableView: UITableView!
    
    var resetPresenter:ResetPasswordPresenter!
    var twoFApresenter:TwoFAPresenter!
    var dataSource:[MyAccountOptionsModel] = []

    // var to track which option is clicked
    var isChangePhoneClicked:Bool=false
    var isChangeAddressClicked:Bool=false
    var isChangePasswordClicked:Bool=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.resetPresenter = ResetPasswordPresenter.init(delegate: self)
        self.twoFApresenter = TwoFAPresenter.init(delegate: self)
    }
    
    func resetChangeOptionVar(){
         isChangePhoneClicked=false
         isChangeAddressClicked=false
         isChangePasswordClicked=false
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    func prepareView(){
        self.setNavigationBarTitle(title: "My Account")
        self.setupRightNavigationBar()

        dataSource.append(MyAccountOptionsModel.init(AppConstants.ProfileOptions.ACCOUNTDETAIL.rawValue, image: "ic_account_detail"))
        dataSource.append(MyAccountOptionsModel.init(AppConstants.ProfileOptions.CHANGEADDRESS.rawValue, image: "ic_change_address"))
        dataSource.append(MyAccountOptionsModel.init(AppConstants.ProfileOptions.CHANGEPASSWORD.rawValue, image: "ic_change_password"))
        dataSource.append(MyAccountOptionsModel.init(AppConstants.ProfileOptions.CHANGEPHONENUMBER.rawValue, image: "ic_change_phone"))
        dataSource.append(MyAccountOptionsModel.init(AppConstants.ProfileOptions.APPSETTINGS.rawValue, image: "ic_app_setting"))
        dataSource.append(MyAccountOptionsModel.init(AppConstants.ProfileOptions.LOGOUT.rawValue, image: "ic_logout"))
        configureTableView()
    }
}


extension MyAccountViewController:UITableViewDelegate,UITableViewDataSource{
    func configureTableView(){
        self.tableView.rowHeight = 84
        self.tableView.registerTableViewCell(tableViewCell: MyAccountOptionCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyAccountOptionCell = tableView.dequeueReusableCell(withIdentifier: "MyAccountOptionCell") as! MyAccountOptionCell
        let option = dataSource[indexPath.row]
        cell.lblTitle.text = option.option
        cell.imgPreview.image = UIImage(named: option.imageName)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return self.tableView.rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectOption(optionVal: indexPath.row)
    }
    
    func didSelectOption(optionVal: Int) {
        self.resetChangeOptionVar()
        switch optionVal {
            
        case 0:
            self.moveToAccountDetail()
        case 1:
            //change address
            self.isChangeAddressClicked=true
            self.showConfirmPopUp()
        case 2:
            self.navigationController?.pushViewController(self.getControllerWithIdentifier("ChangePasswordController"), animated: true)
            //            self.isChangePasswordClicked=true
        //            self.showConfirmPopUp()
        case 3:
            //change Phone Number
            self.isChangePhoneClicked=true
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
            otherButtons: ["Confirm"]
        )
        if self.isChangePhoneClicked{
            params = Parameters(
                title: AppConstants.ErrorHandlingKeys.CONFIRM_TITLE.rawValue,
                message: AppConstants.ErrorMessages.CONFIRM_MESSAGE_TO_CHANGE_PHONE.rawValue,
                cancelButton: "Cancel",
                otherButtons: ["Confirm"]
            )
        }else if self.isChangePasswordClicked{
            params = Parameters(
                title: AppConstants.ErrorHandlingKeys.CONFIRM_TITLE.rawValue,
                message: AppConstants.ErrorMessages.CONFIRM_MESSAGE_TO_CHANGE_PASSWORD.rawValue,
                cancelButton: "Cancel",
                otherButtons: ["Confirm"]
            )
        }
        
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                print("Cancel: \(buttonIndex)")
            default:
                // initiate Biometric for other options except Password
                if self.isChangePasswordClicked{
                    self.performActionAccordingToSelectedOptionToChangeWhenNoAuth()
                }else{
                    self.initiateBiometric()
                    
                }
            }
        }
    }
    
    func initiateBiometric(){
        if BioMetricHelper.isDeviceSupportedforAuth(){
            //yes
            BioMetricHelper.isValidUer(reasonString: "Authenticate for Northloop") {[unowned self] (isSuccess, stringValue) in
                if isSuccess
                {
                    self.performActionAccordingToSelectedOptionToChangeWithAuth()
                }
                else
                {
                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: stringValue?.description ?? "invalid")
                }
            }
        }else{
            self.performActionAccordingToSelectedOptionToChangeWhenNoAuth()
        }
    }
    
    // perform when biometric is successful
    func performActionAccordingToSelectedOptionToChangeWhenNoAuth(){
        if self.isChangePhoneClicked {
            self.twoFApresenter.sendTwoFARequest(sendToAPI: false)
        }else if self.isChangeAddressClicked{
            self.moveTo2FA()
        }
    }
    
    // perform when biometric is not available
    func performActionAccordingToSelectedOptionToChangeWithAuth(){
        if self.isChangePhoneClicked{
            self.moveToChangePhoneScreen()
        }else if self.isChangeAddressClicked{
            self.moveToAddressScreen()
        }
    }
    
    //Send Reset Password API request with email as parameter
    func sendResetPasswordAPIRequest(){
        if let user:User = UserInformationUtility.sharedInstance.getCurrentUser(){
            self.resetPresenter.sendResetPasswordRequesy(username: user.userEmail)
        }
    }
    
    func logoutUser(){
        logEventsHelper.logEventWithName(name: "Logout", andProperties: ["Event": "when the user logs out"])
        UserInformationUtility.sharedInstance.deleteCurrentUser()
        AppUtility.moveToWelcome()
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
        //self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.COMING_SOON.rawValue)
    }
    
    func moveToAddressScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyAddressViewController") as! VerifyAddressViewController
        vc.screenThatInitiatedThisFlow = AppConstants.Screens.CHANGEADDRESS
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
        self.moveToChangePhoneScreen()
    }
    
//    func moveToOTP(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
//        vc.screenWhichInitiatedOTP = AppConstants.Screens.CHANGEPHONE
//        self.navigationController?.pushViewController(vc, animated: false)
//    }
    
    func moveToChangePhoneScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChangePhoneViewController") as! ChangePhoneViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func moveTo2FA(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Select2FAModeViewController") as! Select2FAModeViewController
        if self.isChangePasswordClicked{
            vc.screenWhichInitiated = AppConstants.Screens.ChangePASSWORD
        }else if self.isChangeAddressClicked{
            vc.screenWhichInitiated = AppConstants.Screens.CHANGEADDRESS
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

