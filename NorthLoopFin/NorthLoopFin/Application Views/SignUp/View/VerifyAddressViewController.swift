//
//  VerifyAddressViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class VerifyAddressViewController: BaseViewController {
    @IBOutlet weak var verifyAddressTextField: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var houseNumbertextfield: UITextField!
    
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
    
    //Change TextField Appearance
    func changeTextFieldAppearance(){
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226//UIColor.init(red: 226, green: 226, blue: 226)
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.verifyAddressTextField.applyAttributesWithValues(placeholderText: "Address type here.. *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.houseNumbertextfield.applyAttributesWithValues(placeholderText: "unit/apt/house number *", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.verifyAddressTextField.setLeftPaddingPoints(19)
        self.houseNumbertextfield.setLeftPaddingPoints(19)
        
        self.verifyAddressTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.houseNumbertextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
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
        if (!(self.verifyAddressTextField.text?.isEmpty)! && !(self.houseNumbertextfield.text?.isEmpty)!){
            self.activateDoneBtn()
        }
    }
    
}
