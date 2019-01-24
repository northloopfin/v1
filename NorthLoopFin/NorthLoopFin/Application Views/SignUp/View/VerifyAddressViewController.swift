//
//  VerifyAddressViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class VerifyAddressViewController: BaseViewController {
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var houseNumbertextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var stateTextfield: UITextField!
    @IBOutlet weak var zipTextfield: UITextField!

    @IBOutlet weak var doneBtn: UIButton!
    
    @IBAction func doneClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "AllDoneViewController") as! AllDoneViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.doneBtn.isEnabled=false
        self.changeTextFieldAppearance()
    }
    
    //Change TextField Appearance
    func changeTextFieldAppearance(){
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226//UIColor.init(red: 226, green: 226, blue: 226)
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.streetAddress.applyAttributesWithValues(placeholderText: "Street Address*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.houseNumbertextfield.applyAttributesWithValues(placeholderText: "Apt/House/Unit No.*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.cityTextfield.applyAttributesWithValues(placeholderText: "City*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.stateTextfield.applyAttributesWithValues(placeholderText: "State*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.zipTextfield.applyAttributesWithValues(placeholderText: "Zip Code*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.streetAddress.setLeftPaddingPoints(19)
        self.houseNumbertextfield.setLeftPaddingPoints(19)
        self.cityTextfield.setLeftPaddingPoints(19)
        self.stateTextfield.setLeftPaddingPoints(19)
        self.zipTextfield.setLeftPaddingPoints(19)
        
        self.streetAddress.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.houseNumbertextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.cityTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.stateTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.zipTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.inactivateDoneBtn()
        }
    }
    
    func activateDoneBtn(){
        self.doneBtn.isEnabled=true
        self.doneBtn.backgroundColor = Colors.Zorba161149133
    }
    
    func inactivateDoneBtn(){
        self.doneBtn.isEnabled=false
        self.doneBtn.backgroundColor = Colors.Alto224224224
    }
}
//MARK: UITextField Delegates
extension VerifyAddressViewController:UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (!(self.streetAddress.text?.isEmpty)! && !(self.houseNumbertextfield.text?.isEmpty)!) && !(self.cityTextfield.text?.isEmpty)! && !(self.stateTextfield.text?.isEmpty)! && !(self.zipTextfield.text?.isEmpty)!{
            self.activateDoneBtn()
        }
    }
    
}
