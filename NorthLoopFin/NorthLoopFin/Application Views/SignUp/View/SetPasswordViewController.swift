//
//  SetPasswordViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class SetPasswordViewController: UIViewController {
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!    
    @IBOutlet weak var termsPrivacyLbl: LabelWithLetterSpace!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doneBtn.isEnabled=false
        self.updateTextFieldUI()

    }
    //Action called when done button clicked
    @IBAction func doneClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "VerifyAddressViewController") as! VerifyAddressViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    //Change appearance of TextFields
    func updateTextFieldUI(){
        let placeholderColor=UIColor.init(red: 155, green: 155, blue: 155)
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = UIColor.init(red: 226, green: 226, blue: 226)
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.passwordTextField.applyAttributesWithValues(placeholderText: "Password *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.confirmPasswordTextField.applyAttributesWithValues(placeholderText: "Confirm Password *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.passwordTextField.setLeftPaddingPoints(19)
        self.confirmPasswordTextField.setLeftPaddingPoints(19)
    }
    //change appearance of done button
    func changeApperanceOfDone(){
        self.doneBtn.isEnabled=true
        self.doneBtn.backgroundColor = UIColor.init(red: 161, green: 149, blue: 133)

    }
}

//MARK: UITextFiled Delegates
extension SetPasswordViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (!(self.passwordTextField.text?.isEmpty)! && !(self.confirmPasswordTextField.text?.isEmpty)! ){
            
            self.changeApperanceOfDone()
        }
    }
}
