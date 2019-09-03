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
    @IBOutlet weak var termsAgreementLbl: LabelWithLetterSpace!
    @IBOutlet weak var cardDepositAgreementLbl: LabelWithLetterSpace!
    
    @IBOutlet weak var vwPasswordHint: UIView!
    @IBOutlet weak var termsPolicyCheckBox: CheckBox!
    @IBOutlet weak var depositCardCheckbox: CheckBox!

    @IBOutlet weak var lblHintMinCharacters: UILabel!
    @IBOutlet weak var lblHintSpecialCharacters: UILabel!
    @IBOutlet weak var lblHintNumber: UILabel!
    @IBOutlet weak var lblHintUppercase: UILabel!
    //var to store state of checkboxes
    var isTermsPolicyChecked:Bool=false
    var isDepositCardAgreementChecked:Bool=false
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func checkBoxvalueChanged(_ sender: Any) {
        let check = sender as! CheckBox
        if check.tag == 0{
            self.isTermsPolicyChecked = check.isChecked
        }else if check.tag == 1{
            self.isDepositCardAgreementChecked = check.isChecked
        }
        self.checkForMandatoryFields()
    }
    
    /// Prepare view by setting color and fonts to view components
    func prepareView(){
        //Underline text
        self.termsAgreementLbl.underLineText(fullText: self.termsAgreementLbl.text ?? "", underlinedText: "Terms of Service and Privacy Policy")
        self.cardDepositAgreementLbl.underlineMulyiplePartOfString(fullString: self.cardDepositAgreementLbl.text ?? "", underlineString1: "Deposit Agreement", underlineString2: "Cardholder Agreement")
        
        self.termsPolicyCheckBox.style = .tick
        self.depositCardCheckbox.style = .tick
        self.termsPolicyCheckBox.borderStyle = .roundedSquare(radius: 3)
        self.depositCardCheckbox.borderStyle = .roundedSquare(radius: 3)
        self.termsPolicyCheckBox.tag=0
        self.depositCardCheckbox.tag=1
        self.customProgressView.progressView.setProgress(0.17*1, animated: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(tap:)))
        let cardDepositTap = UITapGestureRecognizer(target: self, action: #selector(cardTapLabel(tap:)))
        self.termsAgreementLbl.addGestureRecognizer(tap)
        self.termsAgreementLbl.isUserInteractionEnabled = true
        self.cardDepositAgreementLbl.addGestureRecognizer(cardDepositTap)
        self.cardDepositAgreementLbl.isUserInteractionEnabled = true
        //Set text color to view components
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        
        // Set Font to view components
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
    }
    
    @objc func tapLabel(tap: UITapGestureRecognizer) {
        
        if let rangeForDeposit = self.termsAgreementLbl.text?.range(of: "Terms of Service and Privacy Policy")?.nsRange{
            if tap.didTapAttributedTextInLabel(label: self.termsAgreementLbl, inRange: rangeForDeposit) {
                            // Substring tapped
                //open deposit agreement
                self.navigateToAgreement(agreementType: AppConstants.AGREEMENTTYPE.ACCOUNT)
            }
        }
    }
    
    @objc func cardTapLabel(tap: UITapGestureRecognizer) {
        
        if let rangeForAccount = self.cardDepositAgreementLbl.text?.range(of: "Deposit Agreement")?.nsRange{
            if tap.didTapAttributedTextInLabel(label: self.cardDepositAgreementLbl, inRange: rangeForAccount) {
                // Substring tapped
                self.navigateToAgreement(agreementType: AppConstants.AGREEMENTTYPE.DEPOSIT)
            }
        }
        if let rangeForCard = self.cardDepositAgreementLbl.text?.range(of: "Cardholder Agreement")?.nsRange{
            if tap.didTapAttributedTextInLabel(label: self.cardDepositAgreementLbl, inRange: rangeForCard) {
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
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.nextBtn.isEnabled=false
        }else{
            self.checkForMandatoryFields()
        }
        
        self.vwPasswordHint.isHidden = textField != paswwordTextField
        
        if textField == paswwordTextField {
            lblHintMinCharacters.textColor = textField.text!.count > 7 ? Colors.AmountGreen241770 : Colors.PurpleColor17673149
            lblHintUppercase.textColor = isPasswordUpperCase() ? Colors.AmountGreen241770 : Colors.PurpleColor17673149
            lblHintNumber.textColor = isPasswordNumber() ? Colors.AmountGreen241770 : Colors.PurpleColor17673149
            lblHintSpecialCharacters.textColor = isPasswordSpecialChar() ? Colors.AmountGreen241770 : Colors.PurpleColor17673149
        }
    }
    
    func isPasswordUpperCase() -> Bool{
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        return texttest.evaluate(with: paswwordTextField.text)
    }

    func isPasswordSpecialChar() -> Bool{
        let capitalLetterRegEx  = ".*[!&%$@()/]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        return texttest.evaluate(with: paswwordTextField.text)
    }

    func isPasswordNumber() -> Bool{
        let capitalLetterRegEx  = ".*[0-9]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        return texttest.evaluate(with: paswwordTextField.text)
    }

    func checkForMandatoryFields(){
        if (!(self.paswwordTextField.text?.isEmpty)! && !(self.confirmPassTextField.text?.isEmpty)! && !(self.emailTextField.text?.isEmpty)! && self.isTermsPolicyChecked && self.isDepositCardAgreementChecked
            )
            //(self.emailTextField.text?.isEmpty)!)
        {
            self.nextBtn.isEnabled=true
        }else{
            self.nextBtn.isEnabled=false
        }
    }
    
}

extension SignUpStepFirst:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.checkForMandatoryFields()
        vwPasswordHint.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        vwPasswordHint.isHidden = true
        return true
    }
}

extension SignUpStepFirst:SignupAuthDelegate{
     func didSignrdUPAuth(data:SignupAuth){
        
        //print(UIDevice.current.ipAddress())
        let completeToken = "Bearer "+data.data.accessToken
        //We are storing this accestoken here teporarily, Will store access token 
        UserDefaults.saveToUserDefault(completeToken as AnyObject, key: AppConstants.UserDefaultKeyForAccessToken)
        UserDefaults.saveToUserDefault(self.emailTextField.text! as AnyObject, key: AppConstants.UserDefaultKeyForEmail)
        

        let emptyDoc:SignupFlowDocument = SignupFlowDocument.init(entityScope: "Arts & Entertainment", email: "", phoneNumber: "", ip: UIDevice.current.ipAddress(), name: "Test", entityType: "M", day: 0, month: 0, year: 0, desiredScope: "SEND|RECEIVE|TIER|1", docsKey: "GOVT_ID_ONLY", virtualDocs: [], physicalDocs: [])
        let address:SignupFlowAddress = SignupFlowAddress.init(street: "", city: "", state: "", zip: "",countty:"",houseNumber:"")

        let signupflowData:SignupFlowData = SignupFlowData.init(userID: data.data.id, userIP: UIDevice.current.ipAddress(), email: data.data.email, university: "", passport: "", address: address, phoneNumbers: [], legalNames: [], password: self.confirmPassTextField.text!, documents: emptyDoc, suppID: "Test", cipTag: 2, arrivalDate: "", deviceType: "IOS")
       
        // move to next step of Sign Up
        self.moveToSignupStepSecond(data: signupflowData)
        
    }
    
    func moveToSignupStepSecond(data:SignupFlowData) {
        let vc = self.getControllerWithIdentifier("PersonalDetailViewController") as! PersonalDetailViewController
        vc.signupFlowData=data
        self.navigationController?.pushViewController(vc, animated: false)
    }

}
