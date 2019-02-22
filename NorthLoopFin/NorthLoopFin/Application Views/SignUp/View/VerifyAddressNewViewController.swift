//
//  VerifyAddressNewViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class VerifyAddressNewViewController: BaseViewController {
    
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var doneBtn: CommonButton!

    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Verify Address")
    }
    
    //Change TextField Appearance
    func changeTextFieldAppearance(){
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226//UIColor.init(red: 226, green: 226, blue: 226)
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.streetAddress.applyAttributesWithValues(placeholderText: "Street Address*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.zipCode.applyAttributesWithValues(placeholderText: "Apt/House/Unit No.*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.country.applyAttributesWithValues(placeholderText: "City*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.phoneNumber.applyAttributesWithValues(placeholderText: "State*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        
        self.streetAddress.setLeftPaddingPoints(19)
        self.zipCode.setLeftPaddingPoints(19)
        self.country.setLeftPaddingPoints(19)
        self.phoneNumber.setLeftPaddingPoints(19)
        
        self.streetAddress.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.zipCode.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.country.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.phoneNumber.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.inactivateDoneBtn()
        }
    }
    
    func activateDoneBtn(){
        self.doneBtn.isEnabled=true
    }
    
    func inactivateDoneBtn(){
        self.doneBtn.isEnabled=false
    }
}
func textFieldDidEndEditing(_ textField: UITextField) {
    
}
