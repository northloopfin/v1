//
//  DisputeTransactionViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 31/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class DisputeTransactionViewController: BaseViewController {

    //@IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var issueTextField: UITextField!
    @IBOutlet weak var reportBtn: UIButton!
    var presenter:DisputeTransactionPresenter!
    var transaction:IndividualTransaction?
    @IBAction func reportClicked(_ sender: Any) {
        if let _ = self.transaction{
            self.presenter.sendDisputeIssue(transactionId: self.transaction?.id ?? "", reason: self.issueTextField.text ?? "")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reportBtn.isEnabled=false
        self.presenter = DisputeTransactionPresenter.init(delegate: self)
        self.prepareView()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        self.setNavigationBarTitle(title: "Dispute Transaction")
        self.setupRightNavigationBar()
        //self.dateTextField.textColor = Colors.DustyGray155155155
        
        self.issueTextField.textColor=Colors.DustyGray155155155
        //self.dateTextField.font=AppFonts.textBoxCalibri16
        
        self.issueTextField.font=AppFonts.textBoxCalibri16
        self.reportBtn.titleLabel!.font=AppFonts.calibri15
        self.configureTextFields()
    }
    func configureTextFields(){
       // self.dateTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.issueTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
       // self.dateTextField.applyAttributesWithValues(placeholderText: "Amount*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.issueTextField.applyAttributesWithValues(placeholderText: "Type in issue here*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        //self.dateTextField.setLeftPaddingPoints(19)
        self.issueTextField.setLeftPaddingPoints(19)
    }
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.reportBtn.isEnabled=false
        }else{
            self.checkForMandatoryFields()
        }
    }
    
    func moveToConfirmationScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DisputeTransactionConfirmationViewController") as! DisputeTransactionConfirmationViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
extension DisputeTransactionViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.checkForMandatoryFields()
    }
    
    func checkForMandatoryFields(){
        if (!(self.issueTextField.text?.isEmpty)!){
            self.reportBtn.isEnabled=true
        }
    }
}

extension DisputeTransactionViewController:DisputeTransactionDelegates{
    func didSentDisputeTransactionRequest() {
        self.moveToConfirmationScreen()
    }
}
