//
//  VerifyAddressNewViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift

class VerifyAddressNewViewController: BaseViewController {
    
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var code: UITextField!

    @IBOutlet weak var doneBtn: CommonButton!

    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    
    var signupFlowData:SignupFlowData!=nil
    let dropDown = DropDown()
    let countryWithCode = AppUtility.getCountryList()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Verify Address")
        self.prepareView()
        self.changeTextFieldAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Fetch from Realm if any
        self.fetchDatafromRealmIfAny()
    }
    
    func fetchDatafromRealmIfAny(){
        let result = RealmHelper.retrieveBasicInfo()
        print(result)
        if result.count > 0{
            self.doneBtn.isEnabled=true
            let info = result.first!
            self.streetAddress.text = info.streetAddress
            self.zipCode.text = info.zip
            self.country.text = info.country
            self.phoneNumber.text = info.phoneSecondary
            self.code.text = info.countryCode
        }
    }
    @IBAction func doneClicked(_ sender: Any) {
        UserDefaults.saveToUserDefault(AppConstants.Screens.HOME.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
        self.persistDataRealm()

//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "ConfirmedNewViewController") as! ConfirmedNewViewController
//        self.navigationController?.pushViewController(transactionDetailController, animated: false)
        
        //let's create json string here from signupflow data
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self.signupFlowData)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print(jsonString!)
            //all fine with jsonData here
        } catch {
            //handle error
            print(error)
        }
        
        

    }
    
    func persistDataRealm(){
        let info:BasicInfo = BasicInfo()
        info.streetAddress = self.streetAddress.text!
        info.zip = self.zipCode.text!
        info.country = self.country.text!
        info.countryCode = self.code.text!
        info.phoneSecondary = self.phoneNumber.text!
        let result = RealmHelper.retrieveBasicInfo()
        print(result)
        if result.count > 0{
            RealmHelper.updateNote(infoToBeUpdated: result.first!, newInfo: info)
        }
    }
    
    func prepareView(){
        dropDown.anchorView = self.country
        dropDown.dataSource = AppUtility.getCountriesOnly()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.country.text=item
            self.code.text=self.countryWithCode[index].code
            self.dropDown.hide()
        }
        
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.mainTitleLbl.font=AppFonts.mainTitleCalibriBold25
        
        self.subTitleLbl.textColor=Colors.Cameo213186154
        self.subTitleLbl.font=AppFonts.btnTitleCalibri18
        
        self.streetAddress.textColor=Colors.DustyGray155155155
        self.streetAddress.font=AppFonts.textBoxCalibri16
        self.zipCode.textColor=Colors.DustyGray155155155
        self.zipCode.font=AppFonts.textBoxCalibri16
        self.country.textColor=Colors.DustyGray155155155
        self.country.font=AppFonts.textBoxCalibri16
        self.phoneNumber.textColor=Colors.DustyGray155155155
        self.phoneNumber.font=AppFonts.textBoxCalibri16
        self.code.textColor=Colors.DustyGray155155155
        self.code.font=AppFonts.textBoxCalibri16
        
        self.doneBtn.titleLabel?.font=AppFonts.btnTitleCalibri18
    }
    
    //Change TextField Appearance
    func changeTextFieldAppearance(){
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226//UIColor.init(red: 226, green: 226, blue: 226)
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.streetAddress.applyAttributesWithValues(placeholderText: "Street Address*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.zipCode.applyAttributesWithValues(placeholderText: "Zip*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.country.applyAttributesWithValues(placeholderText: "Country*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.phoneNumber.applyAttributesWithValues(placeholderText: "Phone Number*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.code.applyAttributesWithValues(placeholderText: "Code*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.streetAddress.setLeftPaddingPoints(19)
        self.zipCode.setLeftPaddingPoints(19)
        self.country.setLeftPaddingPoints(19)
        self.phoneNumber.setLeftPaddingPoints(19)
        self.code.setLeftPaddingPoints(19)

        self.streetAddress.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.zipCode.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.country.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.phoneNumber.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.code.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
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

extension VerifyAddressNewViewController:UITextFieldDelegate{
func textFieldDidEndEditing(_ textField: UITextField) {
    if (!(self.streetAddress.text?.isEmpty)! && !(self.zipCode.text?.isEmpty)!) && !(self.country.text?.isEmpty)! && !(self.phoneNumber.text?.isEmpty)! && !(self.code.text?.isEmpty)!{
        if (Validations.isValidZip(value: self.zipCode.text!)){
            self.activateDoneBtn()
        }else{
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.ZIP_NOT_VALID.rawValue)
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.country
        {
            IQKeyboardManager.shared.resignFirstResponder()
            self.dropDown.show()
            return false
        }
        else
        {
            return true
        }
    }
}
