//
//  ForgetPasswordViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 08/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
//import Firebase

class ForgetPasswordViewController: BaseViewController {
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var sendLinkBtn: CommonButton!
    var resetPresenter:ResetPasswordPresenter!

    
    @IBAction func sendLinkBtnClicked(_ sender: Any) {
      self.resetPresenter.sendResetPasswordRequesy(username: self.emailTextfield.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetPresenter = ResetPasswordPresenter.init(delegate: self)
        self.prepareView()
    }
    func prepareView(){
        self.sendLinkBtn.isEnabled=false
        self.setNavigationBarTitle(title: "Forgot Password")
        self.setupRightNavigationBar()
        self.messageLbl.textColor = Colors.MainTitleColor
        self.emailTextfield.textColor = Colors.DustyGray155155155
       
       self.messageLbl.font=AppFonts.calibriBold16
        self.emailTextfield.font=AppFonts.textBoxCalibri16
        self.sendLinkBtn.titleLabel!.font=AppFonts.calibri15
        self.configureTextFields()
    }
    
    func configureTextFields(){
        self.emailTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.emailTextfield.applyAttributesWithValues(placeholderText: "Email*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        
        self.emailTextfield.setLeftPaddingPoints(19)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.inactivateDoneBtn()
        }else{
            checkMandatoryFields()
        }
    }
    //change appearance of done button
    func changeApperanceOfDone(){
        self.sendLinkBtn.isEnabled=true
    }
    
    func inactivateDoneBtn(){
        self.sendLinkBtn.isEnabled=false
    }
}

extension ForgetPasswordViewController:UITextFieldDelegate{
    fileprivate func checkMandatoryFields() {
        if (!(self.emailTextfield.text?.isEmpty)!)
        {
            
            self.changeApperanceOfDone()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        checkMandatoryFields()
    }
}

extension ForgetPasswordViewController: ResetPasswordDelegate{
    func didSentResetPasswordRequest(){
        self.showAlert(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.RESET_EMAIL_SENT.rawValue)
    }
}

