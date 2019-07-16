//
//  NewPinViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 30/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import SwiftyRSA

class NewPinViewController: BaseViewController {

    //@IBOutlet weak var currentPin: UITextField!
    @IBOutlet weak var newPin: UITextField!
    @IBOutlet weak var confirmPin: UITextField!
    @IBOutlet weak var changeBtn: UIButton!
    var presenter: SetPinPresenter!

    @IBAction func changeBtnClicked(_ sender: Any) {
        if (Validations.matchTwoStrings(string1: self.newPin.text!, string2: self.confirmPin.text!)){
            let enyptedPin = self.encryptPin()
            print(enyptedPin)
            self.presenter.setPinRequest(pin: encryptPin())
        }else{
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PASSWORD_DONOT_MATCH.rawValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeBtn.isEnabled=false
        self.prepareView()
        self.configureTextFields()
        self.presenter = SetPinPresenter.init(delegate: self)
    }
    
    func prepareView(){
        self.setNavigationBarTitle(title: "Set Pin")
        self.setupRightNavigationBar()
        self.newPin.textColor = Colors.DustyGray155155155
        self.confirmPin.textColor=Colors.DustyGray155155155
        self.newPin.font=AppFonts.textBoxCalibri16
        self.confirmPin.font=AppFonts.textBoxCalibri16
        self.changeBtn.titleLabel!.font=AppFonts.calibri15
        self.configureTextFields()
    }
    func configureTextFields(){
        self.newPin.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.confirmPin.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.newPin.applyAttributesWithValues(placeholderText: "New Pin*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.confirmPin.applyAttributesWithValues(placeholderText: "Confirm Pin*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.newPin.setLeftPaddingPoints(19)
        self.confirmPin.setLeftPaddingPoints(19)
        
    }
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.changeBtn.isEnabled=false
        }else{
            checkMandatoryFields()
        }
    }
    
    func moveToSucessScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SucessViewController") as! SucessViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func encryptPin()->String{
        let publicKeyString:String = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzxVLeRTf77kmG/42SdjjtRfaI/7GN4UoUBfxzN80gCyrjK+tHYJR7DKefC47fNyA2dGU7x3tu1wQRKOkjschbC3ZWF1mCqccUiHRPiGhH9VBsxLbAUCFAKOPZcBDCT7IhUdd6S23e99ewkb0c6pRk28u+kz+7ZB7d6Z/S+Em316zs0HqEnEaoUNFXtdTyW3EPuaqo0+p9daICRC44VbrTlzc+Y1A/CsiOcCCl4ske8scu/fWg0K3nybfn7IdO2smkzRwwGOc4uexBMnAkAyl0eQrqXZO4vis6ktmLFV4NpYsd0U2vvmuXFoA9XBcJHdbAww/TGwHq5RJ3505QSEK8QIDAQAB"
        
//        do {
//            let jsonData = try jsonEncoder.encode(self.signupFlowData)
//            let jsonString = String(data: jsonData, encoding: .utf8)
//            print(jsonString!)
//            //all fine with jsonData here
//        } catch {
//            //handle error
//            print(error)
//        }
        var base64String = ""

        do {
            let publicKey = try PublicKey(pemEncoded: publicKeyString)//try PublicKey(pemNamed: publicKeyString)
            let clearPin = self.newPin.text!
            let clear = try ClearMessage(string: clearPin, using: .utf8)
            let encrypted = try clear.encrypted(with: publicKey, padding: .PKCS1)
            //let data = encrypted.data
            base64String = encrypted.base64String
        }catch{
                print(error)
        }
        return base64String
    }
}
extension NewPinViewController:UITextFieldDelegate{
    fileprivate func checkMandatoryFields() {
        if (!(self.confirmPin.text?.isEmpty)! && !(self.newPin.text?.isEmpty)!) //&& !((self.confirmPin.text?.isEmpty)!)
        {
            self.changeBtn.isEnabled=true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        checkMandatoryFields()
    }
}
extension NewPinViewController:SetPinDelegates{
    func didSetPinSuccessful() {
        AppUtility.moveToHomeScreen()
    }
}
