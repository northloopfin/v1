//
//  Select2FAModeViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 05/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import DropDown


class Select2FAModeViewController: BaseViewController {
    
    @IBOutlet weak var twoFAModeTextField: UITextField!
    @IBOutlet weak var proceedBtn: UIButton!
    let dropDown = DropDown()

    var screenWhichInitiated : AppConstants.Screens?
    //Drop Down data source
    let dropDownDataSource:[String]=["Email","Phone Number"]
    //Presenter to call api
    var presenter:TwoFAPresenter!
    
    //var used to keep track of user selection
    var isEmailSelected:Bool=false
    var isPhoneSelected:Bool=false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        
        //initialize presenter here
        self.presenter = TwoFAPresenter.init(delegate: self)
    }
    
    @IBAction func proceedBtnClicked(_ sender: Any) {
        if self.twoFAModeTextField.text == "Email"{
            self.presenter.sendTwoFARequest(sendToAPI: false)
        }else{
            self.presenter.sendTwoFARequest(sendToAPI: true)
        }
    }
    
    func prepareView(){
        self.setNavigationBarTitle(title: "2FA")
        self.setupRightNavigationBar()
        
        self.twoFAModeTextField.inputView = UIView.init(frame: CGRect.zero)
        self.twoFAModeTextField.inputAccessoryView = UIView.init(frame: CGRect.zero)
        //set drop down here
        dropDown.anchorView = self.twoFAModeTextField
        dropDown.dataSource = self.dropDownDataSource
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.twoFAModeTextField.text=item
            if item=="Email"{
                self.isPhoneSelected=false
                self.isEmailSelected=true
            }else{
                self.isEmailSelected=false
                self.isPhoneSelected=true
            }
            self.dropDown.hide()
            self.checkForMandatoryFields()
        }
        self.twoFAModeTextField.textColor=Colors.DustyGray155155155
        
        self.twoFAModeTextField.font=AppFonts.textBoxCalibri16
        self.proceedBtn.titleLabel!.font=AppFonts.calibri15
        self.configureTextFields()
    }
    func configureTextFields(){
        
        self.twoFAModeTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.twoFAModeTextField.applyAttributesWithValues(placeholderText: "Select where to send OTP*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.twoFAModeTextField.setLeftPaddingPoints(19)
    }
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.proceedBtn.isEnabled=false
        }
    }
    
    func moveToVerifyOTPScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        vc.screenWhichInitiatedOTP = self.screenWhichInitiated
        vc.isEmailSelectedForOTP=self.isEmailSelected
        vc.isPhoneSelectedForOTP=self.isPhoneSelected
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
extension Select2FAModeViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.checkForMandatoryFields()
    }
    
    func checkForMandatoryFields(){
        if (!(self.twoFAModeTextField.text?.isEmpty)!){
            self.proceedBtn.isEnabled=true
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.twoFAModeTextField
        {
            self.dropDown.show()
            return false
        }
        else
        {
            return true
        }
    }
}

extension Select2FAModeViewController:TwoFADelegates{
    func didGetOTP() {
        self.moveToVerifyOTPScreen()
    }
}
