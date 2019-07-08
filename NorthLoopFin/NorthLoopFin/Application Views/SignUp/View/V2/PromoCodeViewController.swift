//
//  PromoCodeViewController.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 03/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class PromoCodeViewController: BaseViewController {

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var promoCodeTxt: UITextField!
    @IBOutlet weak var skipBtn: CommonButton!
    @IBOutlet weak var applyBtn: CommonButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    func prepareView(){
        self.applyBtn.isEnabled=false
        self.setNavigationBarTitle(title: "Promo Code")
        self.setupRightNavigationBar()
        self.messageLbl.textColor = Colors.MainTitleColor
        self.promoCodeTxt.textColor = Colors.DustyGray155155155
        
        self.messageLbl.font=AppFonts.calibriBold16
        self.promoCodeTxt.font=AppFonts.textBoxCalibri16
        self.skipBtn.titleLabel!.font=AppFonts.calibri15
        self.applyBtn.titleLabel!.font=AppFonts.calibri15

        self.configureTextFields()
    }
    
    func configureTextFields(){
        self.promoCodeTxt.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.promoCodeTxt.applyAttributesWithValues(placeholderText: "Promo Code*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        
        self.promoCodeTxt.setLeftPaddingPoints(19)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.applyBtn.isEnabled=false
        }else{
            self.applyBtn.isEnabled=true
        }
    }
    
    func validateCode(){
        if Validations.matchTwoStrings(string1: self.promoCodeTxt.text!, string2: "HELLO"){
            // valid
            AppUtility.moveToHomeScreen()

        }else{
            // show message
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PROMOCODE_NOT_VALID.rawValue)
        }
    }
    
    @IBAction func applyBtnClicked(_ sender: Any) {
        self.validateCode()
    }
    @IBAction func skipBtnClicked(_ sender: Any) {
        AppUtility.moveToHomeScreen()
    }
}
