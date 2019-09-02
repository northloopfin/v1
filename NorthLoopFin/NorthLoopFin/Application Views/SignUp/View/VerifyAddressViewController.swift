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
import RealmSwift

class VerifyAddressViewController: BaseViewController {
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var houseNumbertextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var textState: UITextField!
    @IBOutlet weak var zipTextfield: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var customProgressView: ProgressView!

    @IBOutlet weak var doneBtn: CommonButton!
    
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    var signupFlowData:SignupFlowData!=nil
    var presenter: SignupSynapsePresenter!
    var zendeskPresenter: ZendeskPresenter!
    var accountInfoPresenter : AccountInfoPresenter!
    var verifiedAddress:VerifiedAddress?

    //var to keep track of which screen has initiated the process
    var screenThatInitiatedThisFlow:AppConstants.Screens?
    lazy var basicInfo: Results<BasicInfo> = RealmHelper.retrieveBasicInfo()

    var changeAddressPresnter:ChangeAddressPresenter!
    var checkAddressPresnter:CheckAddressPresenter!

    let dropDown = DropDown()
    let countryWithCode = AppUtility.getCountryList()
    
    
    
    
    func updateSignupFlowData(){
        if let _ = self.signupFlowData{
            let addressFromPreviousScreen:SignupFlowAddress = self.signupFlowData.address
            let addess:SignupFlowAddress = SignupFlowAddress.init(street: self.streetAddress.text!, city: self.cityTextfield.text!, state: self.textState.text!, zip: self.zipTextfield.text!,countty: addressFromPreviousScreen.country,houseNumber: self.houseNumbertextfield.text!)

            if let _  = self.signupFlowData{
                self.signupFlowData.address = addess
            }
        }
    }
    @IBAction func statesClicked(_ sender: Any) {
        dropDown.show()
    }
    
    fileprivate func convertDataToDicAndCallAPI() {
        if let _ = self.screenThatInitiatedThisFlow {
            if self.screenThatInitiatedThisFlow == AppConstants.Screens.CHANGEADDRESS {
                //call api to update address here
                let requestBody = self.createUpdateAddressRequestBody()
                let jsonEncoder = JSONEncoder()
                do {
                    let jsonData = try jsonEncoder.encode(requestBody)
                    let jsonString = String(data: jsonData, encoding: .utf8)
                    //print(jsonString!)
                    let dic:[String:AnyObject] = jsonString?.convertToDictionary() as! [String : AnyObject]
                    print(dic)
                    //all fine with jsonData here
                    self.changeAddressPresnter.sendChangeAddressRequest(requestDic: dic)
                } catch {
                    //handle errors
                    print(error)
                }
            }
        } else {
            self.persistDataRealm()
            self.updateSignupFlowData()
            UserDefaults.saveToUserDefault(AppConstants.Screens.HOME.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(self.signupFlowData)
                let jsonString = String(data: jsonData, encoding: .utf8)
                //print(jsonString!)
                var dic:[String:AnyObject] = jsonString?.convertToDictionary() as! [String : AnyObject]
                //all fine with jsonData here
//                self.setGifLoaderImage(withImageName: "createAcc.gif")
                
                for document in self.signupFlowData!.documents.virtualDocs{
                    if document.documentType.lowercased() == "ssn"{
                        dic["ssn"] = document.documentValue as AnyObject
                        if dic.keys.contains("passport"){
                            dic.removeValue(forKey: "passport")
                        }
                        if dic.keys.contains("arrival_date"){
                            dic.removeValue(forKey: "arrival_date")
                        }
                        if dic.keys.contains("university"){
                            dic.removeValue(forKey: "university")
                        }
                    }
                }
            
                self.presenter.startSignUpSynapse(requestDic: dic)
            } catch {
                //handle errors
                print(error)
            }
        }
    }
    
