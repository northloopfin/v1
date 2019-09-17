//
//  LoginViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 07/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

import SwiftKeychainWrapper


class LoginViewController: BaseViewController {
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var forgetPasswordBtn: UIButtonWithSpacing!
    @IBOutlet weak var orLbl: LabelWithLetterSpace!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginBtn: CommonButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var rememberMeCheckBox: CheckBox!
    @IBOutlet weak var showPasswordBtn: UIButton!
    
    var loginPresenter:LoginPresenter!
    var zendeskPresenter:ZendeskPresenter!
    var isRememberMeSelected:Bool = false
    var loginType = "Password"

    
    @IBAction func forgetPasswordClicked(_ sender: Any) {
        self.moveToForgetScreen()
    }
    @IBAction func createAccountClicked(_ sender: Any) {
        self.moveToCreateAccount()
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        // check for TouchID authentication
        self.login(username: self.emailTextField.text!, password: self.passwordTextfield.text!)
        
    }
    
    @IBAction func showPasswordClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.passwordTextfield.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        let check = sender as! CheckBox
        self.isRememberMeSelected = check.isChecked
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarTitle(title: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "")
        self.prepareView()
        self.loginPresenter = LoginPresenter.init(delegate: self)
        self.zendeskPresenter = ZendeskPresenter.init(delegate: self)

        self.logEventForLogin()
        if let email = KeychainWrapper.standard.string(forKey: AppConstants.KeyChainKeyForEmail){
            self.emailTextField.text = email
        }
//        self.emailTextField.text = "test@30.com"
//        self.passwordTextfield.text = "Test1234!"

