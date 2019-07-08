//
//  MakeTransferViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import DropDown

class MakeTransferViewController: BaseViewController {
    @IBOutlet weak var nicknameHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var payBtnTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var payBtnHeightConstarint: NSLayoutConstraint!
    @IBOutlet weak var amoutHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!

    var presenter:FetchACHPresenter!
    var achArray:[String] = []
    var achNodeArray:[ACHNode] = []

    var selectedACHNode:ACHNode!
    let dropDown = DropDown()

    @IBAction func nextBtnClicked(_ sender: Any) {
        self.moveToConfirmationScreen()
    }
    
    @IBAction func linkACHClicked(_ sender: Any) {
        self.moveToLinkAchScreen()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.inactivateDoneBtn()
        self.configureTextFields()
        self.presenter = FetchACHPresenter.init(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.sendFetchACRequest()

    }
    
    // Initially showing UI for no account added. Once get response from API, will change UI
    func initialiseUIWithEmptyData(){
        self.nicknameHeightConstraint.constant=0
        self.amoutHeightConstraint.constant=0
        self.payBtnHeightConstarint.constant=0
        self.payBtnTopConstraint.constant=0
    }
    
    func prepareView(){
        self.initialiseUIWithEmptyData()
        self.nicknameTextField.inputView = UIView.init(frame: CGRect.zero)
        self.nicknameTextField.inputAccessoryView = UIView.init(frame: CGRect.zero)
        dropDown.anchorView = self.nicknameTextField
        dropDown.dataSource = self.achArray
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.nicknameTextField.text=item
            self.selectedACHNode=self.achNodeArray[index]
            self.dropDown.hide()
            self.checkForMandatoryFields()
        }
        self.setNavigationBarTitle(title: "Transfer")
        self.setupRightNavigationBar()
        self.amountTextField.textColor = Colors.DustyGray155155155
        
        self.nicknameTextField.textColor=Colors.DustyGray155155155
        self.amountTextField.font=AppFonts.textBoxCalibri16
        
        self.nicknameTextField.font=AppFonts.textBoxCalibri16
        self.nextBtn.titleLabel!.font=AppFonts.calibri15
        self.configureTextFields()
    }
    func configureTextFields(){
        self.amountTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.nicknameTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.amountTextField.applyAttributesWithValues(placeholderText: "Amount*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.nicknameTextField.applyAttributesWithValues(placeholderText: "Nickname*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.amountTextField.setLeftPaddingPoints(19)
        self.nicknameTextField.setLeftPaddingPoints(19)
        
        
        
    }
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.inactivateDoneBtn()
        }else{
            self.checkForMandatoryFields()
        }
        
    }
    //change appearance of done button
    func changeApperanceOfDone(){
        self.nextBtn.isEnabled=true
        self.nextBtn.backgroundColor = Colors.Zorba161149133
    }
    
    func inactivateDoneBtn(){
        self.nextBtn.isEnabled=false
        self.nextBtn.backgroundColor = Colors.Alto224224224
    }
    
    func moveToConfirmationScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TransferConfirmationViewController") as! TransferConfirmationViewController
        vc.amount=self.amountTextField.text!
        vc.ach=self.selectedACHNode
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func moveToLinkAchScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TransferViewController") as! TransferViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
extension MakeTransferViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.checkForMandatoryFields()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.nicknameTextField
        {
            //IQKeyboardManager.shared.resignFirstResponder()
            
            self.dropDown.show()
            return false
        }
        else
        {
            return true
        }
    }
    
    func checkForMandatoryFields(){
        if (!(self.amountTextField.text?.isEmpty)! && !(self.nicknameTextField.text?.isEmpty)!)
            //&& !((self.rountingNumberTextField.text?.isEmpty)!)
        {
            
            self.changeApperanceOfDone()
        }
    }
}
extension MakeTransferViewController:FetchACHDelegates{
    func didSentFetchACH(data: [ACHNode]) {
        if data.count > 0{
        self.achNodeArray=data
        for n in 0...(data.count-1) {
            let nickname = data[n].nickname
            self.achArray.append(nickname)
            }
            self.nicknameHeightConstraint.constant=50
            self.amoutHeightConstraint.constant=50
            self.payBtnHeightConstarint.constant=45
            self.payBtnTopConstraint.constant=148
        }
        self.dropDown.dataSource = self.achArray
    }
}

