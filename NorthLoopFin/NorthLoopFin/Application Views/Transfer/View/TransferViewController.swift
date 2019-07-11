//
//  TransferViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 11/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class TransferViewController: BaseViewController {
    @IBOutlet weak var bankAccountNumberTextfield: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var rountingNumberTextField: UITextField!

    @IBOutlet weak var saveBtn: UIButton!
    var presenter:LinkACHPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.presenter = LinkACHPresenter.init(delegate: self)
    }
    @IBAction func saveBtnClicked(_ sender: Any) {
        // Validate Form
        self.validateForm()
    }
    
    //Validate form here
    func validateForm(){
        if Validations.isValidRoutingNumber(routingNumber: self.rountingNumberTextField.text!){
            // Yes Valid
            self.presenter.sendLinkACRequest(nickname: self.nicknameTextField.text!, accountNo: self.bankAccountNumberTextfield.text!, rountingNo: self.rountingNumberTextField.text!)
        }else{
            // show error here
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.ROUTING_NUMBER_NOT_VALID.rawValue)
        }
    }
    //Prepare view to display
    func prepareView(){
        self.setNavigationBarTitle(title: "Transfer")
        self.setupRightNavigationBar()
        self.bankAccountNumberTextfield.textColor = Colors.DustyGray155155155
        self.rountingNumberTextField.textColor = Colors.DustyGray155155155
        self.nicknameTextField.textColor=Colors.DustyGray155155155
        self.bankAccountNumberTextfield.font=AppFonts.textBoxCalibri16
        self.rountingNumberTextField.font=AppFonts.textBoxCalibri16
        self.nicknameTextField.font=AppFonts.textBoxCalibri16
        self.saveBtn.titleLabel!.font=AppFonts.calibri15
        self.configureTextFields()
    }
    func configureTextFields(){
        self.bankAccountNumberTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.nicknameTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.bankAccountNumberTextfield.applyAttributesWithValues(placeholderText: "Bank Account No*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.nicknameTextField.applyAttributesWithValues(placeholderText: "Nickname*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.rountingNumberTextField.applyAttributesWithValues(placeholderText: "Rounting Number*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.bankAccountNumberTextfield.setLeftPaddingPoints(19)
        self.nicknameTextField.setLeftPaddingPoints(19)
        self.rountingNumberTextField.setLeftPaddingPoints(19)

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
        self.saveBtn.isEnabled=true
        self.saveBtn.backgroundColor = Colors.PurpleColor17673149
    }
    
    func inactivateDoneBtn(){
        self.saveBtn.isEnabled=false
        self.saveBtn.backgroundColor = Colors.Alto224224224
    }
}
//MARK: UITextFiled Delegates
extension TransferViewController:UITextFieldDelegate{
    fileprivate func checkMandatoryFields() {
        if (!(self.bankAccountNumberTextfield.text?.isEmpty)! && !(self.nicknameTextField.text?.isEmpty)!) && !((self.rountingNumberTextField.text?.isEmpty)!){
            
            self.changeApperanceOfDone()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        checkMandatoryFields()
    }
}

extension TransferViewController:LinkACHDelegates{
    func didSentLinkACH() {
        self.navigationController?.popViewController(animated: false)
    }
}
