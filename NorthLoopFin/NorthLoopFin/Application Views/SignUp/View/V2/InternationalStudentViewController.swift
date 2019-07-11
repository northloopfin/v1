//
//  InternationalStudentViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 22/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class InternationalStudentViewController: BaseViewController {
    @IBOutlet weak var doneBtn: CommonButton!
    
    @IBOutlet weak var waitlistTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "International Student")
        self.prepareView()        
    }
    func prepareView(){
        //disable done button initially
        self.doneBtn.isEnabled=false
        
        //Set font and textcolor for UI components
        self.waitlistTextField.font=AppFonts.textBoxCalibri16
        self.waitlistTextField.textColor=Colors.DustyGray155155155
        self.emailTextField.textColor=Colors.DustyGray155155155
        self.emailTextField.font=AppFonts.textBoxCalibri16
        
        self.doneBtn.titleLabel?.font=AppFonts.btnTitleCalibri18
        
        //Set attributed placehoder for textfields
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226//UIColor.init(red: 226, green: 226, blue: 226)
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.waitlistTextField.applyAttributesWithValues(placeholderText: "Waitlist*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.emailTextField.applyAttributesWithValues(placeholderText: "Email*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.waitlistTextField.setLeftPaddingPoints(19)
        self.emailTextField.setLeftPaddingPoints(19)
        
        //Adding event for text change of textfield
        self.waitlistTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
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
