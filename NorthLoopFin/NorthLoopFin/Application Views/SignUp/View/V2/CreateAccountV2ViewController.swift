//
//  CreateAccountV2ViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 22/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import Firebase
import DropDown

class CreateAccountV2ViewController: BaseViewController {

    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var SSNTextField: UITextField!
    @IBOutlet weak var CitizenShipTextField: UITextField!
    @IBOutlet weak var nextBtn: CommonButton!
   // @IBOutlet weak var loginLbl: UIButtonWithSpacing!
    //@IBOutlet weak var alreadyHaveaccountLbl: LabelWithLetterSpace!
    
    let dropDown = DropDown()
    let countryWithCode = AppUtility.getCountryList()
    
    var signupFlowData:SignupFlowData! = nil
    //Will remove this once Sign up completes
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
    
    @IBAction func countryExceptionClicked(_ sender: Any) {
        self.openCountryExceptionLink()
    }
    //Validate form for empty text , valid email, valid phone
    func validateForm(){
        if (Validations.isValidName(value: self.firstNameTextField.text!) && Validations.isValidName(value: self.lastNameTextField.text!)){
            if (self.phoneTextField.text!.isEmpty){
                self.updateSignUpFormData()
            }else {
                if (Validations.isValidPhone(phone: self.phoneTextField.text!)){
                    self.updateSignUpFormData()
                }else{
                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PHONE_NOT_VALID.rawValue)
                }
            }
        }
        else{
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.NAME_NOT_VALID.rawValue)
        }
    }
    
//    Methode will update signp form data model
    func updateSignUpFormData(){
        let legalName = self.firstNameTextField.text!+" "+self.lastNameTextField.text!
        var phoneNumber = self.phoneTextField.text!
        if (self.phoneTextField.text?.isEmpty)!{
            phoneNumber="5555555555"
        }else{
            phoneNumber = self.phoneTextField.text!
        }
        
        if let data = self.signupFlowData{
            data.legalNames=[legalName]
            data.phoneNumbers=[phoneNumber]
            if (!((self.SSNTextField.text?.isEmpty)!)){
                let ssnData:SignupFlowAlDoc = SignupFlowAlDoc.init(documentValue: self.SSNTextField.text!, documentType: "SSN")
                let documents:SignupFlowDocument=self.signupFlowData.documents
                documents.virtualDocs=[ssnData]
                data.documents=documents
                
            }
            self.moveToSignupStepThree(withData: self.signupFlowData)
        }
    }
    
    func updateUserData(_ firstName:String, _ lastName:String, _ phone:String){
        firebaseManager.updateUserWithData(firstName: firstName, lastName: lastName, phone: phone)
        
    }
    
    //Call Phone Verification Service
    func callPhoneVerificationAPI(){
        presenter.sendPhoneVerificationRequest()
    }
    func moveToSignupStepThree(withData:SignupFlowData){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ScanIDNewViewController") as! ScanIDNewViewController
        vc.signupData=withData
        self.navigationController?.pushViewController(vc, animated: false)
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
        
        self.CitizenShipTextField.inputView = UIView.init(frame: CGRect.zero)
        self.CitizenShipTextField.inputAccessoryView = UIView.init(frame: CGRect.zero)
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
            //self.phoneTextField.text = info.phone
            if info.otp1 != "" {
                //self.phoneTextField.isUserInteractionEnabled=false
            }
        }
    }
    
    /// Prepare view by setting color and fonts to view components
    func prepareView(){
        
        dropDown.anchorView = self.CitizenShipTextField
        dropDown.dataSource = AppUtility.getCountriesOnly()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.CitizenShipTextField.text=item
            self.dropDown.hide()
            self.checkForMandatoryFields()

        }
        //Set text color to view components
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.firstNameTextField.textColor = Colors.DustyGray155155155
        self.lastNameTextField.textColor = Colors.DustyGray155155155
        self.phoneTextField.textColor = Colors.DustyGray155155155
        self.SSNTextField.textColor = Colors.DustyGray155155155
        self.CitizenShipTextField.textColor = Colors.DustyGray155155155

        //self.alreadyHaveaccountLbl.textColor = Colors.Tundora747474
        //self.loginLbl.titleLabel!.textColor = Colors.NeonCarrot25414966
        
        // Set Font to view components
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.firstNameTextField.font = AppFonts.textBoxCalibri16
        self.lastNameTextField.font = AppFonts.textBoxCalibri16
        self.phoneTextField.font = AppFonts.textBoxCalibri16
        self.SSNTextField.font = AppFonts.textBoxCalibri16
        self.CitizenShipTextField.font = AppFonts.textBoxCalibri16
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
       // self.alreadyHaveaccountLbl.font = AppFonts.calibri15
        //self.loginLbl.titleLabel!.font = AppFonts.calibriBold15
    }
    
    func updateTextFieldUI(){
        self.firstNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.lastNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.SSNTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.phoneTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.CitizenShipTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.firstNameTextField.applyAttributesWithValues(placeholderText: "First Name*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.lastNameTextField.applyAttributesWithValues(placeholderText: "Last Name*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.SSNTextField.applyAttributesWithValues(placeholderText: "SSN (Optional)", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.phoneTextField.applyAttributesWithValues(placeholderText: "Phone No (Optional)", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.CitizenShipTextField.applyAttributesWithValues(placeholderText: "Citizenship", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.firstNameTextField.setLeftPaddingPoints(19)
        self.lastNameTextField.setLeftPaddingPoints(19)
        self.phoneTextField.setLeftPaddingPoints(19)
        self.SSNTextField.setLeftPaddingPoints(19)
        self.CitizenShipTextField.setLeftPaddingPoints(19)

    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.nextBtn.isEnabled=false
        }
    }
    
    func openCountryExceptionLink(){
        let urlString:String = AppConstants.CountryExceptionURL
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
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
        self.checkForMandatoryFields()
    }
    
    // Methode will check for mandatory fields and perform accordingly
    func checkForMandatoryFields(){
        if (!(self.firstNameTextField.text?.isEmpty)! && !(self.lastNameTextField.text?.isEmpty)! && !(self.CitizenShipTextField.text?.isEmpty)!)
        {
            self.nextBtn.isEnabled=true
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.CitizenShipTextField
        {
            //IQKeyboardManager.shared.resignFirstResponder()
            
            self.dropDown.show()
            return false
        }
        else
        {
            return true
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


