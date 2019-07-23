//
//  ScanIDNewViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 18/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import RealmSwift

class ScanIDNewViewController: BaseViewController {
    var threadLbl:String = "bgthread"
    @IBOutlet weak var uploadImage3HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var uploadImage2HeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var imageConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var selectYourIDLbl: LabelWithLetterSpace!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    
    @IBOutlet weak var uploadImageFrontLbl: LabelWithLetterSpace!
    @IBOutlet weak var uploadImageBackLbl: LabelWithLetterSpace!
    @IBOutlet weak var uploadImageExtraLbl: LabelWithLetterSpace!

    @IBOutlet weak var optionsStack: UIStackView!
    @IBOutlet weak var optionsView: UIScrollView!

    @IBOutlet weak var scanBackView: UIView!
    @IBOutlet weak var scanFrontView: UIView!
    @IBOutlet weak var uploadImage3: UIView!

    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var uploadedImageFront : UIImageView!
    @IBOutlet weak var uploadedImageBack : UIImageView!
    @IBOutlet weak var uploadedImageExtra : UIImageView!

    @IBOutlet weak var customProgressView: ProgressView!
    
    lazy var scanIDImages: Results<ScanIDImages> = RealmHelper.retrieveImages()

    var imageArray:[UIImage]=[]
    var selectedOption:AppConstants.SelectIDTYPES!
    var selectedButtonTag:Int=0
    var optionsArr:[AppConstants.SelectIDTYPES]=[AppConstants.SelectIDTYPES.PASSPORT,AppConstants.SelectIDTYPES.I20,AppConstants.SelectIDTYPES.F1VISA,AppConstants.SelectIDTYPES.ADDRESSPROOF]
    var model:SelectIDType!
    
    var modelArray:[SelectIDType]=[]
    var optionBtnsArray:[CommonButton] = []
    
    //var to define the state wether data coming from Realm DB
    var isGetDataFromDB:Bool = false
    var isSSNFlow:Bool = false
    var signupData:SignupFlowData!=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkForSSN()
        self.checkDBForImages()
        
