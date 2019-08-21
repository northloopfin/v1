//
//  ChangePhoneViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 06/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ChangePhoneViewController: BaseViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var messageLbl: UILabel!

    var presenter:ChangePhonePresenter!

    @IBAction func changeBtnClicked(_ sender: Any) {
        if Validations.isValidPhone(phone: self.phoneTextField.text ?? ""){
            self.presenter.sendChangePhoneRequest(newPhoneNumber: self.phoneTextField.text!)

        }else{
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PHONE_NOT_VALID.rawValue)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = ChangePhonePresenter.init(delegate: self)
        self.prepareView()
    }
    
    func prepareView(){
        self.changeBtn.isEnabled=false
        self.setNavigationBarTitle(title: "Change Phone Number")
        self.setupRightNavigationBar()
        
        self.phoneTextField.textColor=Colors.DustyGray155155155
        self.messageLbl.textColor = Colors.MainTitleColor
        self.messageLbl.font=AppFonts.calibriBold16

        self.phoneTextField.font=AppFonts.textBoxCalibri16
        self.changeBtn.titleLabel!.font=AppFonts.calibri15
        self.configureTextFields()
    }
    func configureTextFields(){
        
        self.phoneTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.phoneTextField.applyAttributesWithValues(placeholderText: "New Phone Number*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.phoneTextField.setLeftPaddingPoints(19)
    }
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.changeBtn.isEnabled=false
        }else{
            self.checkForMandatoryFields()
        }
    }
    
}
extension ChangePhoneViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.checkForMandatoryFields()
    }
    
    func checkForMandatoryFields(){
        if (!(self.phoneTextField.text?.isEmpty)!){
            self.changeBtn.isEnabled=true
        }
    }
}

extension ChangePhoneViewController:ChangePhoneDelegate{
    func didPhoneChanged() {
        self.moveToConfirmationScreen()
    }
    
    
        func moveToConfirmationScreen(){
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "LostCardConfirmationViewController") as! LostCardConfirmationViewController
//            vc.message = "Your new number is set! We have sent an email confirming."
//            self.navigationController?.pushViewController(vc, animated: false)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            vc.screenWhichInitiatedOTP = AppConstants.Screens.HOME
            self.navigationController?.pushViewController(vc, animated: false)
        }
    
}
