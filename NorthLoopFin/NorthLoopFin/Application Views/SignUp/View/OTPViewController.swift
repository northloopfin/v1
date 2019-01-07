//
//  OTPViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 20/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class OTPViewController: BaseViewController {

    @IBOutlet weak var otpField1: UITextField!
    @IBOutlet weak var otpField2: UITextField!
    @IBOutlet weak var otpField3: UITextField!
    @IBOutlet weak var otpField4: UITextField!
    @IBOutlet weak var doneBtn: UIButton!

    var presenter:PhoneVerificationCheckPresenter!
    var sendPresenter:PhoneVerificationStartPresenter!

    @IBAction func resendOTPClicked(_ sender: Any) {
        self.callPhoneVerificationAPI()
    }
    //Call Phone Verification Service Start
    func callPhoneVerificationAPI(){
        sendPresenter.sendPhoneVerificationRequest()
    }
    @IBAction func doneClicked(_ sender: Any) {
        let OTPString = self.otpField1.text!+self.otpField2.text!+self.otpField3.text!+self.otpField4.text!
        self.presenter.sendPhoneVerificationCheckRequest(code: OTPString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTextFieldUI()
        self.setupRightNavigationBar()
        self.doneBtn.isEnabled = false
        self.presenter = PhoneVerificationCheckPresenter.init(delegate: self)
        self.sendPresenter = PhoneVerificationStartPresenter.init(delegate: self)
    }
    
    func setupRightNavigationBar(){
        let leftBarItem = UIBarButtonItem()
        leftBarItem.style = UIBarButtonItem.Style.plain
        leftBarItem.target = self
        leftBarItem.image = UIImage(named: "Back")?.withRenderingMode(.alwaysOriginal)
        leftBarItem.action = #selector(self.goBack)
        navigationItem.leftBarButtonItem = leftBarItem
    }
    //Method to go back to previous screen
    @objc func goBack(){
        self.navigationController?.popViewController(animated: false)
    }
    
    func updateTextFieldUI(){
        //Set action for each OTP Text Input
        otpField1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpField2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpField3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otpField4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
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
                checkForEmptyField()
                otpField4.resignFirstResponder()
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
                otpField4.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            
        }
    }
    
    //Check for empty OTP Field
    func checkForEmptyField(){
        if (!(self.otpField1.text?.isEmpty)! && !(self.otpField2.text?.isEmpty)! && !(self.otpField3.text?.isEmpty)! && !(self.otpField4.text?.isEmpty)!){
            self.activateNext()
        }
    }
    
    // Will activate net button so that user can move to next screen
    func activateNext(){
        self.doneBtn.backgroundColor = Colors.Zorba161149133
        self.doneBtn.isEnabled=true
        
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
extension OTPViewController:PhoneVerificationDelegate{
    func didSentOTP(result: PhoneVerifyStart) {
        self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: result.message)
    }
    func didCheckOTP(result:PhoneVerifyCheck){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "ScanIDViewController") as! ScanIDViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
}
