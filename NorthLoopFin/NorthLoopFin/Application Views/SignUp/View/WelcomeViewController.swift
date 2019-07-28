//
//  WelcomeViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 19/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import Crashlytics
import AlertHelperKit

class WelcomeViewController: BaseViewController {

    @IBOutlet weak var loginBtn: RippleButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    var checkUpdatePresenter: CheckUpdatePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        //loginBtn.showsTouchWhenHighlighted=true
        createAccountBtn.showsTouchWhenHighlighted=true
        self.checkUpdatePresenter = CheckUpdatePresenter.init(delegate: self)
        self.checkUpdatePresenter.sendCheckUpdateCall()
        self.checkForFirstTime()
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        self.moveToLogin()
        
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        RealmHelper.deleteAllFromDatabase()
        self.moveToNextScreen()
        
    }
    
    
    func moveToLogin(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(transactionDetailController, animated: false)
        }
    }
    
    func moveToNextScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SignUpStepFirst") as! SignUpStepFirst
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    func checkForFirstTime(){
        if let _ = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForFreshInstall){
            self.moveToLogin()
        }else{
            //key not found .. so fresh install .. stay on same screen
            UserDefaults.saveToUserDefault(true as AnyObject, key: AppConstants.UserDefaultKeyForFreshInstall)
        }
    }
}
extension WelcomeViewController:SettingsDelegates{
    func didSaveAppSettings() {
        
    }
    
    func didGetAppSettings(data: GetPreferencesData) {
        
    }
    
    func didCheckUpdate(data: CheckUpdateResponse) {
        let versionOnAppStore = data.appVersion
        if AppConstants.appVersion != versionOnAppStore{
            //versions are not matching check for version now
            if let appversion = AppConstants.appVersion, data.appVersion > appversion{
                // Update is available
                self.showAlert()
            }
        }
    }
    func showAlert(){
        let params  = Parameters(
            title: AppConstants.ErrorHandlingKeys.CONFIRM_TITLE.rawValue,
            message: AppConstants.ErrorMessages.NEWER_VERSION_AVAILABLE.rawValue,
            cancelButton: "Cancel",
            otherButtons: ["Update"]
        )
        
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                print("Cancel: \(buttonIndex)")
            default:
                let urlString:String = AppConstants.AppStoreUrl
                if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
                
                break
            }
        }
    }
}


