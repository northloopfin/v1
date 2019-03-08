//
//  CreateAccountV2ViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 22/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountV2ViewController: BaseViewController {

    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    // @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var loginLbl: UIButtonWithSpacing!
    @IBOutlet weak var alreadyHaveaccountLbl: LabelWithLetterSpace!
    var presenter:PhoneVerificationStartPresenter!
    var firebaseManager:FirebaseManager!
    
    @IBAction func loginClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    @IBAction func nextClicked(_ sender: Any) {
        validateForm()
    }
    
    @IBAction func internationalStudentClicked(_ sender: Any) {
        self.moveToIntenationalStudent()
    }
    //Validate form for empty text , valid email, valid phone
    func validateForm(){
        if (Validations.isValidName(value: self.firstNameTextField.text!) && Validations.isValidName(value: self.lastNameTextField.text!)){
            if (Validations.isValidPhone(phone: self.phoneTextField.text!)){
                //                        self.callPhoneVerificationAPI()
                //                        moveToOTPScreen()
                //self.addUserMetaData(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, phone: self.phoneTextField.text!)
                self.updateUserData(self.firstNameTextField.text!, self.lastNameTextField.text!, self.phoneTextField.text!)
            }else{
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PHONE_NOT_VALID.rawValue)                }
        }else{
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.NAME_NOT_VALID.rawValue)
        }
    }
    
    func updateUserData(_ firstName:String, _ lastName:String, _ phone:String){
        firebaseManager.updateUserWithData(firstName: firstName, lastName: lastName, phone: phone)
        
    }
    
    //Call Phone Verification Service
    func callPhoneVerificationAPI(){
        presenter.sendPhoneVerificationRequest()
    }
    
    //Move to OTP screen
    func moveToOTPScreen(){
        UserDefaults.saveToUserDefault(AppConstants.Screens.OTP.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    func moveToIntenationalStudent(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "InternationalStudentViewController") as! InternationalStudentViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = PhoneVerificationStartPresenter.init(delegate: self)
        self.firebaseManager = FirebaseManager.init(delegate: self)
        
        //self.inactivateNextBtn()
        self.nextBtn.isEnabled=false
        self.setupRightNavigationBar()
        updateTextFieldUI()
        self.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Fetch from Realm if any
        self.fetchDatafromRealmIfAny()
    }
    
    func fetchDatafromRealmIfAny(){
        let result = RealmHelper.retrieveBasicInfo()
        print(result)
        if result.count > 0{
            self.nextBtn.isEnabled=true
            let info = result.first!
            self.firstNameTextField.text = info.firstname
            self.lastNameTextField.text = info.lastname
            self.phoneTextField.text = info.phone
            if info.otp1 != "" {
                self.phoneTextField.isUserInteractionEnabled=false
            }
        }
    }
    
    /// Prepare view by setting color and fonts to view components
    func prepareView(){
        //Set text color to view components
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.firstNameTextField.textColor = Colors.DustyGray155155155
        self.lastNameTextField.textColor = Colors.DustyGray155155155
        self.phoneTextField.textColor = Colors.DustyGray155155155
        self.alreadyHaveaccountLbl.textColor = Colors.Tundora747474
        self.loginLbl.titleLabel!.textColor = Colors.NeonCarrot25414966
        
        // Set Font to view components
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.firstNameTextField.font = AppFonts.textBoxCalibri16
        self.lastNameTextField.font = AppFonts.textBoxCalibri16
        self.phoneTextField.font = AppFonts.textBoxCalibri16
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
        self.alreadyHaveaccountLbl.font = AppFonts.calibri15
        self.loginLbl.titleLabel!.font = AppFonts.calibriBold15
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
        
        self.firstNameTextField.applyAttributesWithValues(placeholderText: "First Name*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.lastNameTextField.applyAttributesWithValues(placeholderText: "Last Name*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        //self.emailTextField.applyAttributesWithValues(placeholderText: "Email *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.phoneTextField.applyAttributesWithValues(placeholderText: "Phone No*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.firstNameTextField.setLeftPaddingPoints(19)
        self.lastNameTextField.setLeftPaddingPoints(19)
        self.phoneTextField.setLeftPaddingPoints(19)
        //self.emailTextField.setLeftPaddingPoints(19)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.nextBtn.isEnabled=false
        }
    }
    
    //    func activateNextBtn(){
    //        self.nextBtn.isEnabled=true
    //        self.nextBtn.backgroundColor = Colors.Zorba161149133
    //    }
    //
    //    func inactivateNextBtn(){
    //        self.nextBtn.isEnabled=false
    //        self.nextBtn.backgroundColor = Colors.Alto224224224
    //    }
}

extension CreateAccountV2ViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (!(self.firstNameTextField.text?.isEmpty)! && !(self.lastNameTextField.text?.isEmpty)! && !(self.phoneTextField.text?.isEmpty)!)
            //(self.emailTextField.text?.isEmpty)!)
        {
            self.nextBtn.isEnabled=true
        }
    }
}
extension CreateAccountV2ViewController:PhoneVerificationDelegate{
    func didCheckOTP(result: PhoneVerifyCheck) {
        print("Check")
    }
    func didSentOTP(result:PhoneVerifyStart){
        //self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: result.message)
        self.moveToOTPScreen()
    }
}


extension CreateAccountV2ViewController:FirebaseDelegates{
    func didSendPasswordReset(error: NSError?) {
        
    }
    
    func didFirebaseDatabaseUpdated() {
        //save this screen data to Realm DB
        let info:BasicInfo = BasicInfo()
        info.firstname = self.firstNameTextField.text!
        info.lastname = self.lastNameTextField.text!
        info.phone = self.phoneTextField.text!
        let result = RealmHelper.retrieveBasicInfo()
        info.email = result.first!.email
        info.password = result.first!.password
        info.confirmPassword = result.first!.confirmPassword
        info.otp1 = result.first!.otp1
        info.otp2 = result.first!.otp2
        info.otp3 = result.first!.otp3
        info.otp4 = result.first!.otp4
        info.streetAddress = result.first!.streetAddress
        info.country = result.first!.country
        info.zip = result.first!.zip
        info.countryCode = result.first!.countryCode
        info.phoneSecondary = result.first!.phoneSecondary
        print(result)
        if result.count > 0{
            RealmHelper.updateNote(infoToBeUpdated: result.first!, newInfo: info)
        }
        if info.otp1 != ""{
            self.moveToOTPScreen()
        }else{
            self.callPhoneVerificationAPI()

        }

    }
    
    func didFirebaseUserCreated(authResult:AuthDataResult?,error:NSError?){
        
    }
    func didNameUpdated(error:NSError?){
        
    }
    func didLoggedIn(error:NSError?){
        
    }
    func didReadUserFromDatabase(error:NSError?, data:NSDictionary?){
        
    }
}
