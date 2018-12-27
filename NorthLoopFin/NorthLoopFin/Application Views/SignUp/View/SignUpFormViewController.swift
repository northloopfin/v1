//
//  SignUpFormViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 19/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class SignUpFormViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBAction func nextClicked(_ sender: Any) {
        //if (validateForm()){
            moveToOTPScreen()
        //}
    }
    //Validate form for empty text , valid email, valid phone
    func validateForm()->Bool{
        if (!(self.phoneTextField.text?.isEmpty)! && !(self.firstNameTextField.text?.isEmpty)! && !(self.lastNameTextField.text?.isEmpty)! && !(self.emailTextField.text?.isEmpty)!){
                if (Validations.isValidEmail(email: self.emailTextField.text!)){
                    return true
                }else{
                    return false
            }
        }
        return false
    }
    //Move to OTP screen
    func moveToOTPScreen(){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTextFieldUI()
    }
    
    func updateTextFieldUI(){
        let placeholderColor=UIColor.init(red: 155, green: 155, blue: 155)
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = UIColor.init(red: 226, green: 226, blue: 226)
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0

        self.firstNameTextField.applyAttributesWithValues(placeholderText: "First Name *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.lastNameTextField.applyAttributesWithValues(placeholderText: "Last Name *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.emailTextField.applyAttributesWithValues(placeholderText: "Email *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.phoneTextField.applyAttributesWithValues(placeholderText: "Phone No *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.firstNameTextField.setLeftPaddingPoints(19)
        self.lastNameTextField.setLeftPaddingPoints(19)
        self.phoneTextField.setLeftPaddingPoints(19)
        self.emailTextField.setLeftPaddingPoints(19)
    }
}

