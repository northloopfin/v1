//
//  SignUpFormViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 19/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import Auth0

class SignUpFormViewController: BaseViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
   // @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    var presenter:PhoneVerificationStartPresenter!
    var auth0Mngr:Auth0ApiCallManager!

    
    @IBAction func nextClicked(_ sender: Any) {
         validateForm()
    }
    //Validate form for empty text , valid email, valid phone
    func validateForm(){
                //if (Validations.isValidEmail(email: self.emailTextField.text!)){
                    if (Validations.isValidPhone(phone: self.phoneTextField.text!)){
//                        self.callPhoneVerificationAPI()
//                        moveToOTPScreen()
                        self.addUserMetaData(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, phone: self.phoneTextField.text!)
                    }else{
                        self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PHONE_NOT_VALID.rawValue)                }
//                }else{
//                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.EMAIL_NOT_VALID.rawValue)
//            }
    }
    
    func addUserMetaData(firstName: String, lastName: String, phone:String){
        auth0Mngr.auth0UpdateUserMetadata(firstName: firstName, lastName: lastName, phone: phone)
    }
    
    //Call Phone Verification Service
    func callPhoneVerificationAPI(){
        presenter.sendPhoneVerificationRequest()
    }
    
    //Move to OTP screen
    func moveToOTPScreen(){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = PhoneVerificationStartPresenter.init(delegate: self)
        auth0Mngr = Auth0ApiCallManager.init(delegate: self)

        self.inactivateNextBtn()
        self.setupRightNavigationBar()
        updateTextFieldUI()
    }
    
    func updateTextFieldUI(){
        self.firstNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.lastNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
       // self.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.phoneTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0

        self.firstNameTextField.applyAttributesWithValues(placeholderText: "First Name *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.lastNameTextField.applyAttributesWithValues(placeholderText: "Last Name *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        //self.emailTextField.applyAttributesWithValues(placeholderText: "Email *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.phoneTextField.applyAttributesWithValues(placeholderText: "Phone No *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.firstNameTextField.setLeftPaddingPoints(19)
        self.lastNameTextField.setLeftPaddingPoints(19)
        self.phoneTextField.setLeftPaddingPoints(19)
        //self.emailTextField.setLeftPaddingPoints(19)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.inactivateNextBtn()
        }
    }
    
    func activateNextBtn(){
        self.nextBtn.isEnabled=true
        self.nextBtn.backgroundColor = Colors.Zorba161149133
    }
    
    func inactivateNextBtn(){
        self.nextBtn.isEnabled=false
        self.nextBtn.backgroundColor = Colors.Alto224224224
    }
}

extension SignUpFormViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (!(self.firstNameTextField.text?.isEmpty)! && !(self.lastNameTextField.text?.isEmpty)! && !(self.phoneTextField.text?.isEmpty)!)
        //(self.emailTextField.text?.isEmpty)!)
            {
                self.activateNextBtn()
        }
    }
}
extension SignUpFormViewController:PhoneVerificationDelegate{
    func didCheckOTP(result: PhoneVerifyCheck) {
        print("Check")
    }
    func didSentOTP(result:PhoneVerifyStart){
        //self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: result.message)
        self.moveToOTPScreen()
    }
}
extension SignUpFormViewController:Auth0Delegates{
    func didLoggedIn() {
        
    }
    
    func didRetreivedProfile() {
        
    }
    
    func didUpdatedProfile() {
        self.callPhoneVerificationAPI()
        UserInformationUtility.sharedInstance.isLoggedIn = true
        UserInformationUtility.sharedInstance.saveUser(islogged: true)
    }
    
    func didLoggedOut() {
        
    }
    
    func didFailed(err: Error) {
        self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: err.localizedDescription)
    }
}
extension SignUpFormViewController:RailsBankDelegate{
    func didUserCreated() {
        
    }
    
    func didFailedWithError(err: Error) {
        
    }
    
    
}


