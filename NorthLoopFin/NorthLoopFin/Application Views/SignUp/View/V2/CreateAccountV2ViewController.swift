//
//  CreateAccountV2ViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 22/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import DropDown
import RealmSwift

class CreateAccountV2ViewController: BaseViewController {

    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var SSNTextField: UITextField!
    @IBOutlet weak var CitizenShipTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var customProgressView: ProgressView!

    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var ssnInfoBtn: UIButton!
    
    let countryPicker = CountryPickerView.instanceFromNib()
    lazy var basicInfo: Results<BasicInfo> = RealmHelper.retrieveBasicInfo()
    //@IBOutlet weak var loginLbl: UIButtonWithSpacing!
    //@IBOutlet weak var alreadyHaveaccountLbl: LabelWithLetterSpace!
    
    let citizenShipDropDown = DropDown()
    let countryWithCode = AppUtility.getCountryList()
    var selectedCountry:Country!
    
    var signupFlowData:SignupFlowData! = nil
    //Will remove this once Sign up completes
    var presenter:PhoneVerificationStartPresenter!
    
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
    
    @IBAction func ssnInfoBtnClicked(_ sender: Any) {
        //move to info screen
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SSNInfoViewController") as! SSNInfoViewController
        self.present(vc, animated: false, completion: nil)
    }
    //Validate form for empty text , valid email, valid phone
    func validateForm(){
        self.validateNames()
    }
    
    func validatePhoneNumber(){
        if !((self.phoneTextField.text?.isEmpty)!){
            //its not empty so validate phone
            if Validations.isValidPhone(phone: self.phoneTextField.text ?? ""){
                // yes valid
                self.updateSignUpFormData()
            }else{
                //show error
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PHONE_NOT_VALID.rawValue)
                return
            }
        }else{
            self.updateSignUpFormData()
        }
    }
    
    func validateSSN(){
        if !((self.SSNTextField.text?.isEmpty)!){
            //its not empty so validate phone
            if Validations.isValidSSN(ssn: self.SSNTextField.text ?? ""){
                // yes valid
                self.validatePhoneNumber()
            }else{
                //show error
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.SSN_NOT_VALID.rawValue)
                return
            }
        }else{
            self.validatePhoneNumber()
        }
    }
    
    func validateNames(){
        if (Validations.isValidName(value: self.firstNameTextField.text!) && Validations.isValidName(value: self.lastNameTextField.text!)){
            self.validateSSN()
            
        }else{
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.NAME_NOT_VALID.rawValue)
            return
        }
    }
    
