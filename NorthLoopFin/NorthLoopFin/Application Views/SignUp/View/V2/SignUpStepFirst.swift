//
//  SignUpStepFirst.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 16/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper


class SignUpStepFirst: BaseViewController {
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var paswwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var loginLbl: UIButtonWithSpacing!
    @IBOutlet weak var alreadyHaveaccountLbl: LabelWithLetterSpace!
    @IBOutlet weak var agreementLbl: LabelWithLetterSpace!

    var presenter: SignupAuthPresenter!
    @IBOutlet weak var customProgressView: ProgressView!

    @IBAction func nextClicked(_ sender: Any) {
        validateForm()
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    //Validate form for empty text , valid email, valid phone
    func validateForm(){
        if (Validations.isValidEmail(email: self.emailTextField.text!)){
            if (Validations.isValidPassword(password: self.paswwordTextField.text!)){
                // Move to next Step
                if(Validations.matchTwoStrings(string1: self.paswwordTextField.text!, string2: self.confirmPassTextField.text!)){
                    // do something
                    self.presenter.startSignUpAuth(email: self.emailTextField.text!, password: self.paswwordTextField.text!)
                }else{
                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PASSWORD_DONOT_MATCH.rawValue)
                }
            }else{
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PASSWORD_NOT_VALID.rawValue)
            }
        }else{
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.EMAIL_NOT_VALID.rawValue)
        }
    }
    // Life Cycle of Controller
    override func viewDidLoad() {

        self.prepareView()
        self.nextBtn.isEnabled=false
        self.setupRightNavigationBar()
        self.updateTextFieldUI()
        self.presenter = SignupAuthPresenter.init(delegate:self)
        self.setSampleData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /// Prepare view by setting color and fonts to view components
    func prepareView(){
        self.customProgressView.progressView.setProgress(0.17*1, animated: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(tap:)))
        self.agreementLbl.addGestureRecognizer(tap)
        self.agreementLbl.isUserInteractionEnabled = true
        //Set text color to view components
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.paswwordTextField.textColor = Colors.DustyGray155155155
        self.confirmPassTextField.textColor = Colors.DustyGray155155155
        self.emailTextField.textColor = Colors.DustyGray155155155
        self.alreadyHaveaccountLbl.textColor = Colors.Tundora747474
        self.loginLbl.titleLabel!.textColor = Colors.NeonCarrot25414966
        
        // Set Font to view components
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.paswwordTextField.font = AppFonts.textBoxCalibri16
        self.confirmPassTextField.font = AppFonts.textBoxCalibri16
        self.emailTextField.font = AppFonts.textBoxCalibri16
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
        self.alreadyHaveaccountLbl.font = AppFonts.calibri15
        self.loginLbl.titleLabel!.font = AppFonts.calibriBold15
    }
    
    @objc func tapLabel(tap: UITapGestureRecognizer) {
        
        if let rangeForDeposit = self.agreementLbl.text?.range(of: "Deposit")?.nsRange{
            if tap.didTapAttributedTextInLabel(label: self.agreementLbl, inRange: rangeForDeposit) {
                            // Substring tapped
                //open deposit agreement
                self.navigateToAgreement(agreementType: AppConstants.AGREEMENTTYPE.DEPOSIT)
            }
        }
        
        if let rangeForAccount = self.agreementLbl.text?.range(of: "Account")?.nsRange{
            if tap.didTapAttributedTextInLabel(label: self.agreementLbl, inRange: rangeForAccount) {
                            // Substring tapped
                self.navigateToAgreement(agreementType: AppConstants.AGREEMENTTYPE.ACCOUNT)
            }
        }
        if let rangeForCard = self.agreementLbl.text?.range(of: "Card Agreement")?.nsRange{
            if tap.didTapAttributedTextInLabel(label: self.agreementLbl, inRange: rangeForCard) {
                            // Substring tapped
                self.navigateToAgreement(agreementType: AppConstants.AGREEMENTTYPE.CARD)
            }
        }
    }
    
    func navigateToAgreement(agreementType:AppConstants.AGREEMENTTYPE){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AgreementViewController") as! AgreementViewController
        vc.agreementType = agreementType
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func updateTextFieldUI(){
        self.paswwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.confirmPassTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
         self.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        //self.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.paswwordTextField.applyAttributesWithValues(placeholderText: "Password*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.confirmPassTextField.applyAttributesWithValues(placeholderText: "Confirm Password*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.emailTextField.applyAttributesWithValues(placeholderText: "Email*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        //self.emailTextField.applyAttributesWithValues(placeholderText: "Phone No*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.paswwordTextField.setLeftPaddingPoints(19)
        self.confirmPassTextField.setLeftPaddingPoints(19)
        //self.phoneTextField.setLeftPaddingPoints(19)
        self.emailTextField.setLeftPaddingPoints(19)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.nextBtn.isEnabled=false
        }else{
            self.checkForMandatoryFields()
        }
    }
    
    func checkForMandatoryFields(){
        if (!(self.paswwordTextField.text?.isEmpty)! && !(self.confirmPassTextField.text?.isEmpty)! && !(self.emailTextField.text?.isEmpty)!
            )
            //(self.emailTextField.text?.isEmpty)!)
        {
            self.nextBtn.isEnabled=true
        }
    }
    
    // Remove this sample values
    func setSampleData(){
        self.emailTextField.text = "Sunita210@gmail.com"
        self.paswwordTextField.text = "test1234!"
        self.confirmPassTextField.text = "test1234!"
    }
}

