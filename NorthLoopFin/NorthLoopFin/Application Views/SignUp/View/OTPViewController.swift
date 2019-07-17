//
//  OTPViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 20/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

protocol OTPControllerDelegates: BaseViewProtocol {
    func OTP_Verified()
}

class OTPViewController: BaseViewController {

    @IBOutlet weak var otpField1: UITextField!
    @IBOutlet weak var otpField2: UITextField!
    @IBOutlet weak var otpField3: UITextField!
    @IBOutlet weak var otpField4: UITextField!
    @IBOutlet weak var otpField6: UITextField!
    @IBOutlet weak var otpField5: UITextField!

    @IBOutlet weak var doneBtn: CommonButton!
    @IBOutlet weak var resendLbl: UILabel!
    @IBOutlet weak var sentToLbl: UILabel!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    public weak var delegate : OTPControllerDelegates?

    //Obselete now..remove once things get fix from backend
    //var presenter:PhoneVerificationCheckPresenter!
    //var sendPresenter:PhoneVerificationStartPresenter!

    var presenter:TwoFAVerifyPresenter!
    var requestPresenter:TwoFAPresenter!
    var resetPresenter:ResetPasswordPresenter!
    //These are used to know the mode of OTP verification
    var isPhoneSelectedForOTP:Bool = false
    var isEmailSelectedForOTP:Bool = false
    
    var screenWhichInitiatedOTP:AppConstants.Screens?
    
    @IBAction func resendOTPClicked(_ sender: Any) {
        self.requestPresenter.sendTwoFARequest(sendToAPI: true)
//        self.callPhoneVerificationAPI()
    }
    //Call Phone Verification Service Start
    func callPhoneVerificationAPI(){
        //sendPresenter.sendPhoneVerificationRequest()
    }
    @IBAction func doneClicked(_ sender: Any) {
        var OTPString = self.otpField1.text!+self.otpField2.text!+self.otpField3.text!+self.otpField4.text!+self.otpField5.text!
        OTPString = OTPString + self.otpField5.text!
        //call verify api here
        self.presenter.verifyTwoFARequest(sendToAPI: true, otp: OTPString)

//        if isPhoneSelectedForOTP{
//            self.presenter.verifyTwoFARequest(sendToAPI: true, otp: OTPString)
//        }
//        if (isEmailSelectedForOTP || self.screenWhichInitiatedOTP == AppConstants.Screens.CHANGEPHONE || self.screenWhichInitiatedOTP == AppConstants.Screens.ChangePASSWORD){
//            self.presenter.verifyTwoFARequest(sendToAPI: false, otp: OTPString)
//        }
        

//        let result = RealmHelper.retrieveBasicInfo()
//        let info:BasicInfo = result.first!
//        if info.otp1 != ""{
//            self.moveToScanIDScreen()
//
//        }else{
//            self.presenter.sendPhoneVerificationCheckRequest(code: OTPString)
//        }
        
        //self.moveToScanIDScreen()

    }
//    func updateRealmDB(){
//        let info:BasicInfo = BasicInfo()
//        info.otp1 = self.otpField1.text!
//        info.otp2 = self.otpField2.text!
//        info.otp3 = self.otpField3.text!
//        info.otp4 = self.otpField4.text!
//        let result = RealmHelper.retrieveBasicInfo()
//        print(result)
//        if result.count > 0{
//            RealmHelper.updateNote(infoToBeUpdated: result.first!, newInfo: info)
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.fetchDatafromRealmIfAny()
    }
    
    ///Fetch data from DB if any and show on UI
//    func fetchDatafromRealmIfAny(){
//        let result = RealmHelper.retrieveBasicInfo()
//        print(result)
//        if result.count > 0{
//            let info = result.first!
//            self.otpField1.text = info.otp1
//            self.otpField2.text = info.otp2
//            self.otpField3.text = info.otp3
//            self.otpField4.text = info.otp4
//            self.doneBtn.isEnabled=true
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTextFieldUI()
        self.setupRightNavigationBar()
        self.doneBtn.isEnabled = false
        self.presenter = TwoFAVerifyPresenter.init(delegate: self)
        self.requestPresenter = TwoFAPresenter.init(delegate: self)
        self.resetPresenter = ResetPasswordPresenter.init(delegate: self)