//    Methode will update signp form data model
    func updateSignUpFormData(){
        self.saveDataToRealm()
        
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
        self.countryPicker.delegate = self
        self.presenter = PhoneVerificationStartPresenter.init(delegate: self)
        self.nextBtn.isEnabled=false
        updateTextFieldUI()
        self.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Fetch from Realm if any
       // self.fetchDatafromRealmIfAny()
    }
    
    func fetchDatafromRealmIfAny(){
        if self.basicInfo.count > 0{
            self.nextBtn.isEnabled=true
            let info = self.basicInfo.first!
            self.firstNameTextField.text = info.firstname
            self.lastNameTextField.text = info.lastname
            self.SSNTextField.text = info.ssn
            self.phoneTextField.text = info.phone
            self.CitizenShipTextField.text = info.citizenShip
            //search for citizenship in the list of countries
            let selectedCountryArr = self.countryWithCode.filter { $0.name == info.citizenShip}
            self.selectedCountry = selectedCountryArr[0]
        }
    }
    
    /// Prepare view by setting color and fonts to view components
    func prepareView(){
        self.customProgressView.progressView.setProgress(0.17*2, animated: true)
        
        self.CitizenShipTextField.inputView = UIView.init(frame: CGRect.zero)
        self.CitizenShipTextField.inputAccessoryView = UIView.init(frame: CGRect.zero)
        self.CitizenShipTextField.setRightIcon(UIImage.init(named: "chevron")!)
        
        self.countryCodeTextField.inputView = UIView.init(frame: CGRect.zero)
        self.countryCodeTextField.inputAccessoryView = UIView.init(frame: CGRect.zero)
        self.countryCodeTextField.setRightIcon(UIImage.init(named: "chevron")!)
        //Drop Down for Country Code
//        self.countryCodeDropDown.anchorView = self.countryCodeTextField
//        self.countryCodeDropDown.dataSource = AppUtility.getCountryInitialOnly()
//        self.countryCodeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            self.countryCodeTextField.text=AppUtility.getCountryOfInitial(initial: item)
//            self.countryCodeDropDown.hide()
//            self.checkForMandatoryFields()
//        }
        //Drop Down for citizenship
        citizenShipDropDown.anchorView = self.CitizenShipTextField
        citizenShipDropDown.dataSource = AppUtility.getCountriesOnly()
        citizenShipDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.CitizenShipTextField.text=item
            self.selectedCountry = self.countryWithCode[index]
            self.citizenShipDropDown.hide()
            self.checkForMandatoryFields()

        }
        //Set text color to view components
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.firstNameTextField.textColor = Colors.DustyGray155155155
        self.lastNameTextField.textColor = Colors.DustyGray155155155
        self.phoneTextField.textColor = Colors.DustyGray155155155
        self.SSNTextField.textColor = Colors.DustyGray155155155
        self.CitizenShipTextField.textColor = Colors.DustyGray155155155


     //   self.alreadyHaveaccountLbl.textColor = Colors.Tundora747474
     //   self.loginLbl.titleLabel!.textColor = Colors.NeonCarrot25414966

        
        // Set Font to view components
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.firstNameTextField.font = AppFonts.textBoxCalibri16
        self.lastNameTextField.font = AppFonts.textBoxCalibri16
        self.phoneTextField.font = AppFonts.textBoxCalibri16
        self.SSNTextField.font = AppFonts.textBoxCalibri16
        self.CitizenShipTextField.font = AppFonts.textBoxCalibri16
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
        //self.alreadyHaveaccountLbl.font = AppFonts.calibri15
       // self.loginLbl.titleLabel!.font = AppFonts.calibriBold15
    }

    func updateTextFieldUI(){
        
        self.firstNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.lastNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.SSNTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.phoneTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.CitizenShipTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.countryCodeTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.firstNameTextField.applyAttributesWithValues(placeholderText: "First Name*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.lastNameTextField.applyAttributesWithValues(placeholderText: "Last Name*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.SSNTextField.applyAttributesWithValues(placeholderText: "SSN (Optional)", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.phoneTextField.applyAttributesWithValues(placeholderText: "Phone No", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.CitizenShipTextField.applyAttributesWithValues(placeholderText: "Citizenship*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.countryCodeTextField.applyAttributesWithValues(placeholderText: "Code", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.firstNameTextField.setLeftPaddingPoints(19)
        self.lastNameTextField.setLeftPaddingPoints(19)
        self.phoneTextField.setLeftPaddingPoints(19)
        self.SSNTextField.setLeftPaddingPoints(19)
        self.CitizenShipTextField.setLeftPaddingPoints(19)
        self.countryCodeTextField.setLeftPaddingPoints(19)

    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.nextBtn.isEnabled=false
        }else{
            self.checkForMandatoryFields()
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
    
   //will save this screen data to DB
    func saveDataToRealm(){
        let basicInfo:BasicInfo=BasicInfo()
        basicInfo.email=UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String
        basicInfo.firstname=self.firstNameTextField.text ?? ""
        basicInfo.lastname=self.lastNameTextField.text ?? ""
        basicInfo.ssn=self.SSNTextField.text ?? ""
        basicInfo.phone=self.phoneTextField.text ?? ""
        basicInfo.citizenShip=self.CitizenShipTextField.text ?? ""
        RealmHelper.addBasicInfo(info: basicInfo)
        
        let legalName = self.firstNameTextField.text!+" "+self.lastNameTextField.text!
        
        let phoneNumber = self.countryCodeTextField.text!+self.phoneTextField.text!
        
        if let data = self.signupFlowData{
            data.legalNames=[legalName]
            data.phoneNumbers=[phoneNumber]
            let address : SignupFlowAddress = data.address
            address.country = self.selectedCountry.code
            if (!((self.SSNTextField.text?.isEmpty)!)){
                let ssnData:SignupFlowAlDoc = SignupFlowAlDoc.init(documentValue: self.SSNTextField.text!, documentType: "SSN")
                let documents:SignupFlowDocument=self.signupFlowData.documents
                documents.virtualDocs=[ssnData]
                data.documents=documents
                data.cipTag=3 // changed from 1->3 as per client requirement
            }else{
                let documents:SignupFlowDocument=self.signupFlowData.documents
                documents.virtualDocs=[]
                data.documents=documents
                data.cipTag=2 // changed from 1->3 as per client requirement
            }
            self.moveToSignupStepThree(withData: self.signupFlowData)
        }
    }
}

extension CreateAccountV2ViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.checkForMandatoryFields()
    }
    
    // Methode will check for mandatory fields and perform accordingly
    func checkForMandatoryFields(){
        if (!(self.firstNameTextField.text?.isEmpty)! && !(self.lastNameTextField.text?.isEmpty)! && !(self.CitizenShipTextField.text?.isEmpty)! && !(self.phoneTextField.text?.isEmpty)! && !(self.countryCodeTextField.text?.isEmpty)! )
        {
            self.nextBtn.isEnabled=true
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.CitizenShipTextField
        {
            //IQKeyboardManager.shared.resignFirstResponder()
            
            self.citizenShipDropDown.show()
            return false
        }else if textField == self.countryCodeTextField{
            //self.countryCodeDropDown.show()
            self.countryPicker.show()
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

extension CreateAccountV2ViewController:CountryPickerViewDelegate {
    func countryPickerView(picker: CountryPickerView, didSelectCountry country: Country) {
        self.countryCodeTextField.text = country.dialCode
    }
    
    func countryPickerViewDidDismiss(picker: CountryPickerView) {
        
    }
}
