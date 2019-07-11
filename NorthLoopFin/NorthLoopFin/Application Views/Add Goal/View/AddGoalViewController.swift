//
//  AddGoalViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 28/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class AddGoalViewController: BaseViewController {
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var howMuchTextfield: UITextField!
    @IBOutlet weak var completedByTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Add Goal")
        self.prepareView()
    }
    
    func prepareView(){
        //disable done button initially
        self.doneBtn.isEnabled=false
        
        //Set font and textcolor for UI components
        self.nameTextfield.font=AppFonts.textBoxCalibri16
        self.nameTextfield.textColor=Colors.DustyGray155155155
        self.amountTextfield.textColor=Colors.DustyGray155155155
        self.amountTextfield.font=AppFonts.textBoxCalibri16
        self.howMuchTextfield.textColor=Colors.DustyGray155155155
        self.howMuchTextfield.font=AppFonts.textBoxCalibri16
        self.completedByTextfield.textColor=Colors.DustyGray155155155
        self.completedByTextfield.font=AppFonts.textBoxCalibri16
        
        self.doneBtn.titleLabel?.font=AppFonts.btnTitleCalibri18
        
        //Set attributed placehoder for textfields
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226//UIColor.init(red: 226, green: 226, blue: 226)
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.nameTextfield.applyAttributesWithValues(placeholderText: "Name*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.amountTextfield.applyAttributesWithValues(placeholderText: "Amount*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.howMuchTextfield.applyAttributesWithValues(placeholderText: "How much*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.completedByTextfield.applyAttributesWithValues(placeholderText: "mm/dd/yy*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.nameTextfield.setLeftPaddingPoints(19)
        self.amountTextfield.setLeftPaddingPoints(19)
        self.howMuchTextfield.setLeftPaddingPoints(19)
        self.completedByTextfield.setLeftPaddingPoints(19)

        //Adding event for text change of textfield
        self.nameTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.amountTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.howMuchTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.completedByTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.inactivateDoneBtn()
        }
    }
    func activateDoneBtn(){
        self.doneBtn.isEnabled=true
        self.doneBtn.backgroundColor = Colors.PurpleColor17673149
    }
    
    func inactivateDoneBtn(){
        self.doneBtn.isEnabled=false
        self.doneBtn.backgroundColor = Colors.Alto224224224
    }
}
