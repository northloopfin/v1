//
//  SignupStepConfirm.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 16/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class SignupStepConfirm: BaseViewController {
    
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var passportTextField: UITextField!
    @IBOutlet weak var DOBTextField: UITextField!
    @IBOutlet weak var universityTextField: UITextField!
    @IBOutlet weak var nextBtn: CommonButton!
    
    var signupFlowData:SignupFlowData!=nil
    @IBAction func nextClicked(_ sender: Any) {
        
        //update SignupFlowdata
        self.updateSignupFlowData()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyAddressViewController") as! VerifyAddressViewController
        vc.signupFlowData=self.signupFlowData
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func updateSignupFlowData(){
        if let _ = self.signupFlowData{
            self.signupFlowData.passport=self.passportTextField.text!
            self.signupFlowData.university=self.universityTextField.text!
            self.signupFlowData.documents.email = self.signupFlowData.email
            self.signupFlowData.documents.phoneNumber = self.signupFlowData.phoneNumbers[0]
            let DOBArr = self.DOBTextField.text!.components(separatedBy: "/")
            self.signupFlowData.documents.day = Int(DOBArr[0]) ?? 0
            self.signupFlowData.documents.month = Int(DOBArr[1]) ?? 0
            self.signupFlowData.documents.year = Int(DOBArr[2]) ?? 0
        }
        
    }
    
    // Life Cycle of Controller
    override func viewDidLoad() {
        self.nextBtn.isEnabled=false
        self.prepareView()
        self.updateTextFieldUI()
         self.setupRightNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func prepareView(){
        //Set text color to view components
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.passportTextField.textColor = Colors.DustyGray155155155
        self.DOBTextField.textColor = Colors.DustyGray155155155
        self.universityTextField.textColor = Colors.DustyGray155155155
        
        
        // Set Font to view components
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.passportTextField.font = AppFonts.textBoxCalibri16
        self.DOBTextField.font = AppFonts.textBoxCalibri16
        self.universityTextField.font = AppFonts.textBoxCalibri16
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
        
    }
    
    func updateTextFieldUI(){
        self.passportTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.DOBTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.universityTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        //self.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.passportTextField.applyAttributesWithValues(placeholderText: "Passport Number*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.DOBTextField.applyAttributesWithValues(placeholderText: "Date of Birth(dd/mm/yyyy)*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.universityTextField.applyAttributesWithValues(placeholderText: "University*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        //self.emailTextField.applyAttributesWithValues(placeholderText: "Phone No*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.passportTextField.setLeftPaddingPoints(19)
        self.DOBTextField.setLeftPaddingPoints(19)
        //self.phoneTextField.setLeftPaddingPoints(19)
        self.universityTextField.setLeftPaddingPoints(19)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.nextBtn.isEnabled=false
        }
    }
}

extension SignupStepConfirm:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (!(self.passportTextField.text?.isEmpty)! && !(self.DOBTextField.text?.isEmpty)! && !(self.universityTextField.text?.isEmpty)!
            )
            //(self.emailTextField.text?.isEmpty)!)
        {
            self.nextBtn.isEnabled=true
        }
    }
}
