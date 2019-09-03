//
//  PersonalDetailViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 11/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import RealmSwift

class PersonalDetailViewController: BaseViewController {
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var DOBtextField: UITextField!
    
    @IBOutlet weak var vwProgress: ProgressView!
    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: LabelWithLetterSpace!
    
    
    let countryPicker = CountryPickerView.instanceFromNib()
    lazy var basicInfo: Results<BasicInfo> = RealmHelper.retrieveBasicInfo()
    let datePicker = UIDatePicker()

    var signupFlowData:SignupFlowData! = nil

    var referralPresenter:ReferralPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.nextBtn.isEnabled=false
        if let invitedBy = UserDefaults.getUserDefaultForKey(AppConstants.ReferralId){
            referralPresenter = ReferralPresenter(delegate: self)
            referralPresenter.sendReferralRequest(invitedBy: invitedBy as! String)
        }
        
        if UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForOnboarding) == nil{
            UserDefaults.saveToUserDefault("true" as AnyObject, key: AppConstants.UserDefaultKeyForOnboarding)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Fetch from Realm if any
        self.fetchDatafromRealmIfAny()
    }
    
    
    func prepareView(){
        self.DOBtextField.inputView = UIView.init(frame: CGRect.zero)
        self.DOBtextField.inputAccessoryView = UIView.init(frame: CGRect.zero)
        
        self.vwProgress.progressView.setProgress(0.17*1, animated: true)
    }
    
    @IBAction func continueButtonAction(_ sender: CommonButton) {
        validateNames()
    }
    
   
    func validateNames(){
        if (Validations.isValidName(value: self.firstnameTextField.text!) && Validations.isValidName(value: self.lastnameTextField.text!)){
            if Validations.isValidDob(dateString: self.DOBtextField.text ?? ""){
                self.saveDataToRealm()
            }else{
                //show error for age
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.DOB_NOT_VALID.rawValue)
            }
        }else{
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.NAME_NOT_VALID.rawValue)
        }
    }
    
    
    func fetchDatafromRealmIfAny(){
        if self.basicInfo.count > 0{
            let info = self.basicInfo.first!
            self.firstnameTextField.text = info.firstname
            self.lastnameTextField.text = info.lastname
            self.DOBtextField.text = info.DOB
            checkForMandatoryFields()
        }
    }

     func saveDataToRealm(){
        let basicInfo:BasicInfo=BasicInfo()
        basicInfo.email=UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String
        basicInfo.firstname=self.firstnameTextField.text ?? ""
        basicInfo.lastname=self.lastnameTextField.text ?? ""
        basicInfo.DOB=self.DOBtextField.text ?? ""
        
        RealmHelper.addBasicInfo(info: basicInfo)
        
        let legalName = self.firstnameTextField.text!+" "+self.lastnameTextField.text!
        
        if let data = self.signupFlowData{
            data.legalNames=[legalName]
            let documents:SignupFlowDocument=self.signupFlowData.documents
            documents.virtualDocs=[]
            let DOBArr = self.DOBtextField.text!.components(separatedBy: "/")
            documents.day = Int(DOBArr[0]) ?? 0
            documents.month = Int(DOBArr[1]) ?? 0
            documents.year = Int(DOBArr[2]) ?? 0

            data.documents=documents
        
            data.cipTag=2 // changed from 1->3 as per client requirement
            let vc = getControllerWithIdentifier("PhoneNumberController") as! PhoneNumberController
            vc.signupFlowData=data
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    
    func showDatePicker(){
        //Format Date
        datePicker.datePickerMode = .date
        datePicker.minimumDate = nil
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker(view:)));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        self.DOBtextField.inputAccessoryView = toolbar
        self.DOBtextField.inputView = datePicker
    }
    
    @objc func donedatePicker(view:UIBarButtonItem){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.DOBtextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}

extension PersonalDetailViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.checkForMandatoryFields()
    }
    
    // Methode will check for mandatory fields and perform accordingly
    func checkForMandatoryFields(){
        if (!(self.firstnameTextField.text?.isEmpty)! && !(self.lastnameTextField.text?.isEmpty)! && !(self.DOBtextField.text?.isEmpty)!)
        {
            self.nextBtn.isEnabled=true
        }
    }
 
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.DOBtextField{
            self.showDatePicker()
        }
    }
}


extension PersonalDetailViewController:ReferralDelegate{
    func didReferralAdded() {
        
    }
}
