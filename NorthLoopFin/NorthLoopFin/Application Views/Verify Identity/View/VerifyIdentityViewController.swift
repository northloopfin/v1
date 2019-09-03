//
//  VerifyIdentityViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 11/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import RealmSwift

class VerifyIdentityViewController: BaseViewController {

    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var SSNTextField: UITextField!
    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var discriptionLabel: LabelWithLetterSpace!
    @IBOutlet weak var vwProgress: ProgressView!
    
    lazy var basicInfo: Results<BasicInfo> = RealmHelper.retrieveBasicInfo()
    var signupFlowData:SignupFlowData! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.vwProgress.progressView.setProgress(0.17*3, animated: true)
        self.nextBtn.isEnabled=false
        self.SSNTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged);
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Fetch from Realm if any
        self.fetchDatafromRealmIfAny()
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        self.nextBtn.isEnabled = textField.text!.count > 0
    }
    
    func validateSSN(){
        if !((self.SSNTextField.text?.isEmpty)!){
            //its not empty so validate phone
            if Validations.isValidSSN(ssn: self.SSNTextField.text ?? ""){
                let ssnData:SignupFlowAlDoc = SignupFlowAlDoc.init(documentValue: self.SSNTextField.text!, documentType: "SSN")
                if let data = self.signupFlowData{
                    let documents:SignupFlowDocument=self.signupFlowData.documents
                        documents.virtualDocs=[ssnData]
                        data.documents=documents
                        data.cipTag=3
                    self.moveToSignupStepThree(withData: self.signupFlowData)
                }
            }else{
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.SSN_NOT_VALID.rawValue)
            }
        }
    }
    
    func fetchDatafromRealmIfAny(){
        if self.basicInfo.count > 0{
            //            self.nextBtn.isEnabled=true
            let info = self.basicInfo.first!
            self.SSNTextField.text = info.ssn
            textFieldDidChange(textField: self.SSNTextField)
        }
    }
    
    func moveToSignupStepThree(withData:SignupFlowData){
        let basicInfo:BasicInfo=BasicInfo()
        basicInfo.email=UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String
        basicInfo.ssn=self.SSNTextField.text ?? ""
        let result = RealmHelper.retrieveBasicInfo()
        if result.count > 0{
            RealmHelper.updateBasicInfo(infoToBeUpdated: result.first!, newInfo: basicInfo)
        }

        logEventsHelper.logEventWithName(name: "Signup", andProperties: ["Event": "Enters Info"])
        if withData.cipTag == 2 {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ScanIDMenuController") as! ScanIDMenuController
            vc.signupData=withData
            self.navigationController?.pushViewController(vc, animated: false)
        }else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ScanIDController") as! ScanIDController
            vc.signupData=withData
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

    @IBAction func btnSkip_clicked(_ sender: UIButton) {
        if let data = self.signupFlowData{
            let documents:SignupFlowDocument=self.signupFlowData.documents
            documents.virtualDocs=[]
            data.documents=documents
            data.cipTag=2
        }
        self.moveToSignupStepThree(withData: self.signupFlowData)
    }
    
    @IBAction func btnNext_clicked(_ sender: UIButton) {
        validateSSN()
    }
}
