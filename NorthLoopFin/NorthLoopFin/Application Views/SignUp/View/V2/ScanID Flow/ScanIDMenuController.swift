//
//  ScanIDMenuController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 19/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import RealmSwift

class ScanIDMenuController: BaseViewController {

    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var customProgressView: ProgressView!
    @IBOutlet weak var btnNext: RippleButton!
    
    var optionArray:[clsScanOption] = []
    var dicTypeImages = Dictionary<String,[UIImage]>()

    var isGetDataFromDB:Bool = false
    var isSSNFlow:Bool = false
    var signupData:SignupFlowData!=nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.configureTableView()
        self.prepareView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.retrieveDBImages()
        self.setBtnNextState(false)
    }
    
    func prepareView(){
        self.customProgressView.progressView.setProgress(0.17*3, animated: true)
    }
    
    func updateSignupFlowDataWithCompressedImages(){
        // self.showLoader()
        DispatchQueue.global(qos: .userInitiated).async {
            // Do some time consuming task in this background thread
            // Mobile app will remain to be responsive to user actions
            
            print("Performing time consuming task in this background thread")
            self.formSignupFlowData()
            DispatchQueue.main.async {
                // Task consuming task has completed
                // Update UI from this block of code
                print("Time consuming task has completed. From here we are allowed to update user interface.")
                //self.hideLoader()
                logEventsHelper.logEventWithName(name: "Signup", andProperties: ["Event": "Upload Docs"])
                UserDefaults.saveToUserDefault(AppConstants.Screens.SELFIETIME.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "SignupStepConfirm") as! SignupStepConfirm
                vc.signupFlowData=self.signupData
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }

    func formSignupFlowData(){
        var arrayOfScannedDocuments:[SignupFlowAlDoc]=[]
        for n in 0...(self.optionArray.count-1){
            let scanIDModel = self.optionArray[n]
            
            if dicTypeImages.keys.contains(scanIDModel.title){
                let images:[UIImage] = dicTypeImages[scanIDModel.title]!
                if images.count > 0{
                    for m in 0...(images.count-1){
                        let image = images[m]
                        do {
                            // compress here
                            try image.compressImage(500, completion: { (image, compressRatio) in
                                let base64Image=image.toBase64();
                                //let fullBase64String = "data:image/gif;base64,R0lGODlhAQABAAAAACw="
                                let fullBase64String = String(format:"data:image/png;base64,%@",base64Image ?? "")
                                //print(fullBase64String)
                                var doc:SignupFlowAlDoc = SignupFlowAlDoc.init(documentValue: fullBase64String, documentType: "OTHER")//scanIDModel.type.rawValue)
                                //check for ID Type and assign document type accordingly
                                if scanIDModel.title == AppConstants.SelectIDTYPES.ADDRESSPROOF.rawValue{
                                    doc = SignupFlowAlDoc.init(documentValue: fullBase64String, documentType: "PROOF_OF_ADDRESS")
                                }else if scanIDModel.title == AppConstants.SelectIDTYPES.PASSPORT.rawValue{
                                    doc = SignupFlowAlDoc.init(documentValue: fullBase64String, documentType: "GOVT_ID")
                                }
                                arrayOfScannedDocuments.append(doc)
                            })
                        }catch {
                            print("Error")
                        }
                    }
                }
            }
        }
        if let _ = self.signupData{
            self.signupData.documents.physicalDocs = arrayOfScannedDocuments
        }
        if let _ = self.signupData{
            let legalName:[String] = self.signupData.legalNames
            let fullName = legalName[0]
            self.signupData.documents.name = fullName
        }
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        self.setBtnNextState(true)
        if self.btnNext.isEnabled{
            self.updateSignupFlowDataWithCompressedImages()
        }
    }
    
    func setBtnNextState(_ forAlert: Bool){
        var isEnabled = true
        for name in [AppConstants.SelectIDTYPES.PASSPORT.rawValue, AppConstants.SelectIDTYPES.I20.rawValue, AppConstants.SelectIDTYPES.F1VISA.rawValue, AppConstants.SelectIDTYPES.ADDRESSPROOF.rawValue] {
            if dicTypeImages.keys.contains(name){
                let images:[UIImage] = dicTypeImages[name]!
                if (name == AppConstants.SelectIDTYPES.I20.rawValue && images.count < 3) || (images.count == 0){
                    isEnabled = false
                    if forAlert{
                        self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.COMPLETE_DOCUMENT_UPLOAD_OF.rawValue + name)
                    }
                    break
                }
            }else{
                isEnabled = false
                break
            }
        }
        self.btnNext.isEnabled = isEnabled
    }
    
    func retrieveDBImages(){
        dicTypeImages.removeAll()
        let scanIDImages: Results<ScanIDImages> = RealmHelper.retrieveImages()
        if scanIDImages.count > 0{
            for m in 0...(scanIDImages.count-1){
                var images:[UIImage]=[]

                let model = scanIDImages[m]
                if dicTypeImages.keys.contains(model.type){
                    images = dicTypeImages[model.type]!
                }
                
                print(StorageHelper.getImagePath(imgName: model.imagePath))
                if let _ = StorageHelper.getImageFromPath(path: StorageHelper.getImagePath(imgName: model.imagePath)){
                    images.append(StorageHelper.getImageFromPath(path: StorageHelper.getImagePath(imgName: model.imagePath))!)
                }

                dicTypeImages[model.type] = images
            }
            //            typeData = SelectIDType.init(type: typeData.type, images: images)// self.modelArray[n]
        }
    }
}


extension ScanIDMenuController:UITableViewDelegate,UITableViewDataSource {
    
    func configureTableView() {
        optionArray.append(clsScanOption(AppConstants.SelectIDTYPES.PASSPORT.rawValue, "Front page", "ic_passport"))
        optionArray.append(clsScanOption(AppConstants.SelectIDTYPES.I20.rawValue, "All 3 pages", "ic_i20"))
        optionArray.append(clsScanOption(AppConstants.SelectIDTYPES.F1VISA.rawValue, "Canadian citizens can use their I-94", "ic_student_visa"))
        optionArray.append(clsScanOption(AppConstants.SelectIDTYPES.ADDRESSPROOF.rawValue, "e.g. Lease, utility bill, form assignment", "ic_address_proof"))
        self.menuTable.rowHeight = 82;
        self.menuTable.delegate = self
        self.menuTable.dataSource = self
        self.menuTable.registerTableViewCell(tableViewCell: ScanOptionCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScanOptionCell") as! ScanOptionCell
        cell.bindData(option: optionArray[indexPath.row])

        let bgColorView = UIView()
        bgColorView.backgroundColor = .white
        cell.selectedBackgroundView = bgColorView

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 82
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let option = optionArray[indexPath.row]
        var identifier = ""
        if option.title ==  AppConstants.SelectIDTYPES.PASSPORT.rawValue{
            identifier = "ScanPassportController"
        }else if option.title ==  AppConstants.SelectIDTYPES.I20.rawValue{
            identifier = "ScanI20Controller"
        }else if option.title ==  AppConstants.SelectIDTYPES.F1VISA.rawValue{
            identifier = "ScanVisaController"
        }else if option.title ==  AppConstants.SelectIDTYPES.ADDRESSPROOF.rawValue{
            identifier = "ScanAddressProofController"
        }
        
        if identifier.count > 0{
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: identifier) else { return  }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

