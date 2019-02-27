//
//  SetPasswordViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import Firebase
import Amplitude_iOS

class SetPasswordViewController: BaseViewController {
    @IBOutlet weak var doneBtn: CommonButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!    
    @IBOutlet weak var termsPrivacyLbl: LabelWithLetterSpace!
    @IBOutlet weak var TermsAndConditionLbl: LabelWithLetterSpace!
    @IBOutlet weak var bySigningUpLbl: LabelWithLetterSpace!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    
    var firebaseManager:FirebaseManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.doneBtn.isEnabled=false
        self.updateTextFieldUI()
        self.prepareView()
        firebaseManager = FirebaseManager.init(delegate: self)
    }
    
    //Action called when done button clicked
    @IBAction func doneClicked(_ sender: Any) {
        if(Validations.isValidEmail(email: self.emailTextField.text ?? "")){
            if (Validations.isValidPassword(password: self.passwordTextField.text ?? "")){
                if(Validations.matchTwoStrings(string1: self.passwordTextField.text!, string2: self.confirmPasswordTextField.text!)){
                    self.createAccountWithData(self.emailTextField.text!, self.passwordTextField.text!)
                }else{
                    //error for unmatched passwords
                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PASSWORD_DONOT_MATCH.rawValue)
                }
            }else{
                //error for invalid password
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PASSWORD_NOT_VALID.rawValue)
            }
        }else{
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.EMAIL_NOT_VALID.rawValue)
            
        }
    }
    
    
    /// Prepare view by setting up color and font of View components
    func prepareView(){
        self.mainTitleLbl.textColor=Colors.MainTitleColor
        self.passwordTextField.textColor = Colors.DustyGray155155155
        self.emailTextField.textColor = Colors.DustyGray155155155
        self.confirmPasswordTextField.textColor=Colors.DustyGray155155155
        self.bySigningUpLbl.textColor=Colors.Tundora747474
        self.termsPrivacyLbl.textColor = Colors.Cameo213186154
        
        self.mainTitleLbl.font=AppFonts.mainTitleCalibriBold25
        self.passwordTextField.font=AppFonts.textBoxCalibri16
        self.emailTextField.font=AppFonts.textBoxCalibri16
        self.confirmPasswordTextField.font=AppFonts.textBoxCalibri16
        self.bySigningUpLbl.font=AppFonts.calibri15
        self.termsPrivacyLbl.font=AppFonts.calibri15
        
    }
    
    //Change appearance of TextFields
    func updateTextFieldUI(){
        self.passwordTextField.isSecureTextEntry=true
        self.confirmPasswordTextField.isSecureTextEntry=true
        
        self.passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.confirmPasswordTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)

        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.passwordTextField.applyAttributesWithValues(placeholderText: "Password*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.confirmPasswordTextField.applyAttributesWithValues(placeholderText: "Confirm Password*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.emailTextField.applyAttributesWithValues(placeholderText: "Email*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.passwordTextField.setLeftPaddingPoints(19)
        self.confirmPasswordTextField.setLeftPaddingPoints(19)
        self.emailTextField.setLeftPaddingPoints(19)

    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.inactivateDoneBtn()
        }
    }
    //change appearance of done button
    func changeApperanceOfDone(){
        self.doneBtn.isEnabled=true
    }
    
    func inactivateDoneBtn(){
        self.doneBtn.isEnabled=false
    }
    
    func createAccountWithData(_ email:String,_ password:String){
        firebaseManager?.createUserWithData(email, password)
    }
    
    func moveToCreateAccount(){
        // set screen here
        UserDefaults.saveToUserDefault(AppConstants.Screens.USERDETAIL.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
        // track event here for Create account
        self.logEvent()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "CreateAccountV2ViewController") as! CreateAccountV2ViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    func logEvent(){
        // Log Event for Create Account
        let eventProperties:[String:String] = ["EventCategory":"Onboarding","Description":"when user successfully creates an account"]
        let eventName:String = "Create account"
        logEventsHelper.logEventWithName(name: eventName, andProperties: eventProperties)
    }
}

//MARK: UITextFiled Delegates
extension SetPasswordViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (!(self.passwordTextField.text?.isEmpty)! && !(self.confirmPasswordTextField.text?.isEmpty)! && !(self.emailTextField.text?.isEmpty)! )
            {
            self.changeApperanceOfDone()
        }
    }
}

extension SetPasswordViewController:FirebaseDelegates{
    func didSendPasswordReset(error: NSError?) {
        
    }
    
    func didFirebaseDatabaseUpdated() {
        
    }
    func didFirebaseUserCreated(authResult: AuthDataResult?, error: NSError?) {
        guard let authResult = authResult, error == nil else {
            print(error!.localizedDescription)
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: error!.localizedDescription)
            return
        }
        let user:User = User.init(loggedInStatus: true,email:authResult.user.email!)
        UserInformationUtility.sharedInstance.saveUser(model: user)
        UserDefaults.saveToUserDefault(authResult.user.email! as AnyObject, key: AppConstants.UserDefaultKeyForEmail)
        self.moveToCreateAccount()
    }
    func didNameUpdated(error:NSError?){

    }
    func didLoggedIn(error:NSError?){
        
    }
    func didReadUserFromDatabase(error:NSError?, data:NSDictionary?){
        
    }
}
