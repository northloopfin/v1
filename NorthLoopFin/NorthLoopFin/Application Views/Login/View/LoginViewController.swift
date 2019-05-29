//
//  LoginViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 07/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import Firebase
import MFSideMenu
import ZendeskSDK
import ZendeskCoreSDK

class LoginViewController: BaseViewController {
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var forgetPasswordBtn: UIButtonWithSpacing!
    @IBOutlet weak var orLbl: LabelWithLetterSpace!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginBtn: CommonButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    
    var loginPresenter:LoginPresenter!
    var zendeskPresenter:ZendeskPresenter!


    
    @IBAction func forgetPasswordClicked(_ sender: Any) {
        self.moveToForgetScreen()
    }
    @IBAction func createAccountClicked(_ sender: Any) {
        self.moveToCreateAccount()
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if UserInformationUtility.sharedInstance.userattemptsIn10Min >= 3{
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.USER_REACHED_MAX_ATTEMPTS.rawValue)
        }else{
            if (Validations.isValidEmail(email: self.emailTextField.text!)){
                //manager.signInWithData(self.emailTextField.text!, self.passwordTextfield.text!)
                self.loginPresenter.sendLoginRequest(username: self.emailTextField.text ?? "", password: self.passwordTextfield.text ?? "")
            }else{
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.EMAIL_NOT_VALID.rawValue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Login")
        self.prepareView()
       // manager=FirebaseManager.init(delegate: self)
        self.loginPresenter = LoginPresenter.init(delegate: self)
        self.zendeskPresenter = ZendeskPresenter.init(delegate: self)

        self.logEventForLogin()
        if let email = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail){
            self.emailTextField.text = email as? String
        }
        if AccountLockTimer.sharedInstance.timer != nil{
            if (AccountLockTimer.sharedInstance.timer?.state.isRunning)!{
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.USER_REACHED_MAX_ATTEMPTS.rawValue)
            }
        }
    }
    func prepareView(){
        self.passwordTextfield.isSecureTextEntry=true
        self.loginBtn.isEnabled=false
        self.mainTitleLbl.textColor=Colors.MainTitleColor
        self.mainTitleLbl.font=AppFonts.mainTitleCalibriBold25
        self.orLbl.textColor=Colors.Taupe776857
        self.orLbl.font=AppFonts.calibri15
        self.emailTextField.textColor = Colors.DustyGray155155155
        self.passwordTextfield.textColor=Colors.DustyGray155155155
        self.emailTextField.font=AppFonts.textBoxCalibri16
        self.passwordTextfield.font=AppFonts.textBoxCalibri16
        self.loginBtn.titleLabel!.font=AppFonts.calibri15
        self.forgetPasswordBtn.titleLabel?.textColor=Colors.Taupe776857
        self.forgetPasswordBtn.titleLabel?.font=AppFonts.calibri15
        self.createAccountBtn.titleLabel?.font = AppFonts.calibri15
        self.createAccountBtn.setTitleColor(Colors.Taupe776857, for: .normal)
        self.configureTextFields()
    }
    
    func configureTextFields(){
        self.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.passwordTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.emailTextField.applyAttributesWithValues(placeholderText: "Email*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.passwordTextfield.applyAttributesWithValues(placeholderText: "Password*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.emailTextField.setLeftPaddingPoints(19)
        self.passwordTextfield.setLeftPaddingPoints(19)
    }
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.inactivateDoneBtn()
        }
    }
    //change appearance of done button
    func changeApperanceOfDone(){
        self.loginBtn.isEnabled=true
    }
    
    func inactivateDoneBtn(){
        self.loginBtn.isEnabled=false
    }
    
    func moveToHome(){
        let containerViewController:MFSideMenuContainerViewController=MFSideMenuContainerViewController()
        var initialNavigationController:UINavigationController
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let sideMenu:SideMenuViewController = (storyBoard.instantiateViewController(withIdentifier: String(describing: SideMenuViewController.self)) as? SideMenuViewController)!
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        initialNavigationController = UINavigationController(rootViewController:homeViewController)
        sideMenu.delegate = homeViewController
        containerViewController.leftMenuViewController=sideMenu
        containerViewController.centerViewController=initialNavigationController
        containerViewController.setMenuWidth(UIScreen.main.bounds.size.width * 0.70, animated:true)
        containerViewController.shadow.enabled=true;
        containerViewController.panMode = MFSideMenuPanModeDefault
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = containerViewController
    }
    
    func moveToCreateAccount(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignUpFormViewController") as! SignUpFormViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func moveToForgetScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func logEventForLogin(){
        let eventProperties:[String:String] = ["EventCategory":"Login","Description":"when the user lands on the login screen/page"]
        let eventName:String = "View Login Screen"
        logEventsHelper.logEventWithName(name: eventName, andProperties: eventProperties)
    }
}
//MARK: UITextFiled Delegates
extension LoginViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (!(self.emailTextField.text?.isEmpty)! && !(self.passwordTextfield.text?.isEmpty)!)// && !(self.emailTextField.text?.isEmpty)! )
        {
            
            self.changeApperanceOfDone()
        }
    }
}

extension LoginViewController:LoginDelegate{
    func didLoggedIn(data: LoginData) {
        //successfully logged in user..move to home page
        //call Zendesk API to get identity token
        self.zendeskPresenter.sendZendeskTokenRequest()
    }
    
    
    func didLoginFailed(error: ErrorModel) {
        self.showErrorAlert(AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, alertMessage: error.getErrorMessage())
    }
    
}
extension LoginViewController:ZendeskDelegates{
    func didSentZendeskToken(data: ZendeskData) {
        AppUtility.configureZendesk(data: data)
        self.moveToHome()
    }
}

