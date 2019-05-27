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
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var rountingNumberTextField: UITextField!

    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    @IBAction func saveBtnClicked(_ sender: Any) {
        
    }
    func prepareView(){
        self.setNavigationBarTitle(title: "Transfer")
        self.setupRightNavigationBar()
        self.bankAccountNumberTextfield.textColor = Colors.DustyGray155155155
        self.rountingNumberTextField.textColor = Colors.DustyGray155155155
        self.amountTextfield.textColor=Colors.DustyGray155155155
        self.bankAccountNumberTextfield.font=AppFonts.textBoxCalibri16
        self.rountingNumberTextField.font=AppFonts.textBoxCalibri16
        self.amountTextfield.font=AppFonts.textBoxCalibri16
        self.saveBtn.titleLabel!.font=AppFonts.calibri15
        self.configureTextFields()
    }
    func configureTextFields(){
        self.bankAccountNumberTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.amountTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.bankAccountNumberTextfield.applyAttributesWithValues(placeholderText: "Bank Account No*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.amountTextfield.applyAttributesWithValues(placeholderText: "Amount*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.rountingNumberTextField.applyAttributesWithValues(placeholderText: "Rounting Number*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.bankAccountNumberTextfield.setLeftPaddingPoints(19)
        self.amountTextfield.setLeftPaddingPoints(19)
        self.rountingNumberTextField.setLeftPaddingPoints(19)

    }
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.inactivateDoneBtn()
        }
    }
    //change appearance of done button
    func changeApperanceOfDone(){
        self.saveBtn.isEnabled=true
        self.saveBtn.backgroundColor = Colors.Zorba161149133
    }
    
    func inactivateDoneBtn(){
        self.saveBtn.isEnabled=false
        self.saveBtn.backgroundColor = Colors.Alto224224224
    }
}
//MARK: UITextFiled Delegates
extension TransferViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (!(self.bankAccountNumberTextfield.text?.isEmpty)! && !(self.amountTextfield.text?.isEmpty)!) && !((self.rountingNumberTextField.text?.isEmpty)!){
            
            self.changeApperanceOfDone()
        }
    }
}
