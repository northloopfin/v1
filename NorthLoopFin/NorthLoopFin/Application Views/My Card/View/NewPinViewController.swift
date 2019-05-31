//
//  NewPinViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 30/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class NewPinViewController: BaseViewController {

    @IBOutlet weak var currentPin: UITextField!
    @IBOutlet weak var newPin: UITextField!
    @IBOutlet weak var confirmPin: UITextField!
    @IBOutlet weak var changeBtn: UIButton!

    @IBAction func changeBtnClicked(_ sender: Any) {
        self.moveToSucessScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeBtn.isEnabled=false
        self.prepareView()
        self.configureTextFields()
    }
    
    func prepareView(){
        self.setNavigationBarTitle(title: "Set Pin")
        self.setupRightNavigationBar()
        self.currentPin.textColor = Colors.DustyGray155155155
        self.newPin.textColor = Colors.DustyGray155155155
        self.confirmPin.textColor=Colors.DustyGray155155155
        self.currentPin.font=AppFonts.textBoxCalibri16
        self.newPin.font=AppFonts.textBoxCalibri16
        self.confirmPin.font=AppFonts.textBoxCalibri16
        self.changeBtn.titleLabel!.font=AppFonts.calibri15
        self.configureTextFields()
    }
    func configureTextFields(){
        self.currentPin.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.newPin.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.confirmPin.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.currentPin.applyAttributesWithValues(placeholderText: "Current Pin*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.newPin.applyAttributesWithValues(placeholderText: "New Pin*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.confirmPin.applyAttributesWithValues(placeholderText: "Confirm Pin*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.currentPin.setLeftPaddingPoints(19)
        self.newPin.setLeftPaddingPoints(19)
        self.confirmPin.setLeftPaddingPoints(19)
        
    }
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.changeBtn.isEnabled=false
        }
    }
    
    func moveToSucessScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SucessViewController") as! SucessViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
extension NewPinViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (!(self.currentPin.text?.isEmpty)! && !(self.newPin.text?.isEmpty)!) && !((self.confirmPin.text?.isEmpty)!){
            self.changeBtn.isEnabled=true
        }
    }
}