//        self.presenter = PhoneVerificationCheckPresenter.init(delegate: self)
//        self.sendPresenter = PhoneVerificationStartPresenter.init(delegate: self)
        self.prepareView()

    }
    
    /// Set text color and font to view components
    func prepareView(){
        //Set text color
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.sentToLbl.textColor = Colors.Cameo213186154
        self.otpField1.textColor = Colors.DustyGray155155155
        self.otpField2.textColor = Colors.DustyGray155155155
        self.otpField3.textColor = Colors.DustyGray155155155
        self.otpField4.textColor = Colors.DustyGray155155155
        self.otpField5.textColor = Colors.DustyGray155155155
        self.otpField6.textColor = Colors.DustyGray155155155
        self.resendLbl.textColor=Colors.Taupe776857
        
        //set font here
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.sentToLbl.font=AppFonts.btnTitleCalibri18
        self.otpField1.font = AppFonts.textBoxCalibri16
        self.otpField2.font = AppFonts.textBoxCalibri16
        self.otpField3.font = AppFonts.textBoxCalibri16
        self.otpField4.font = AppFonts.textBoxCalibri16
        self.otpField5.font = AppFonts.textBoxCalibri16
        self.otpField6.font = AppFonts.textBoxCalibri16
        self.resendLbl.font = AppFonts.calibriBold18
        self.doneBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
    }
    
    
    func updateTextFieldUI(){
        //Set action for each OTP Text Input
        otpField1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpField2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpField3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpField4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpField5.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpField6.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        //Define Style for OTP text input
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        //Apply style to OTP text input
        self.otpField1.applyAttributesWithValues(placeholderText: "", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
         self.otpField2.applyAttributesWithValues(placeholderText: "", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
         self.otpField3.applyAttributesWithValues(placeholderText: "", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.otpField4.applyAttributesWithValues(placeholderText: "", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.otpField5.applyAttributesWithValues(placeholderText: "", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.otpField6.applyAttributesWithValues(placeholderText: "", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
    }
    //Move Focus to next OTP text input when single OTP entered
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case otpField1:
                self.addShadow(view: otpField1)
                otpField2.becomeFirstResponder()
            case otpField2:
                self.addShadow(view: otpField2)
                otpField3.becomeFirstResponder()
            case otpField3:
                self.addShadow(view: otpField3)
                otpField4.becomeFirstResponder()
            case otpField4:
                self.addShadow(view: otpField4)
                otpField5.becomeFirstResponder()
            case otpField5:
                self.addShadow(view: otpField5)
                otpField6.becomeFirstResponder()
            case otpField6:
                self.addShadow(view: otpField6)
                checkForEmptyField()
                otpField6.resignFirstResponder()
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case otpField1:
                self.removeShadow(view: otpField1)
                otpField2.becomeFirstResponder()
            case otpField2:
                self.removeShadow(view: otpField2)
                otpField3.becomeFirstResponder()
            case otpField3:
                self.removeShadow(view: otpField3)
                otpField4.becomeFirstResponder()
            case otpField4:
                self.removeShadow(view: otpField4)
                otpField5.becomeFirstResponder()
            case otpField5:
                self.removeShadow(view: otpField5)
                otpField6.becomeFirstResponder()
            case otpField6:
                self.removeShadow(view: otpField6)
                otpField6.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            
        }
    }
    
    //Check for empty OTP Field
    func checkForEmptyField(){
        if (!(self.otpField1.text?.isEmpty)! && !(self.otpField2.text?.isEmpty)! && !(self.otpField3.text?.isEmpty)! && !(self.otpField4.text?.isEmpty)! && !(self.otpField5.text?.isEmpty)! && !(self.otpField6.text?.isEmpty)!){
            self.doneBtn.isEnabled=true
            
            
        }
    }
    
    func addShadow(view:UITextField){
        //set shadow to container view
        let shadowOffst = CGSize.init(width: 0, height: 26)
        let shadowOpacity = 0.15
        let shadowRadius = 30
        let shadowColor = Colors.Taupe776857
        view.layer.addShadowAndRoundedCorners(roundedCorner: 12.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }
    func removeShadow(view:UITextField){
        view.layer.removeShadow()
    }
}

extension OTPViewController:UITextFieldDelegate{
    
}
extension OTPViewController:TwoFADelegates{
    func didGetOTP() {
        
    }
}

extension OTPViewController:TwoFAVerifyDelegates{
    func didVerifiedOTP() {
        self.moveToRelevantScreen()
    }
    
    func moveToRelevantScreen(){
        switch self.screenWhichInitiatedOTP! {
        case AppConstants.Screens.SETPIN :
            self.moveToSetPinScreen()
        case AppConstants.Screens.CHANGEPHONE :
            self.moveToChangePhoneScreen()
        case AppConstants.Screens.CHANGEADDRESS :
            self.moveToChangeAddress()
        case AppConstants.Screens.ChangePASSWORD :
            // call reset password api
            if let currentUser = UserInformationUtility.sharedInstance.getCurrentUser(){
                self.resetPresenter.sendResetPasswordRequesy(username: currentUser.userEmail)
            }
        case AppConstants.Screens.HOME:
            delegate?.OTP_Verified()
            self.dismiss(animated: true) {
            }
        case AppConstants.Screens.CHAT :
            FSChatViewStyling.startTheChat(self.navigationController!, vc: self)
        default:
            break
        }
    }
    
    func moveToSetPinScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "NewPinViewController") as! NewPinViewController
    self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func moveToChangePhoneScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChangePhoneViewController") as! ChangePhoneViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func moveToChangeAddress(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyAddressViewController") as! VerifyAddressViewController
        vc.screenThatInitiatedThisFlow = self.screenWhichInitiatedOTP
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
extension OTPViewController: ResetPasswordDelegate{
    func didSentResetPasswordRequest(){
        self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.RESET_EMAIL_SENT.rawValue)
    }
}
