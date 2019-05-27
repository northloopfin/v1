//
//  VerifyAddressViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift
import MFSideMenu

class VerifyAddressViewController: BaseViewController {
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var houseNumbertextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var textState: UITextField!
    @IBOutlet weak var zipTextfield: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!

    @IBOutlet weak var doneBtn: CommonButton!
    
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    var signupFlowData:SignupFlowData!=nil
    var presenter: SignupSynapsePresenter!


    let dropDown = DropDown()
    let countryWithCode = AppUtility.getCountryList()
    
    func updateSignupFlowData(){
        if let _ = self.signupFlowData{
            let addess:SignupFlowAddress = SignupFlowAddress.init(street: self.streetAddress.text!, houseNo: self.houseNumbertextfield.text!, city: self.cityTextfield.text!, state: self.textState.text!, zip: self.zipTextfield.text!)

            if let _  = self.signupFlowData{
                self.signupFlowData.address = addess
            }
        }
    }
    @IBAction func statesClicked(_ sender: Any) {
        dropDown.show()
    }
    @IBAction func doneClicked(_ sender: Any) {
        //self.updateSignupFlowData()
        
        UserDefaults.saveToUserDefault(AppConstants.Screens.HOME.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self.signupFlowData)
            let jsonString = String(data: jsonData, encoding: .utf8)
            //print(jsonString!)
            let dic:[String:AnyObject] = jsonString?.convertToDictionary() as! [String : AnyObject]
            //all fine with jsonData here
            self.presenter.startSignUpSynapse(requestDic: dic)
        } catch {
            //handle error
            print(error)
        }
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "AllDoneViewController") as! AllDoneViewController
//        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.doneBtn.isEnabled=false
        self.changeTextFieldAppearance()
        self.prepareView()
        self.presenter = SignupSynapsePresenter.init(delegate: self)
    }
    
    /// Prepare View by setting up font and color of UI components
    func prepareView(){
        dropDown.anchorView = self.textState
        dropDown.dataSource = AppUtility.getStatesArray()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.textState.text=item
            self.dropDown.hide()
        }
        
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.mainTitleLbl.font=AppFonts.mainTitleCalibriBold25
        
        self.subTitleLbl.textColor=Colors.Cameo213186154
        self.subTitleLbl.font=AppFonts.btnTitleCalibri18
        
        self.streetAddress.textColor=Colors.DustyGray155155155
        self.streetAddress.font=AppFonts.textBoxCalibri16
        self.houseNumbertextfield.textColor=Colors.DustyGray155155155
        self.houseNumbertextfield.font=AppFonts.textBoxCalibri16
        self.cityTextfield.textColor=Colors.DustyGray155155155
        self.cityTextfield.font=AppFonts.textBoxCalibri16
        self.textState.textColor=Colors.DustyGray155155155
        self.textState.font=AppFonts.textBoxCalibri16
        self.zipTextfield.textColor=Colors.DustyGray155155155
        self.zipTextfield.font=AppFonts.textBoxCalibri16
        
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
        self.houseNumbertextfield.applyAttributesWithValues(placeholderText: "Apt/House/Unit No.*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.cityTextfield.applyAttributesWithValues(placeholderText: "City*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.textState.applyAttributesWithValues(placeholderText: "State*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.zipTextfield.applyAttributesWithValues(placeholderText: "Zip Code*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.streetAddress.setLeftPaddingPoints(19)
        self.houseNumbertextfield.setLeftPaddingPoints(19)
        self.cityTextfield.setLeftPaddingPoints(19)
        self.textState.setLeftPaddingPoints(19)
        self.zipTextfield.setLeftPaddingPoints(19)
        
        self.streetAddress.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.houseNumbertextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.cityTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.textState.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.zipTextfield.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
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
//MARK: UITextField Delegates
extension VerifyAddressViewController:UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (!(self.streetAddress.text?.isEmpty)! && !(self.houseNumbertextfield.text?.isEmpty)!) && !(self.cityTextfield.text?.isEmpty)! && !(self.textState.text?.isEmpty)! && !(self.zipTextfield.text?.isEmpty)!{
            if (Validations.isValidZip(value: self.zipTextfield.text!)){
                self.activateDoneBtn()
            }else{
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.ZIP_NOT_VALID.rawValue)
            }
        }//else if(textField==self.cityTextfield){
//            self.view.endEditing(true)
//            print("EndEditing")
//            textField.resignFirstResponder()
//        }
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if (textField==self.textState){
//            print("BeginEditing")
//            self.dropDown.show()
//        }
//    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == textState
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

extension VerifyAddressViewController:SignupSynapseDelegate{
    func didSignedUpSynapse(data:SignupSynapse){
        // Save data in user default
        let user:User = User.init(username: UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String, email: UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String, accesstoken: UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForAccessToken) as! String)
        user.authKey = data.data.oauthKey
        UserInformationUtility.sharedInstance.saveUser(model: user)
        
        // Delete email and accesstoken stored in UserDefault
        UserDefaults.removeUserDefaultForKey(AppConstants.UserDefaultKeyForEmail)
        self.moveToHomePage()
    }
    
    func moveToHomePage(){
        let containerViewController:MFSideMenuContainerViewController=MFSideMenuContainerViewController()
        var initialNavigationController:UINavigationController
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let sideMenu:SideMenuViewController = (storyBoard.instantiateViewController(withIdentifier: String(describing: SideMenuViewController.self)) as? SideMenuViewController)!
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        initialNavigationController = UINavigationController(rootViewController:homeViewController)
        sideMenu.delegate = homeViewController
        containerViewController.leftMenuViewController=sideMenu
        containerViewController.centerViewController=initialNavigationController
        containerViewController.setMenuWidth(UIScreen.main.bounds.size.width * 0.70, animated:true)
        containerViewController.shadow.enabled=true;
        containerViewController.panMode = MFSideMenuPanModeDefault
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = containerViewController
    }
}
