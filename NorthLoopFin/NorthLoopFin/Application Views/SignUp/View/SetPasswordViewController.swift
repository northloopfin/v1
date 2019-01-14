//
//  SetPasswordViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class SetPasswordViewController: BaseViewController {
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    //@IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!    
    @IBOutlet weak var termsPrivacyLbl: LabelWithLetterSpace!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.doneBtn.isEnabled=false
        self.updateTextFieldUI()
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
    
    //Action called when done button clicked
    @IBAction func doneClicked(_ sender: Any) {
       // if(Validations.isValidEmail(email: self.emailTextField.text ?? "")){
            if (Validations.isValidPassword(password: self.passwordTextField.text ?? "")){
                if(Validations.matchTwoStrings(string1: self.passwordTextField.text!, string2: self.confirmPasswordTextField.text!)){
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "VerifyAddressViewController") as! VerifyAddressViewController
                    self.navigationController?.pushViewController(transactionDetailController, animated: false)
                }else{
                    //error for unmatched passwords
                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PASSWORD_DONOT_MATCH.rawValue)
                }
            }else{
                //error for invalid password
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PASSWORD_NOT_VALID.rawValue)
            }
        //}//else{
          //  self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.EMAIL_NOT_VALID.rawValue)
//}
    }
    
    //Change appearance of TextFields
    func updateTextFieldUI(){
        self.passwordTextField.isSecureTextEntry=true
        self.confirmPasswordTextField.isSecureTextEntry=true
        
        self.passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.confirmPasswordTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
      //  self.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)

        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.passwordTextField.applyAttributesWithValues(placeholderText: "Password *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.confirmPasswordTextField.applyAttributesWithValues(placeholderText: "Confirm Password *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        //self.emailTextField.applyAttributesWithValues(placeholderText: "Email *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.passwordTextField.setLeftPaddingPoints(19)
        self.confirmPasswordTextField.setLeftPaddingPoints(19)
        //self.emailTextField.setLeftPaddingPoints(19)

    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.inactivateDoneBtn()
        }
    }
    //change appearance of done button
    func changeApperanceOfDone(){
        self.doneBtn.isEnabled=true
        self.doneBtn.backgroundColor = Colors.Zorba161149133
    }
    
    func inactivateDoneBtn(){
        self.doneBtn.isEnabled=false
        self.doneBtn.backgroundColor = Colors.Alto224224224
    }
}

//MARK: UITextFiled Delegates
extension SetPasswordViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (!(self.passwordTextField.text?.isEmpty)! && !(self.confirmPasswordTextField.text?.isEmpty)!)// && !(self.emailTextField.text?.isEmpty)! )
            {
            
            self.changeApperanceOfDone()
        }
    }
}
