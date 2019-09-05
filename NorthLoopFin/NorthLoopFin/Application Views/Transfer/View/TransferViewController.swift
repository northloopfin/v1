//
//  TransferViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 11/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class TransferViewController: BaseViewController {
    @IBOutlet weak var bankAccountNumberTextfield: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var rountingNumberTextField: UITextField!

    @IBOutlet weak var vwError: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var constRoutingInfo: NSLayoutConstraint!
    @IBOutlet weak var lblRoutingSubtitle: LabelWithLetterSpace!
    @IBOutlet weak var lblRoutingTitle: LabelWithLetterSpace!
    @IBOutlet weak var imgRouting: UIImageView!
    @IBOutlet weak var vwRoutingInfo: UIView!
    @IBOutlet weak var lblError: LabelWithLetterSpace!
    
    @IBOutlet weak var imgTick: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var presenter:LinkACHPresenter!
    var routingVeriPresenter:RoutingVerificationPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.presenter = LinkACHPresenter.init(delegate: self)
        self.routingVeriPresenter = RoutingVerificationPresenter.init(delegate: self)
        inactivateDoneBtn()
    }
    @IBAction func saveBtnClicked(_ sender: Any) {
        // Validate Form
        self.validateForm()
    }
    
    //Validate form here
    func validateForm(){
        if Validations.isValidRoutingNumber(routingNumber: self.rountingNumberTextField.text!){
            self.vwError.isHidden = true
            // Yes Valid
            spinner.startAnimating()
            self.presenter.sendLinkACRequest(nickname: self.nicknameTextField.text!, accountNo: self.bankAccountNumberTextfield.text!, rountingNo: self.rountingNumberTextField.text!)
        }else{
            self.vwError.isHidden = false
            self.lblError.text = AppConstants.ErrorMessages.ROUTING_NUMBER_NOT_VALID.rawValue
            // show error here
//            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.ROUTING_NUMBER_NOT_VALID.rawValue)
        }
    }
    //Prepare view to display
    func prepareView(){
        self.setNavigationBarTitle(title: "Transfer")
        self.setupRightNavigationBar()
        self.saveBtn.titleLabel!.font=AppFonts.calibri15
        
        self.bankAccountNumberTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.nicknameTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.rountingNumberTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)

    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.inactivateDoneBtn()
        }else{
            checkMandatoryFields()
        }
        if textField == self.rountingNumberTextField {
            if (textField.text?.count != 9){
                constRoutingInfo.constant = 0
                imgTick.isHidden = true
                self.vwError.isHidden = false
                self.lblError.text = AppConstants.ErrorMessages.ROUTING_NUMBER_NOT_VALID.rawValue
                inactivateDoneBtn()
            }else{
                spinner.startAnimating(); self.routingVeriPresenter.sendRoutingVerificationRequest(routing: self.rountingNumberTextField.text!)
            }
        }
    }
    //change appearance of done button
    func changeApperanceOfDone(){
        self.saveBtn.isEnabled=true
        self.saveBtn.backgroundColor = Colors.PurpleColor17673149
    }
    
    func inactivateDoneBtn(){
        self.saveBtn.isEnabled=false
        self.saveBtn.backgroundColor = Colors.Alto224224224
    }
}
//MARK: UITextFiled Delegates
extension TransferViewController:UITextFieldDelegate{
    fileprivate func checkMandatoryFields() {
        if (!(self.bankAccountNumberTextfield.text?.isEmpty)! && !(self.nicknameTextField.text?.isEmpty)!) && !((self.rountingNumberTextField.text?.isEmpty)!){
            self.changeApperanceOfDone()
        }else{
            self.inactivateDoneBtn()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        checkMandatoryFields()
    }
}

extension TransferViewController:LinkACHDelegates{
    func didSentLinkACH() {
        self.navigationController?.popViewController(animated: false)
    }
}

extension TransferViewController:RoutingVerificationDelegate{
    func didRoutingVerified(data: RoutingVerification) {
        spinner.stopAnimating()
        constRoutingInfo.constant = 75
        lblRoutingTitle.text = data.bank_name
        lblRoutingSubtitle.text = data.address
        imgTick.isHidden = false
        if let url = URL(string: data.logo.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!){
            imgRouting.setImageWith(url)
        }else{
            imgRouting.image = nil
        }
        self.vwError.isHidden = true
    }
    
    func failedRoutingVerification() {
        spinner.stopAnimating()
        constRoutingInfo.constant = 0
        self.vwError.isHidden = false
        imgTick.isHidden = true
        self.lblError.text = AppConstants.ErrorMessages.ROUTING_NUMBER_NOT_VALID.rawValue
    }
}
