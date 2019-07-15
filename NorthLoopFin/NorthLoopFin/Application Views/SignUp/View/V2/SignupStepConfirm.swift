//
//  SignupStepConfirm.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 16/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import DropDown
import RealmSwift


class SignupStepConfirm: BaseViewController {
    
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var passportTextField: UITextField!
    @IBOutlet weak var DOBTextField: UITextField!
    @IBOutlet weak var universityTextField: UITextField!
    @IBOutlet weak var arrivalDate: UITextField!

    lazy var basicInfo: Results<BasicInfo> = RealmHelper.retrieveBasicInfo()
    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var customProgressView: ProgressView!

    let datePicker = UIDatePicker()
    var signupFlowData:SignupFlowData!=nil
    var presenter: UniversityPresenter!
    let dropDown = DropDown()
    var universities:[String]=[]
    
    @IBAction func nextClicked(_ sender: Any) {
        self.validateForm()
    }
    //validation form here
    
    func validateForm(){
        
        if Validations.isValidDob(dateString: self.DOBTextField.text ?? ""){
            self.saveDataToRealm()
            //update SignupFlowdata
            self.updateSignupFlowData()
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyAddressViewController") as! VerifyAddressViewController
            vc.signupFlowData=self.signupFlowData
            self.navigationController?.pushViewController(vc, animated: false)
        }else{
            //show error for age
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.DOB_NOT_VALID.rawValue)
        }
    }
    //adding values to model class
    func updateSignupFlowData(){
        if let _ = self.signupFlowData{
            self.signupFlowData.passport=self.passportTextField.text!
            self.signupFlowData.university=self.universityTextField.text!
            self.signupFlowData.documents.email = self.signupFlowData.email
            self.signupFlowData.documents.phoneNumber = self.signupFlowData.phoneNumbers[0]
            // get milliseconds from date entered for arrival
            let arrivaleDate = AppUtility.datefromStringUsingCalender(date: self.arrivalDate.text ?? "")
            self.signupFlowData.arrivalDate = String(arrivaleDate.millisecondsSince1970)
            let DOBArr = self.DOBTextField.text!.components(separatedBy: "/")
            self.signupFlowData.documents.day = Int(DOBArr[0]) ?? 0
            self.signupFlowData.documents.month = Int(DOBArr[1]) ?? 0
            self.signupFlowData.documents.year = Int(DOBArr[2]) ?? 0
            // add passport as virtual document
            
            let passport:SignupFlowAlDoc = SignupFlowAlDoc.init(documentValue: self.passportTextField.text!, documentType: "PASSPORT")
            let documents:SignupFlowDocument=self.signupFlowData.documents
            documents.virtualDocs.append(passport)
        }
        
    }
    
    // Life Cycle of Controller
    override func viewDidLoad() {
        self.nextBtn.isEnabled=false
        self.prepareView()
        self.updateTextFieldUI()
        self.setupRightNavigationBar()
        self.presenter = UniversityPresenter.init(delegate: self)
        //self.presenter.sendFEtchUniversityListRequest()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.retrieveDataFromDB()
    }
    
    func prepareView(){
       // self.universityTextField.inputView = UIView.init(frame: CGRect.zero)
        //self.universityTextField.inputAccessoryView = UIView.init(frame: CGRect.zero)
        //dropDown.anchorView = self.universityTextField
        //dropDown.dataSource = self.universities
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            self.universityTextField.text=item
//            self.dropDown.hide()
//            self.checkForMandatoryFields()
//            
//        }
        self.customProgressView.progressView.setProgress(0.17*5, animated: true)
        self.DOBTextField.inputView = UIView.init(frame: CGRect.zero)
        self.DOBTextField.inputAccessoryView = UIView.init(frame: CGRect.zero)
        self.arrivalDate.inputView = UIView.init(frame: CGRect.zero)
        self.arrivalDate.inputAccessoryView = UIView.init(frame: CGRect.zero)
        //Set text color to view components
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.passportTextField.textColor = Colors.DustyGray155155155
        self.DOBTextField.textColor = Colors.DustyGray155155155
        self.arrivalDate.textColor = Colors.DustyGray155155155
        self.universityTextField.textColor = Colors.DustyGray155155155
        
        
        // Set Font to view components
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.passportTextField.font = AppFonts.textBoxCalibri16
        self.DOBTextField.font = AppFonts.textBoxCalibri16
        self.arrivalDate.font = AppFonts.textBoxCalibri16
        self.universityTextField.font = AppFonts.textBoxCalibri16
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
        
    }
    
    func updateTextFieldUI(){
        self.passportTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.DOBTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.arrivalDate.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.universityTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        //self.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        let placeholderColor=Colors.DustyGray155155155
        let placeholderFont = UIFont.init(name: "Calibri", size: 16)
        let textfieldBorderColor = Colors.Mercury226226226
        let textFieldBorderWidth = 1.0
        let textfieldCorber = 5.0
        
        self.passportTextField.applyAttributesWithValues(placeholderText: "Passport Number*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.DOBTextField.applyAttributesWithValues(placeholderText: "Date of Birth (dd/mm/yyyy)*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.arrivalDate.applyAttributesWithValues(placeholderText: "Arrival Date (dd/mm/yyyy) optional", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        self.universityTextField.applyAttributesWithValues(placeholderText: "University*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        //self.emailTextField.applyAttributesWithValues(placeholderText: "Phone No*", placeholderColor: placeholderColor, placeHolderFont: placeholderFont!, textFieldBorderColor: textfieldBorderColor, textFieldBorderWidth: CGFloat(textFieldBorderWidth), textfieldCorber: CGFloat(textfieldCorber))
        
        self.passportTextField.setLeftPaddingPoints(19)
        self.DOBTextField.setLeftPaddingPoints(19)
        self.arrivalDate.setLeftPaddingPoints(19)
        self.universityTextField.setLeftPaddingPoints(19)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.nextBtn.isEnabled=false
        }else{
            self.checkForMandatoryFields()
        }
    }
    
    // DB Operations
    
    func saveDataToRealm(){
        let info:BasicInfo = BasicInfo()
        info.passportNumber=self.passportTextField.text ?? ""
        info.DOB=self.DOBTextField.text ?? ""
        info.arrivalDate = self.arrivalDate.text ?? ""
        info.university=self.universityTextField.text ?? ""
        let result = RealmHelper.retrieveBasicInfo()
        print(result)
        if result.count > 0{
            RealmHelper.updateBasicInfo(infoToBeUpdated: result.first!, newInfo: info)
        }
    }
    
    func retrieveDataFromDB(){
        //let result = RealmHelper.retrieveBasicInfo()
        if self.basicInfo.count > 0{
            //self.nextBtn.isEnabled=true
            let info = self.basicInfo.first!
            self.passportTextField.text = info.passportNumber
            self.DOBTextField.text = info.DOB
            self.universityTextField.text = info.university
            self.arrivalDate.text = info.arrivalDate
            self.checkForMandatoryFields()
        }
        self.setSampleData()
    }
    
    //Methode to show date picker
    func showDatePicker(tag: Int){
        //Format Date
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker(view:)));
        doneButton.tag = tag
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        self.DOBTextField.inputAccessoryView = toolbar
        self.DOBTextField.inputView = datePicker
        self.arrivalDate.inputAccessoryView = toolbar
        self.arrivalDate.inputView = datePicker
    }
    
    @objc func donedatePicker(view:UIBarButtonItem){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        if view.tag == 0{
            self.DOBTextField.text = formatter.string(from: datePicker.date)

        }else{
            self.arrivalDate.text = formatter.string(from: datePicker.date)

        }
        //view.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func setSampleData(){
        self.passportTextField.text="777772222"
        self.DOBTextField.text="11/05/1989"
        self.universityTextField.text = "Cornell University"
    }
}


extension SignupStepConfirm:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.checkForMandatoryFields()
    }
    
    //check for mandatory fields
    func checkForMandatoryFields(){
        if (!(self.passportTextField.text?.isEmpty)! && !(self.DOBTextField.text?.isEmpty)! && !(self.universityTextField.text?.isEmpty)!
            )
        {
            self.nextBtn.isEnabled=true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.DOBTextField{
            self.showDatePicker(tag: 0)
        }else if textField == self.arrivalDate{
            self.showDatePicker(tag: 1)
        }
    }

}

extension SignupStepConfirm: FetchUniversityDelegates{
    //remove once confirmed
    func didFetchedUniversityList(data:[String]) {
        self.universities=data
        self.dropDown.dataSource = self.universities
    }
}