        self.initialiseData()
        self.disableImageThumbTouch()
        self.prepareView()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Scan ID")
        self.renderIDOptions()
        self.addTapGesture()
    }
    
    //Initialise some dummy data initialially
    func initialiseData(){
        //loop through options
        for n in 0...(self.optionsArr.count-1){
            //check for type of option
            //let image = UIImage.init(named: "scanFrontId")
            let imagearr:[UIImage] = []
            let model:SelectIDType = SelectIDType.init(type: self.optionsArr[n], images: imagearr)
            self.modelArray.append(model)
//            if option == AppConstants.SelectIDTYPES.PASSPORT || option == AppConstants.SelectIDTYPES.F1VISA ||  option == AppConstants.SelectIDTYPES.USIDTYPE ||
//                option == AppConstants.SelectIDTYPES.ADDRESSPROOF{
//                // create data for these options. These options have single image
//
//
//            }else{
//                // create data for I-20. This option has three images
//
//                imagearr = [image!]
//            }
//            let model:SelectIDType = SelectIDType.init(type: option, images: imagearr)
//            self.modelArray.append(model)
        }
        
    }
    
    func checkForSSN(){
        if let _ = self.signupData{
            let ssnVirtualDoc = self.signupData.documents.virtualDocs.filter{$0.documentType == "SSN"}//self.modelArray.filter{$0.type == optionSelected}
            if (ssnVirtualDoc.count > 0){
                // it must be ssn doc..then change options
                self.optionsArr = [AppConstants.SelectIDTYPES.STATEID,AppConstants.SelectIDTYPES.DRIVERLICENSE,AppConstants.SelectIDTYPES.PASSPORT,AppConstants.SelectIDTYPES.OTHER]
                self.isSSNFlow=true
            }else{
                self.optionsArr = [AppConstants.SelectIDTYPES.PASSPORT,AppConstants.SelectIDTYPES.I20,AppConstants.SelectIDTYPES.F1VISA,AppConstants.SelectIDTYPES.ADDRESSPROOF]
                self.isSSNFlow=false
            }
        }
    }
    
    func checkDBForImages(){
        if scanIDImages.count > 0{
            var passportImages:[UIImage]=[]
            self.isGetDataFromDB=true
            self.nextBtn.isEnabled=true
            // loop through options array
            for n in 0...(self.optionsArr.count-1){
                for m in 0...(self.scanIDImages.count-1){
                    
                    let model = self.scanIDImages[m]
                    if model.type == self.optionsArr[n].rawValue{
                        print(StorageHelper.getImagePath(imgName: model.imagePath))
                        if let _ = StorageHelper.getImageFromPath(path: StorageHelper.getImagePath(imgName: model.imagePath)){
                            //passportImages.append(StorageHelper.getImageFromPath(path: imagesOfParticularScanID[m].imagePath)!)
                            
                            passportImages.append(StorageHelper.getImageFromPath(path: StorageHelper.getImagePath(imgName: model.imagePath))!)
                        }
                    }
                }
                let model = SelectIDType.init(type: self.optionsArr[n], images: passportImages)// self.modelArray[n]
                self.modelArray.append(model)
                // print(self.modelArray.count)
            }
            self.selectedOption = self.optionsArr[0]
            self.getImageFromDBForSelctedOption()
            self.setImages()
        }
//        DispatchQueue(label: threadLbl).async {
//            print("Fetch Saved Data")
//            let imagesFromDb = RealmHelper.retrieveImages()
//            DispatchQueue.main.async {
//                var passportImages:[UIImage]=[]
//                self.nextBtn.isEnabled=false
//
//                if imagesFromDb.count>0{
//                    self.isGetDataFromDB=true
//                    self.nextBtn.isEnabled=true
//                    // loop through options array
//                    for n in 0...(self.optionsArr.count-1){
//                        for m in 0...(imagesFromDb.count-1){
//
//                            let model = imagesFromDb[m]
//                            if model.type == self.optionsArr[n].rawValue{
//                                print(StorageHelper.getImagePath(imgName: model.imagePath))
//                                if let _ = StorageHelper.getImageFromPath(path: StorageHelper.getImagePath(imgName: model.imagePath)){
//                                    //passportImages.append(StorageHelper.getImageFromPath(path: imagesOfParticularScanID[m].imagePath)!)
//
//                                    passportImages.append(StorageHelper.getImageFromPath(path: StorageHelper.getImagePath(imgName: model.imagePath))!)
//                                }
//                            }
//                        }
//                        let model = SelectIDType.init(type: self.optionsArr[n], images: passportImages)// self.modelArray[n]
//                        self.modelArray.append(model)
//                        // print(self.modelArray.count)
//                    }
//                    self.selectedOption = self.optionsArr[0]
//                    self.getImageFromDBForSelctedOption()
//                    self.setImages()
//
//                }
//            }
//        }
    }
    ///Methode will set image array read from db
    func getImageFromDBForSelctedOption(){
        if let optionSelected = self.selectedOption{
            let model:SelectIDType = self.modelArray.filter{$0.type == optionSelected}[0]
            self.imageArray=model.images
        }
    }
    override func viewDidLayoutSubviews() {
        
    }
  
    func prepareView(){
        self.customProgressView.progressView.setProgress(0.17*3, animated: true)
        uploadImage3HeightConstraint.constant=0
        uploadImage2HeightConstraint.constant=0

        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.selectYourIDLbl.textColor = Colors.Cameo213186154
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.selectYourIDLbl.font = AppFonts.btnTitleCalibri18
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
    }
    
    func addTapGesture(){
        self.uploadedImageFront.callback = {
            // Some actions etc.
            self.tapped(self.uploadedImageFront)
        }
        self.uploadedImageBack.callback = {
            // Some actions etc.
            self.tapped(self.uploadedImageBack)
        }
        self.uploadedImageExtra.callback = {
            // Some actions etc.
            self.tapped(self.uploadedImageExtra)
        }
    }
    
    func  tapped(_ sender:UIImageView){
        //print("you tap image number : \(sender.view.tag)")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ImagePreviewViewController") as! ImagePreviewViewController
        vc.delegate=self
        switch sender.tag{
        case 0:
            vc.index=0
            vc.image=self.imageArray[0]
        case 1:
            vc.index=1
            vc.image=self.imageArray[1]
        case 2:
            vc.index=2
            vc.image=self.imageArray[2]
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func renderIDOptions(){
        self.optionsStack.spacing = 10.0
        
        for n in 0...(optionsArr.count-1) {
            let btn = CommonButton(type: .custom)
            btn.sizeToFit()
            btn.setTitle(optionsArr[n].rawValue, for: .normal)
            if self.isGetDataFromDB{
                btn.isBtnSelected=true
                btn.layer.borderWidth=0.0
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.backgroundColor = Colors.PurpleColor17673149
                btn.set(image: UIImage.init(named: "tick"), title: (btn.titleLabel?.text)!, titlePosition: .left, additionalSpacing: 10.0, state: .normal)
            }else{
                btn.setTitleColor(Colors.DustyGray155155155, for: .normal)
                btn.backgroundColor = Colors.Mercury226226226
                
                btn.layer.borderWidth=1.0
                btn.isBtnSelected=false
                
            }
            btn.layer.cornerRadius=5.0
            btn.layer.borderColor=Colors.Mercury226226226.cgColor
            btn.tag=n
            
            btn.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
            btn.addTarget(self, action: #selector(self.handleButton(_:)), for: .touchUpInside)
            self.optionBtnsArray.append(btn)
            print(self.optionBtnsArray.count)
            optionsStack.addArrangedSubview(btn)
        }
        // get first button from this array and trigger its touch event
        let selectedButton = self.optionBtnsArray[0]
        selectedButton.sendActions(for: .touchUpInside)
    }
    @objc func handleButton(_ sender: AnyObject) {
        //change background color and other UI
        let selectedButton=sender as! CommonButton
        self.selectedButtonTag = selectedButton.tag
        if selectedButton.isBtnSelected{
           // print(self.modelArray.count)
            print("selectedTag \(selectedButton.tag)")
                self.disableImageThumbTouch()
            if self.modelArray.count >= selectedButton.tag{
                let model = self.modelArray[selectedButton.tag]
                self.imageArray = model.images
                self.selectedOption = model.type
                self.setImages()
            }
        }else{
            print("selectedTag \(selectedButton.tag)")
            //get button from array and update its selection state
            let btn:CommonButton = self.optionBtnsArray[selectedButton.tag]
            btn.isBtnSelected=true
            //self.optionBtnsArray.insert(btn, at: selectedButton.tag)
            self.handleSelectedOption(selectedButton)
        }
    }
    ///Methode will handle the selected option and decide whether allow selection of next option or throw error and make some UI changes
    func handleSelectedOption(_ sender:CommonButton){
        if let optionSelected = self.selectedOption{
            
            if optionSelected == AppConstants.SelectIDTYPES.PASSPORT || optionSelected == AppConstants.SelectIDTYPES.F1VISA || optionSelected == AppConstants.SelectIDTYPES.USIDTYPE ||
                optionSelected == AppConstants.SelectIDTYPES.ADDRESSPROOF || optionSelected == AppConstants.SelectIDTYPES.STATEID || optionSelected == AppConstants.SelectIDTYPES.DRIVERLICENSE || optionSelected == AppConstants.SelectIDTYPES.OTHER{
                if self.imageArray.count < 1 {
                    print("show error for passport")
                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.COMPLETE_DOCUMENT_UPLOAD.rawValue)
                    return
                }
            }else{
                if self.imageArray.count < 3{
                    print("show error for I-20")
                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.COMPLETE_DOCUMENT_UPLOAD.rawValue)
                    return
                }
            }
        }
        self.resetImages()
        self.imageArray = []
        self.selectedOption = self.optionsArr[sender.tag]
        if self.selectedOption == AppConstants.SelectIDTYPES.I20{
            uploadImage3HeightConstraint.constant=60
            uploadImage2HeightConstraint.constant=60
            self.setLabelsForI20()
        }else{
            self.resetLabels()
            uploadImage3HeightConstraint.constant=0
            uploadImage2HeightConstraint.constant=0
        }
        self.view.layoutIfNeeded()
        sender.isBtnSelected=true
        sender.layer.borderWidth=0.0
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = Colors.PurpleColor17673149
        sender.set(image: UIImage.init(named: "tick"), title: (sender.titleLabel?.text)!, titlePosition: .left, additionalSpacing: 10.0, state: .normal)
    }
    /// Methode will reset Label text to original
    func resetLabels(){
        self.uploadImageFrontLbl.text = "Scan Front of ID"
        self.uploadImageBackLbl.text = "Scan Back of ID"
    }
    /// Methode will set lable text according to i-20 option
    func setLabelsForI20(){
        self.uploadImageFrontLbl.text = "Page 1"
        self.uploadImageBackLbl.text = "Page 2"
        self.uploadImageExtraLbl.text = "Page 3"
    }
        
    func setImages(){
        if self.selectedOption==AppConstants.SelectIDTYPES.PASSPORT || self.selectedOption==AppConstants.SelectIDTYPES.F1VISA || self.selectedOption==AppConstants.SelectIDTYPES.USIDTYPE ||
            self.selectedOption==AppConstants.SelectIDTYPES.ADDRESSPROOF || self.selectedOption==AppConstants.SelectIDTYPES.STATEID ||
            self.selectedOption==AppConstants.SelectIDTYPES.DRIVERLICENSE ||
            self.selectedOption==AppConstants.SelectIDTYPES.OTHER{
            self.uploadImage3HeightConstraint.constant=0
            self.uploadImage2HeightConstraint.constant=0
            self.resetLabels()
            self.view.layoutIfNeeded()
            if self.imageArray.count > 0{
                self.uploadedImageFront.image = self.imageArray[0]
            }
        }else{
            self.uploadImage3HeightConstraint.constant=60
            self.uploadImage2HeightConstraint.constant=60
            self.setLabelsForI20()
            self.view.layoutIfNeeded()
            if self.imageArray.count > 0{
            self.uploadedImageFront.image = self.imageArray[0]
            self.uploadedImageBack.image = self.imageArray[1]
            self.uploadedImageExtra.image = self.imageArray[2]
            }
        }
    }
    func resetImages(){
        self.uploadedImageBack.image=UIImage.init(named: "scanBackId")
        self.uploadedImageFront.image=UIImage.init(named: "scanFrontId")
        self.uploadedImageExtra.image=UIImage.init(named: "scanFrontId")
        
        self.uploadedImageFront.tappable=false
        self.uploadedImageBack.tappable=false
        self.uploadedImageExtra.tappable=false
    }
    @IBAction func nextClicked(_ sender: Any) {
        // move to Selfie Screen
        self.showErrForSelectedOptions()
        
//        UserDefaults.saveToUserDefault(AppConstants.Screens.SELFIETIME.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "SelfieViewController") as! SelfieViewController
//        vc.signupFlowData=self.signupData
//        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func saveImageInDB(){
        
        for n in 0...(self.modelArray.count-1){
            
            //loop through image array of this model
            //Also create name with help of array index and model type
            let scanIDModel = self.modelArray[n]
            let imagesArr = self.modelArray[n].images
            if imagesArr.count > 0{
            for n in 0...(imagesArr.count-1){
                let imagedata:Data = imagesArr[n].jpegData(compressionQuality: 0.5)!
                let filename:String = scanIDModel.type.rawValue+String(n)+".jpg"
                print(filename)
                //Store this image data to document directory
                StorageHelper.saveImageDocumentDirectory(fileName: filename, data: imagedata)
                //create ScanIDTypes model to save into DB
                let modelToSaveInDB:ScanIDImages = ScanIDImages()
                modelToSaveInDB.email=UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String
                modelToSaveInDB.type = scanIDModel.type.rawValue
                modelToSaveInDB.imagePath=filename//StorageHelper.getImagePath(imgName: filename)
                RealmHelper.addScanIDInfo(info: modelToSaveInDB)
            }
        }
    }
    }
    
    func showErrForSelectedOptions(){
        
        //check for SSN flow
        
        if let _ = self.signupData{
            if self.signupData.documents.virtualDocs.count == 0{
                // yes NON SSN Flow
                if let optionSelected = self.selectedOption{
                    
                    if optionSelected == AppConstants.SelectIDTYPES.PASSPORT || optionSelected == AppConstants.SelectIDTYPES.F1VISA ||  optionSelected == AppConstants.SelectIDTYPES.USIDTYPE ||
                        optionSelected == AppConstants.SelectIDTYPES.ADDRESSPROOF || optionSelected == AppConstants.SelectIDTYPES.STATEID || optionSelected == AppConstants.SelectIDTYPES.DRIVERLICENSE || optionSelected == AppConstants.SelectIDTYPES.OTHER{
                        if self.imageArray.count < 1 {
                            print("show error for passport")
                            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.COMPLETE_DOCUMENT_UPLOAD.rawValue)
                            return
                        }
                    }else{
                        if self.imageArray.count < 3{
                            print("show error for I-20")
                            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.COMPLETE_DOCUMENT_UPLOAD.rawValue)
                            return
                        }
                    }
                }
            }
        }
        self.saveImageInDB()
        self.updateSignupFlowDataWithCompressedImages()
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
                UserDefaults.saveToUserDefault(AppConstants.Screens.SELFIETIME.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "SignupStepConfirm") as! SignupStepConfirm
                vc.signupFlowData=self.signupData
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    
    // This methode is converting image to base 64 string and update SignupFlowData model by adding them to model
    func formSignupFlowData(){
        var arrayOfScannedDocuments:[SignupFlowAlDoc]=[]
        for n in 0...(self.modelArray.count-1){
            let scanIDModel = self.modelArray[n]
            //let imagesArr = scanIDModel.images
            //Prepare data for document
            if scanIDModel.images.count > 0{
            for m in 0...(scanIDModel.images.count-1){
                let image = scanIDModel.images[m]
                do {
                    // compress here
                    try image.compressImage(500, completion: { (image, compressRatio) in
                        let base64Image=image.toBase64();
                        //let fullBase64String = "data:image/gif;base64,R0lGODlhAQABAAAAACw="
                        let fullBase64String = String(format:"data:image/png;base64,%@",base64Image ?? "")
                        //print(fullBase64String)
                        var doc:SignupFlowAlDoc = SignupFlowAlDoc.init(documentValue: fullBase64String, documentType: "OTHER")//scanIDModel.type.rawValue)
                        //check for ID Type and assign document type accordingly
                        if scanIDModel.type == AppConstants.SelectIDTYPES.ADDRESSPROOF{
                            doc = SignupFlowAlDoc.init(documentValue: fullBase64String, documentType: "PROOF_OF_ADDRESS")
                        }else if scanIDModel.type == AppConstants.SelectIDTYPES.PASSPORT{
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
        //save data to SignupFlowData
        if let _ = self.signupData{
            self.signupData.documents.physicalDocs = arrayOfScannedDocuments
        }
        if let _ = self.signupData{
            let legalName:[String] = self.signupData.legalNames
            let fullName = legalName[0]
            self.signupData.documents.name = fullName
        }
    }
    
    @IBAction func takeImageClicked(_ sender: Any) {
        if let _ = self.selectedOption{
            openCamera(sender)
        }else{
            // show error
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.SELECT_ID_TYPE.rawValue)
        }
    }
    //Open Camera
        func openCamera(_ sender: Any){
            CameraHandler.shared.showActionSheet(vc: self)
            CameraHandler.shared.imagePickedBlock = { (image) in
               
                let btn = sender as! UIButton
                if self.imageArray.count < 1{
                    self.imageArray.append(image)
                }else{
                    if self.imageArray.indices.contains(btn.tag){
                        // yes exist
                        self.imageArray[btn.tag] = image
                    }else{
                        self.imageArray.append(image)
                    }
                    
                }
                
                //self.imageArray.insert(image, at: btn.tag)
                switch btn.tag {
                case 0:
                    self.uploadedImageFront.image=image
                    self.uploadedImageFront.tappable=true
                case 1:
                    self.uploadedImageBack.image=image
                    self.uploadedImageBack.tappable=true

                case 2:
                    self.uploadedImageExtra.image=image
                    self.uploadedImageExtra.tappable=true

                default:
                    break
                }
                
                self.addSelectedImagesToModel()
                self.checkForCompletedStateOfScanId()
            }
        }
    fileprivate func addSelectedImagesToModel() {
        if let optionSelected = self.selectedOption{
            
            if optionSelected == AppConstants.SelectIDTYPES.PASSPORT || optionSelected == AppConstants.SelectIDTYPES.F1VISA ||  optionSelected == AppConstants.SelectIDTYPES.USIDTYPE ||
                optionSelected == AppConstants.SelectIDTYPES.ADDRESSPROOF ||
                optionSelected ==  AppConstants.SelectIDTYPES.STATEID ||
                optionSelected == AppConstants.SelectIDTYPES.DRIVERLICENSE ||
                optionSelected == AppConstants.SelectIDTYPES.OTHER{
                if self.imageArray.count == 1{
                    //check whether model exist in array
                    if let index = self.modelArray.index(where: { $0.type == optionSelected }){
                    //yes it exist
                    let selectedOptionData = self.modelArray[index]
                    selectedOptionData.images = self.imageArray
                    }
                    if !self.isSSNFlow{
                        if selectedButtonTag != self.optionBtnsArray.count-1{
                            let nextBtnToEnable = self.optionBtnsArray[selectedButtonTag+1]
                            nextBtnToEnable.sendActions(for: .touchUpInside)
                        }
                    }
                }
                
//                if self.imageArray.count == 1 {
//                    //check whether model exist in array
//                    if let index = self.modelArray.index(where: { $0.type == optionSelected }){
//                        //yes it exist
//                        let selectedOptionData = self.modelArray[index]
//                        selectedOptionData.images = self.imageArray
//                    }else{
//                        let model = SelectIDType.init(type: optionSelected, images: self.imageArray)
//                        self.modelArray.append(model)
//                        if selectedButtonTag != self.optionBtnsArray.count-1{
//                            let nextBtnToEnable = self.optionBtnsArray[selectedButtonTag+1]
//                            nextBtnToEnable.sendActions(for: .touchUpInside)}
//                    }
//
//
//                    // disable touch for image thumbnail
//                    self.disableImageThumbTouch()
//                }
                
            }else{
                
                if self.imageArray.count == 3{
                    if let index = self.modelArray.index(where: { $0.type == optionSelected }){
                        //yes it exist
                        let selectedOptionData = self.modelArray[index]
                        selectedOptionData.images = self.imageArray
                        
                    }
                    if !self.isSSNFlow{
                        if selectedButtonTag != self.optionBtnsArray.count-1{
                            let nextBtnToEnable = self.optionBtnsArray[selectedButtonTag+1]
                            nextBtnToEnable.sendActions(for: .touchUpInside)
                        }
                    }
                }
//                if self.imageArray.count == 3{
//
//                    if let index = self.modelArray.index(where: { $0.type == optionSelected }){
//                        //yes it exist
//                        let selectedOptionData = self.modelArray[index]
//                        selectedOptionData.images = self.imageArray
//                    }else{
//                        let model = SelectIDType.init(type: optionSelected, images: self.imageArray)
//                        self.modelArray.append(model)
//                        let nextBtnToEnable = self.optionBtnsArray[selectedButtonTag+1]
//                        nextBtnToEnable.sendActions(for: .touchUpInside)
//                    }
//                    // disable touch for image thumbnail
//                    self.disableImageThumbTouch()
//                }
            }
           
            self.disableImageThumbTouch()
        }
    }
    
    /// This function will check whether images of all scan ID has been uploaded or not. If so, then enable next button
        func checkForCompletedStateOfScanId(){
            
            // check whether its ssn user
            if let _ = self.signupData{
                if (self.signupData.documents.virtualDocs.count == 1){
                    // yes it is, then only one documnet upload is sufficient
                    if self.modelArray[0].images.count > 0{
                     //1 document has been uploaded
                        self.nextBtn.isEnabled=true
                    }
                }else{
                    // Non SSN User
                        self.nextBtn.isEnabled=true
                }
            }
        }
            
    func disableImageThumbTouch(){
        self.uploadedImageBack.tappable  = false
        self.uploadedImageExtra.tappable  = false
        self.uploadedImageFront.tappable  = false
    }
}
            
            

extension ScanIDNewViewController:ImagePreviewDelegate{
    func imageUpdatedFor(index: Int, image:UIImage){
        if self.imageArray.count > 1{
            self.imageArray.append(image)
        }else{
            self.imageArray[index]=image
        }
        //self.imageArray.insert(image, at: index)
        self.refreshImages(image: image, index: index)
    }
    
    func refreshImages(image:UIImage,index:Int){
        switch index {
        case 0:
            self.uploadedImageFront.tappable=true
            self.uploadedImageFront.image=image
        case 1:
            self.uploadedImageBack.tappable=true
            self.uploadedImageBack.image=image
        case 2:
            self.uploadedImageExtra.tappable=true
            self.uploadedImageExtra.image=image
        default:
            break
            
        }
    }
}

