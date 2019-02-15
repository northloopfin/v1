//
//  ForgetPasswordViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 08/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import Firebase

class ForgetPasswordViewController: BaseViewController {
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var sendLinkBtn: CommonButton!

    var firebaseManager:FirebaseManager!
    
    @IBAction func sendLinkBtnClicked(_ sender: Any) {
        firebaseManager.sentPasswordResetLinkToEmail(email: self.emailTextfield.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firebaseManager = FirebaseManager.init(delegate: self)
        self.prepareView()
    }
    func prepareView(){
        self.sendLinkBtn.isEnabled=false
        self.setNavigationBarTitle(title: "Forget Password")
        self.setupRightNavigationBar()
        self.emailTextfield.textColor = Colors.DustyGray155155155
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
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (!(self.emailTextfield.text?.isEmpty)!)
        {
            
            self.changeApperanceOfDone()
        }
    }
}

extension ForgetPasswordViewController:FirebaseDelegates{
    func didFirebaseUserCreated(authResult: AuthDataResult?, error: NSError?) {
        
    }
    
    func didNameUpdated(error: NSError?) {
        
    }
    
    func didFirebaseDatabaseUpdated() {
        
    }
    
    func didLoggedIn(error: NSError?) {
        
    }
    
    func didReadUserFromDatabase(error: NSError?, data: NSDictionary?) {
        
    }
    
    func didSendPasswordReset(error: NSError?) {
        //handle error here if any
        guard error == nil else{
            // show alert with error
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: (error?.localizedDescription)!)
            return
        }
        self.showAlertWithAction(title: AppConstants.ErrorHandlingKeys.SUCESS_TITLE.rawValue, message: AppConstants.ErrorMessages.FORGET_PASSWORD_MESSAGE.rawValue, buttonArray: ["OK"]) { (_) in
            self.navigationController?.popViewController(animated: false)
        }
    }
}