extension SignUpStepFirst:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.checkForMandatoryFields()
    }
}

extension SignUpStepFirst:SignupAuthDelegate{
     func didSignrdUPAuth(data:SignupAuth){
        
        //print(UIDevice.current.ipAddress())
        let completeToken = "Bearer "+data.data.accessToken
        //We are storing this accestoken here teporarily, Will store access token 
        UserDefaults.saveToUserDefault(completeToken as AnyObject, key: AppConstants.UserDefaultKeyForAccessToken)
        UserDefaults.saveToUserDefault(self.emailTextField.text! as AnyObject, key: AppConstants.UserDefaultKeyForEmail)
        
        // save password entered to KeyChain //remove once client confirm
//        if KeychainWrapper.standard.set(self.confirmPassTextField.text!, forKey: AppConstants.KeyChainKeyForPassword){
//            print("Password Saved to Keychain")
//        }
       // let emptyAlDoc:SignupFlowAlDoc = SignupFlowAlDoc.init(documentValue: "", documentType: "")
        let emptyDoc:SignupFlowDocument = SignupFlowDocument.init(entityScope: "Arts & Entertainment", email: "", phoneNumber: "", ip: "127.0.0.1", name: "Test", entityType: "M", day: 0, month: 0, year: 0, desiredScope: "SEND|RECEIVE|TIER|1", docsKey: "GOVT_ID_ONLY", virtualDocs: [], physicalDocs: [])
        let address:SignupFlowAddress = SignupFlowAddress.init(street: "", city: "", state: "", zip: "",countty:"")
        let signupFlowData:SignupFlowData = SignupFlowData.init(userID: data.data.id, userIP: "127.0.0.1", email: data.data.email, university: "", passport: "", address: address, phoneNumbers: [], legalNames: [], password: self.confirmPassTextField.text!, documents: emptyDoc, suppID: "122eddfgbeafrfvbbb", cipTag: 2)
       
        // move to next step of Sign Up
        self.moveToSignupStepSecond(data: signupFlowData)
        
    }
    
    func moveToSignupStepSecond(data:SignupFlowData) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CreateAccountV2ViewController") as! CreateAccountV2ViewController
        vc.signupFlowData=data
        self.navigationController?.pushViewController(vc, animated: false)
    }

}