    fileprivate func convertDataForCheckAndCallAPI() {
        if let _ = self.screenThatInitiatedThisFlow {
            let requestBody = createCheckAddressRequestBody()
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(requestBody)
                let jsonString = String(data: jsonData, encoding: .utf8)
                let dic = jsonString?.convertToDictionary() as! [String:String]
                print(dic)
                self.checkAddressPresnter.sendCheckAddressRequest(requestDic:dic)
            } catch {
                print(error)
            }
        } else {
            self.convertDataToDicAndCallAPI()
        }
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        if (Validations.isValidZip(value: self.zipTextfield.text!)){
//            //delete all images from document directory
//            //StorageHelper.clearAllFileFromDirectory()
//            convertDataToDicAndCallAPI()
//        }else{
//            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.ZIP_NOT_VALID.rawValue)
//        }

            //delete all images from document directory
            //StorageHelper.clearAllFileFromDirectory()
            convertDataForCheckAndCallAPI()
        } else {
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.ZIP_NOT_VALID.rawValue)
        }
    }
    
    
    func createUpdateAddressRequestBody()->UpdateAddressRequestBody{
        let updatedAddress:UpdatedAddress = UpdatedAddress.init(houseNo: self.houseNumbertextfield.text ?? "", state: self.textState.text ?? "", street: self.streetAddress.text ?? "", city: self.cityTextfield.text ?? "", zip: self.zipTextfield.text ?? "", country: "US")
        let updateAddressRequestBody = UpdateAddressRequestBody.init(address: updatedAddress)
        return updateAddressRequestBody
    }
    
    func createCheckAddressRequestBody() -> CheckAddress {
        let checkAddress:CheckAddress = CheckAddress.init(
            street: self.streetAddress.text ?? "",
            city: self.cityTextfield.text ?? "",
            state: self.textState.text ?? "",
            zipcode: self.zipTextfield.text ?? "")
        return checkAddress
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureHud(size: CGSize.init(width: 400 , height: 400))
//        self.setGifLoaderImage(withImageName: "createAcc.gif")
        
        self.setupRightNavigationBar()
        self.doneBtn.isEnabled=false
        self.changeTextFieldAppearance()
        self.prepareView()
        self.presenter = SignupSynapsePresenter.init(delegate: self)
        self.zendeskPresenter = ZendeskPresenter.init(delegate: self)
        self.changeAddressPresnter = ChangeAddressPresenter.init(delegate: self)
        self.checkAddressPresnter = CheckAddressPresenter.init(delegate: self)
        accountInfoPresenter = AccountInfoPresenter.init(delegate: self)
        if let _ =  self.screenThatInitiatedThisFlow{
            if self.screenThatInitiatedThisFlow == AppConstants.Screens.CHANGEADDRESS{
                self.customProgressView.isHidden = true
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
       // self.configureHud(frame: CGRect.init(x: 0, y: 0, width: 300, height: 300))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Fetch from Realm if any
        self.fetchDatafromRealmIfAny()
    }
    
    func fetchDatafromRealmIfAny(){
        
        if self.basicInfo.count > 0{
            self.doneBtn.isEnabled=true
            let info = self.basicInfo.first!
            self.streetAddress.text = info.streetAddress
            self.houseNumbertextfield.text = info.houseNumber
            self.cityTextfield.text = info.city
            self.textState.text = info.state
            self.zipTextfield.text = info.zip
        }
    }
    
    //Save Data to DB
    func persistDataRealm(){
        let info:BasicInfo = BasicInfo()
        info.streetAddress = self.streetAddress.text!
        info.zip = self.zipTextfield.text ?? ""
        info.houseNumber=self.houseNumbertextfield.text ?? ""
        info.city=self.cityTextfield.text ?? ""
        info.state=self.textState.text ?? ""
        
        let result = RealmHelper.retrieveBasicInfo()
        print(result)
        if result.count > 0{
            RealmHelper.updateBasicInfo(infoToBeUpdated: result.first!, newInfo: info)
        }
    }
    
    /// Prepare View by setting up font and color of UI components
    func prepareView(){
        self.textState.inputView = UIView.init(frame: CGRect.zero)
        self.textState.inputAccessoryView = UIView.init(frame: CGRect.zero)
        self.textState.setRightIcon(UIImage.init(named: "chevron")!)
        
        self.customProgressView.progressView.setProgress(0.17*6, animated: true)
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
        }else{
            self.checkForMandatoryField()
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
    
    fileprivate func checkForMandatoryField() {
        if (!(self.streetAddress.text?.isEmpty)! && !(self.houseNumbertextfield.text?.isEmpty)!) && !(self.cityTextfield.text?.isEmpty)! && !(self.textState.text?.isEmpty)! && !(self.zipTextfield.text?.isEmpty)!{
                self.activateDoneBtn()
//
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkForMandatoryField()
    }

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
        user.userID = data.data.userID
        user.name = data.data.name
        UserInformationUtility.sharedInstance.saveUser(model: user)
        //remove data from local DB
        RealmHelper.deleteAllBasicInfo()
        RealmHelper.deleteAllScanID()
        RealmHelper.deleteAllSelfie()
        // Delete email and accesstoken stored in UserDefault
        UserDefaults.removeUserDefaultForKey(AppConstants.UserDefaultKeyForAccessToken)
        //call Zendesk API for Identity token
        self.zendeskPresenter.sendZendeskTokenRequest()
    }
}

extension VerifyAddressViewController:ZendeskDelegates{
    func didSentZendeskToken(data: ZendeskData) {
        AppUtility.configureZendesk(data: data)
        //AppUtility.moveToHomeScreen()
        RealmHelper.deleteAllFromDatabase()
        //call account-info API
        self.callAccountInfoAPI()
        
    }
    
    func callAccountInfoAPI(){
        self.moveToWaitList()
        self.accountInfoPresenter.getAccountInfo()
    }
    
    func moveToWaitList(){
        logEventsHelper.logEventWithName(name: "Signup", andProperties: ["Event": "Account Created"])
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WaitListViewController") as! WaitListViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension VerifyAddressViewController:ChangeAddressDelegate{
    func didAddressChanged() {
        AppUtility.moveToHomeScreen()
    }
}

extension VerifyAddressViewController:CheckAddressDelegate {
    func didVerifyAddress(_ verifiedAddress:VerifiedAddress) {
        self.verifiedAddress = verifiedAddress
        if compareAddress(verifiedAddress) {
            convertDataToDicAndCallAPI()
        } else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddressVerificationViewController") as! AddressVerificationViewController
            vc.delegate = self
            vc.dataSource = [
                    [
                        self.streetAddress.text ?? "",
                        self.houseNumbertextfield.text ?? "",
                        self.cityTextfield.text ?? "",
                        self.textState.text ?? "",
                        self.zipTextfield.text ?? ""
                    ],
                    [
                        verifiedAddress.street,
                        self.houseNumbertextfield.text ?? "",
                        verifiedAddress.city,
                        verifiedAddress.state,
                        verifiedAddress.zipcode
                    ]
                ]
            verifiedAddress.house = self.houseNumbertextfield.text ?? ""
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func compareAddress(_ verifiedAddress:VerifiedAddress) -> Bool {
        var isEqual = true
        if verifiedAddress.street != self.streetAddress.text {
            isEqual = false
        }
        if verifiedAddress.city != self.cityTextfield.text {
            isEqual = false
        }
        if verifiedAddress.state != self.textState.text {
            isEqual = false
        }
        if verifiedAddress.zipcode != self.zipTextfield.text {
            isEqual = false
        }
        return isEqual
    }
}

extension VerifyAddressViewController:AddressVerificationViewDelegate {
    func uprovedVerifiedAddress() {
        self.streetAddress.text = verifiedAddress?.street ?? ""
        self.cityTextfield.text = verifiedAddress?.city ?? ""
        self.textState.text = verifiedAddress?.state ?? ""
        self.zipTextfield.text = verifiedAddress?.zipcode ?? ""
        convertDataToDicAndCallAPI()
    }
}

extension VerifyAddressViewController:HomeDelegate{
    //MARK: HomeDelegate
    func didFetchedTransactionList(data: [TransactionListModel]) {
    }
    
    func didFetchedError(error:ErrorModel){
        if self.screenThatInitiatedThisFlow==AppConstants.Screens.CHANGEADDRESS{
        }else{
            self.moveToWaitList()
        }
    }
    
    func didFetchedAccountInfo(data:Account){
        // check isVerified key and open screen accordingly
        if data.data.isVerified{
            // yes user is verified..move to Home
            AppUtility.moveToHomeScreen()
        }else{
            //no..move to waitlist
            self.moveToWaitList()
        }
    }
        
}