        if AccountLockTimer.sharedInstance.timer != nil{
            if (AccountLockTimer.sharedInstance.timer?.state.isRunning)!{
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.USER_REACHED_MAX_ATTEMPTS.rawValue)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
        self.checkForStoredLoginCredentials()
        }
    }
    func prepareView(){
        self.rememberMeCheckBox.style = .circle
        self.rememberMeCheckBox.borderStyle = .roundedSquare(radius: 8)
        self.rememberMeCheckBox.isChecked=self.isRememberMeSelected
        //self.rememberMeCheckBox.borderStyle = .roundedSquare(radius: 8)
        
        self.passwordTextfield.isSecureTextEntry=true
        self.loginBtn.isEnabled=false
        self.mainTitleLbl.textColor=Colors.MainTitleColor
        self.mainTitleLbl.font=AppFonts.mainTitleCalibriBold25
        self.orLbl.textColor=Colors.PurpleColor17673149
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
        }else{
            checkMandatoryFields()
        }
    }
    //change appearance of done button
    func changeApperanceOfDone(){
        self.loginBtn.isEnabled=true
    }
    
    func inactivateDoneBtn(){
        self.loginBtn.isEnabled=false
    }
    
    func moveToCreateAccount(){
        logEventsHelper.logEventWithName(name: "Signup", andProperties: ["Event": "Create Account"])
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignUpStepFirst") as! SignUpStepFirst
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
    
    func initiateBiometric(){
        BioMetricHelper.isValidUer(reasonString: "Sign in using TouchID/FaceID") {[unowned self] (isSuccess, stringValue) in
            
            if isSuccess
            {
                // when authentication successful then call login api
                self.loginType = "Biometric"
                self.login(username: KeychainWrapper.standard.string(forKey: AppConstants.KeyChainKeyForEmail)!, password: KeychainWrapper.standard.string(forKey: AppConstants.KeyChainKeyForPassword)!)
            }
            else
            {
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: stringValue?.description ?? "invalid")
            }
            
        }
    }
    
    //This function will check for login credentials saved in KeyChain. If saved then initiate biometric otherwise let user enter credentials
    func checkForStoredLoginCredentials(){
        if let _ = KeychainWrapper.standard.string(forKey: AppConstants.KeyChainKeyForEmail),let _ = KeychainWrapper.standard.string(forKey: AppConstants.KeyChainKeyForPassword){
            self.initiateBiometric()
        }
    }
    
    //this function will perform login
    func login(username:String,password:String){
        if UserInformationUtility.sharedInstance.userattemptsIn10Min >= 3{
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.USER_REACHED_MAX_ATTEMPTS.rawValue)
        }else{
            if (Validations.isValidEmail(email: self.emailTextField.text!)){
                //manager.signInWithData(self.emailTextField.text!, self.passwordTextfield.text!)
                self.loginPresenter.sendLoginRequest(username: username, password: password)
            }else{
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.EMAIL_NOT_VALID.rawValue)
            }
        }
    }
}
//MARK: UITextFiled Delegates
extension LoginViewController:UITextFieldDelegate{
    fileprivate func checkMandatoryFields() {
        if (!(self.emailTextField.text?.isEmpty)! && !(self.passwordTextfield.text?.isEmpty)!)// && !(self.emailTextField.text?.isEmpty)! )
        {
            
            self.changeApperanceOfDone()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (!(self.emailTextField.text?.isEmpty)! && !(self.passwordTextfield.text?.isEmpty)!){
        self.view.endEditing(true)
        self.loginClicked(loginBtn)
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        checkMandatoryFields()
    }
}

extension LoginViewController:LoginDelegate{
    func didLoggedIn(data: LoginData) {
        //successfully logged in user..move to home page
        //call Zendesk API to get identity token
        // save email and password only if remember is enabled
        logEventsHelper.logEventWithName(name: "Login", andProperties: ["Event": loginType])
        if data.isSignupCompleted{
            if data.isVerified{
                //if user is verified
                if self.rememberMeCheckBox.isChecked{
                    UserDefaults.saveToUserDefault(self.emailTextField!.text as AnyObject, key: AppConstants.UserDefaultKeyForEmail)
                    // save password entered to KeyChain
                    let password:String = self.passwordTextfield.text ?? ""
                    
                    
                    if KeychainWrapper.standard.set(password, forKey: AppConstants.KeyChainKeyForPassword){
                        print("Password Saved to Keychain")
                    }
                    let email:String = self.emailTextField.text ?? ""
                    if KeychainWrapper.standard.set(email, forKey: AppConstants.KeyChainKeyForEmail){
                        print("email Saved to Keychain")
                    }
                }
                self.zendeskPresenter.sendZendeskTokenRequest()
            }else{
                //if user is not verified
                self.moveToWaitList()
            }
        }else{
            let completeToken = data.accessToken
            //We are storing this accestoken here teporarily, Will store access token
            UserDefaults.saveToUserDefault(completeToken as AnyObject, key: AppConstants.UserDefaultKeyForAccessToken)
            UserDefaults.saveToUserDefault(self.emailTextField.text! as AnyObject, key: AppConstants.UserDefaultKeyForEmail)
            
            
            let emptyDoc:SignupFlowDocument = SignupFlowDocument.init(entityScope: "Arts & Entertainment", email: "", phoneNumber: "", ip: UIDevice.current.ipAddress(), name: "Test", entityType: "M", day: 0, month: 0, year: 0, desiredScope: "SEND|RECEIVE|TIER|1", docsKey: "GOVT_ID_ONLY", virtualDocs: [], physicalDocs: [])
            let address:SignupFlowAddress = SignupFlowAddress.init(street: "", city: "", state: "", zip: "",countty:"",houseNumber:"")
            let signupflowData:SignupFlowData = SignupFlowData.init(userID: data.userID, userIP: UIDevice.current.ipAddress(), email: data.basicInformation.email, university: "", passport: "", address: address, phoneNumbers: [], legalNames: [], password: self.passwordTextfield.text!, documents: emptyDoc, suppID: "Test", cipTag: 2, arrivalDate: "", deviceType: "IOS")
            
            // move to next step of Sign Up
            self.moveToSignupStepSecond(data: signupflowData)
        }
    }
    
    func moveToWaitList(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "WaitListViewController") as! WaitListViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    func moveToSignupStepSecond(data:SignupFlowData) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PersonalDetailViewController") as! PersonalDetailViewController
        vc.signupFlowData=data
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    func didLoginFailed(error: ErrorModel) {
        self.showErrorAlert(AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, alertMessage: error.getErrorMessage())
    }
    
    func moveToTest(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "CurrencyProtectController") as! CurrencyProtectController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
}
extension LoginViewController:ZendeskDelegates{
    func didSentZendeskToken(data: ZendeskData) {
        AppUtility.configureZendesk(data: data)
        //self.moveToHome()
//        moveToTest()
        AppUtility.moveToHomeScreen()
    }
}

