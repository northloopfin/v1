//
//  PhoneNumberController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 23/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import RealmSwift

class PhoneNumberController: BaseViewController {

    @IBOutlet weak var phoneNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var countryCodeTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var nextBtn: RippleButton!
    @IBOutlet weak var customProgressView: ProgressView!
    
    let countryPicker = CountryPickerView.instanceFromNib()
    lazy var basicInfo: Results<BasicInfo> = RealmHelper.retrieveBasicInfo()
    var selectedCountry:Country!
    let countryWithCode = AppUtility.getCountryList()
    var signupFlowData:SignupFlowData!=nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.prepareView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Fetch from Realm if any
        self.fetchDatafromRealmIfAny()
    }
    
    
    func prepareView(){
        self.countryPicker.delegate = self
        self.customProgressView.progressView.setProgress(0.17*2, animated: true)
        
        self.phoneNumberTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.countryCodeTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)

     }
    
    func fetchDatafromRealmIfAny(){
        self.nextBtn.isEnabled=false
        if self.basicInfo.count > 0{
            //            self.nextBtn.isEnabled=true
            let info = self.basicInfo.first!
            self.phoneNumberTextField.text = info.phone
            self.countryCodeTextField.text = info.countryCode
            if info.citizenShip.count > 0{
                let selectedCountryArr = self.countryWithCode.filter { $0.name == info.citizenShip}
                self.selectedCountry = selectedCountryArr[0]
                setCountryImage()
            }
            checkForMandatoryFields()
        }
    }

    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.nextBtn.isEnabled=false
        }else{
            self.checkForMandatoryFields()
        }
    }
    
    func validatePhoneNumber(){
        if !((self.phoneNumberTextField.text?.isEmpty)!){
            //its not empty so validate phone
            if Validations.isValidPhone(phone: self.phoneNumberTextField.text ?? ""){
                // yes valid
                self.updateSignUpFormData()
            }else{
                //show error
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.PHONE_NOT_VALID.rawValue)
                return
            }
        }else{
            self.updateSignUpFormData()
        }
    }
    
    func updateSignUpFormData(){
        let basicInfo:BasicInfo=BasicInfo()
        basicInfo.email=UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String
        basicInfo.phone=self.phoneNumberTextField.text ?? ""
        basicInfo.countryCode=self.countryCodeTextField.text ?? ""
        basicInfo.citizenShip = selectedCountry.name
        let result = RealmHelper.retrieveBasicInfo()
        if result.count > 0{
            RealmHelper.updateBasicInfo(infoToBeUpdated: result.first!, newInfo: basicInfo)
        }
        
        let phoneNumber = self.countryCodeTextField.text!.trimmingCharacters(in: .whitespaces) + self.phoneNumberTextField.text!
        
        if let data = self.signupFlowData{
            data.phoneNumbers=[phoneNumber]
            let address : SignupFlowAddress = data.address
            address.country = self.selectedCountry.code
            let vc = getControllerWithIdentifier("VerifyIdentityViewController") as! VerifyIdentityViewController
            vc.signupFlowData=data
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

    @IBAction func btnNext_pressed(_ sender: UIButton) {
        validatePhoneNumber()
    }
}

extension PhoneNumberController:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.countryCodeTextField{
            //self.countryCodeDropDown.show()
            self.countryPicker.tag = 0
            self.countryPicker.show()
            return false
        }
        else
        {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.checkForMandatoryFields()
    }
    
    // Methode will check for mandatory fields and perform accordingly
    func checkForMandatoryFields(){
        if (!(self.phoneNumberTextField.text?.isEmpty)! && !(self.countryCodeTextField.text?.isEmpty)! )
        {
            self.nextBtn.isEnabled=true
        }
    }

}

extension PhoneNumberController:CountryPickerViewDelegate {
    func countryPickerView(picker: CountryPickerView, didSelectCountry country: Country) {
        if self.countryPicker.tag == 0{
            selectedCountry = country
            setCountryImage()
        }
    }
    
    func setCountryImage(){
        self.countryCodeTextField.text = " " + selectedCountry.dialCode

        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 24, height: self.countryCodeTextField.frame.size.height)
        
        let vw = UIImageView(image: UIImage(named: selectedCountry.code))
        vw.frame = CGRect(x: 0, y: 25, width: 24, height: 21)
        vw.contentMode = .scaleAspectFit
        leftView.addSubview(vw)
        
        countryCodeTextField.leftView = leftView
        countryCodeTextField.leftViewMode = .always
    }
    
    func countryPickerViewDidDismiss(picker: CountryPickerView) {
        
    }
}
