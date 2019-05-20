//
//  SignUpStepFirst.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 16/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


class SignUpStepFirst: BaseViewController {
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var paswwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var loginLbl: UIButtonWithSpacing!
    @IBOutlet weak var alreadyHaveaccountLbl: LabelWithLetterSpace!
    var presenter: SignupAuthPresenter!

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
        print(UIDeviceHelper.getIP())

        self.prepareView()
        self.nextBtn.isEnabled=false
        self.setupRightNavigationBar()
        self.updateTextFieldUI()
        self.presenter = SignupAuthPresenter.init(delegate:self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /// Prepare view by setting color and fonts to view components
    func prepareView(){
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
        }
    }
}

extension SignUpStepFirst:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (!(self.paswwordTextField.text?.isEmpty)! && !(self.confirmPassTextField.text?.isEmpty)! && !(self.emailTextField.text?.isEmpty)!
            )
            //(self.emailTextField.text?.isEmpty)!)
        {
            self.nextBtn.isEnabled=true
        }
    }
}

extension SignUpStepFirst:SignupAuthDelegate{
     func didSignrdUPAuth(data:SignupAuth){
        
        //print(UIDevice.current.ipAddress())
        let completeToken = "Bearer "+data.data.accessToken
        //We are storing this accestoken here teporarily, Will store access token 
        UserDefaults.saveToUserDefault(completeToken as AnyObject, key: AppConstants.UserDefaultKeyForAccessToken)
        let emptyAlDoc:SignupFlowAlDoc = SignupFlowAlDoc.init(documentValue: "", documentType: "")
        let emptyDoc:SignupFlowDocument = SignupFlowDocument.init(entityScope: "", email: "", phoneNumber: "", ip: "127.0.0.1", name: "", entityType: "", day: 0, month: 0, year: 0, desiredScope: "", docsKey: "", virtualDocs: [emptyAlDoc], physicalDocs: [emptyAlDoc])
        let address:SignupFlowAddress = SignupFlowAddress.init(street: "", houseNo: "", city: "", state: "", zip: "")
        let signupFlowData:SignupFlowData = SignupFlowData.init(userID: data.data.id, userIP: "127.0.0.1", email: data.data.email, university: "", passport: "", address: address, phoneNumbers: [], legalNames: [], password: self.confirmPassTextField.text!, documents: emptyDoc, suppID: "", cipTag: 0)
       
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
