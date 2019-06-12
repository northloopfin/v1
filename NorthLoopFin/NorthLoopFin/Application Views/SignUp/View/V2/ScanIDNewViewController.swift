//
//  ScanIDNewViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 18/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ScanIDNewViewController: BaseViewController {
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

    var imageArray:[UIImage]=[]
    var selectedOption:AppConstants.SelectIDTYPES!
    var optionsArr:[AppConstants.SelectIDTYPES]=[AppConstants.SelectIDTYPES.PASSPORT,AppConstants.SelectIDTYPES.I20,AppConstants.SelectIDTYPES.F1VISA,AppConstants.SelectIDTYPES.ADDRESSPROOF]
    var model:SelectIDType!
    
    var modelArray:[SelectIDType]=[]
    var optionBtnsArray:[CommonButton] = []
    
    //var to define the state wether data coming from Realm DB
    var isGetDataFromDB:Bool = false
    var signupData:SignupFlowData!=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkForSSN()
        self.prepareView()
        self.checkDBForImages()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Scan ID")
        self.renderIDOptions()
        self.addTapGesture()
    }
    
    func checkForSSN(){
        if let _ = self.signupData{
            if (self.signupData.documents.virtualDocs.count == 1){
                // it must be ssn doc..then change options
                self.optionsArr = [AppConstants.SelectIDTYPES.USIDTYPE,AppConstants.SelectIDTYPES.I20,AppConstants.SelectIDTYPES.F1VISA,AppConstants.SelectIDTYPES.ADDRESSPROOF]
            }else{
                self.optionsArr = [AppConstants.SelectIDTYPES.PASSPORT,AppConstants.SelectIDTYPES.I20,AppConstants.SelectIDTYPES.F1VISA,AppConstants.SelectIDTYPES.ADDRESSPROOF]
            }
        }
    }
    
    func checkDBForImages(){
        let imagesFromDb = RealmHelper.retrieveImages()
        var passportImages:[UIImage]=[]
        self.nextBtn.isEnabled=false

        if imagesFromDb.count>0{
            self.isGetDataFromDB=true
            self.nextBtn.isEnabled=true
            // loop through options array
            for n in 0...(self.optionsArr.count-1){
                //loop through images stored in db to find out images for particular type
                let imagesOfParticularScanID=imagesFromDb.filter{$0.type == self.optionsArr[n].rawValue}
                print(imagesOfParticularScanID.count)
                //loop through images of particularScanID and add them to model array
                //Create object of that particular scan id
                for m in 0...(imagesOfParticularScanID.count-1){
                    if let _ = StorageHelper.getImageFromPath(path: imagesOfParticularScanID[m].imagePath){
                        passportImages.append(StorageHelper.getImageFromPath(path: imagesOfParticularScanID[m].imagePath)!)
                    }
                }
                let model :SelectIDType = SelectIDType.init(type: self.optionsArr[n], images: passportImages)
                self.modelArray.append(model)
            }
            self.selectedOption = self.optionsArr[0]
            self.getImageFromDBForSelctedOption()
            self.setImages()

        }
    }
    ///Methode will set image array read from db
    func getImageFromDBForSelctedOption(){
        if let optionSelected = self.selectedOption{
//            for n in 0...(self.optionsArr.count-1){
//                if optionSelected == self.optionsArr[n]{
//                    let model = self.modelArray.first(where: { $0.type == self.optionsArr[n] })
//                    self.imageArray=(model?.images)!
//                }
//            }
            let model:SelectIDType = self.modelArray.filter{$0.type == optionSelected}[0]
            self.imageArray=model.images
        }
    }
    override func viewDidLayoutSubviews() {
        //let color = Colors.Mercury226226226
        //self.scanFrontView.addDashedBorder(width: self.scanFrontView.frame.size.width, height: self.scanFrontView.frame.size.height, lineWidth: 1, lineDashPattern: [6,3], strokeColor: color, fillColor: UIColor.clear)
        //self.scanBackView.addDashedBorder(width: self.scanBackView.frame.size.width, height: self.scanBackView.frame.size.height, lineWidth: 1, lineDashPattern: [6,3], strokeColor: color, fillColor: UIColor.clear)
        //self.uploadImage3.addDashedBorder(width: self.uploadImage3.frame.size.width, height: self.uploadImage3.frame.size.height, lineWidth: 1, lineDashPattern: [6,3], strokeColor: color, fillColor: UIColor.clear)
    }
  
    func prepareView(){
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
            //btn.spacing=0.43
            btn.sizeToFit()
            btn.setTitle(optionsArr[n].rawValue, for: .normal)
            //btn.tintColor = UIColor.white
            if self.isGetDataFromDB{
                btn.isBtnSelected=true
                btn.layer.borderWidth=0.0
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.backgroundColor = Colors.Cameo213186154
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
            optionsStack.addArrangedSubview(btn)
        }
    }
    @objc func handleButton(_ sender: AnyObject) {
        //change background color and other UI
        let selectedButton=sender as! CommonButton
        if selectedButton.isBtnSelected{
            if self.modelArray.count<=selectedButton.tag{
                let model = self.modelArray[selectedButton.tag]
                self.imageArray = model.images
                self.selectedOption = model.type
                self.setImages()
            }
        }else{
            selectedButton.isBtnSelected = true
            //get button from array and update its selection state
            let btn:CommonButton = self.optionBtnsArray[selectedButton.tag]
            btn.isBtnSelected=true
            self.optionBtnsArray.insert(btn, at: selectedButton.tag)
            self.handleSelectedOption(selectedButton)
        }
    }
    ///Methode will handle the selected option and decide whether allow selection of next option or throw error and make some UI changes
    func handleSelectedOption(_ sender:CommonButton){
        if let optionSelected = self.selectedOption{
            
            if optionSelected == AppConstants.SelectIDTYPES.PASSPORT || optionSelected == AppConstants.SelectIDTYPES.F1VISA || optionSelected == AppConstants.SelectIDTYPES.USIDTYPE ||
                optionSelected == AppConstants.SelectIDTYPES.ADDRESSPROOF{
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
        sender.backgroundColor = Colors.Cameo213186154
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
            self.selectedOption==AppConstants.SelectIDTYPES.ADDRESSPROOF{
            self.uploadImage3HeightConstraint.constant=0
            self.uploadImage2HeightConstraint.constant=0
            self.resetLabels()
            self.view.layoutIfNeeded()
            self.uploadedImageFront.image = self.imageArray[0]
            //self.uploadedImageBack.image = self.imageArray[1]
        }else{
            self.uploadImage3HeightConstraint.constant=60
            self.uploadImage2HeightConstraint.constant=60
            self.setLabelsForI20()
            self.view.layoutIfNeeded()
            self.uploadedImageFront.image = self.imageArray[0]
            self.uploadedImageBack.image = self.imageArray[1]
            self.uploadedImageExtra.image = self.imageArray[2]
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
        self.saveImageInDB()
        self.formSignupFlowData()
        UserDefaults.saveToUserDefault(AppConstants.Screens.SELFIETIME.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SelfieViewController") as! SelfieViewController
        vc.signupFlowData=self.signupData
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func saveImageInDB(){
        RealmHelper.deleteAllScanID()
        for n in 0...(self.modelArray.count-1){
            
            //loop through image array of this model
            //Also create name with help of array index and model type
            let scanIDModel = self.modelArray[n]
            let imagesArr = self.modelArray[n].images
            for n in 0...(imagesArr.count-1){
                let imagedata:Data = imagesArr[n].jpegData(compressionQuality: 0.5)!
                let filename:String = scanIDModel.type.rawValue+String(n)+".jpg"
                print(filename)
                //Store this image data to document directory
                StorageHelper.saveImageDocumentDirectory(fileName: filename, data: imagedata)
                //create ScanIDTypes model to save into DB
                let modelToSaveInDB:ScanIDImages = ScanIDImages()
            modelToSaveInDB.email="Sunita"//UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String
                modelToSaveInDB.type = scanIDModel.type.rawValue
                modelToSaveInDB.imagePath=StorageHelper.getImagePath(imgName: filename)
                RealmHelper.addScanIDInfo(info: modelToSaveInDB)
            }
        }
    }
    
    func showErrForSelectedOptions(){
        if let optionSelected = self.selectedOption{
            
            if optionSelected == AppConstants.SelectIDTYPES.PASSPORT || optionSelected == AppConstants.SelectIDTYPES.F1VISA ||  optionSelected == AppConstants.SelectIDTYPES.USIDTYPE ||
                optionSelected == AppConstants.SelectIDTYPES.ADDRESSPROOF{
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
    
    // This methode is converting image to base 64 string and update SignupFlowData model by adding them to model
    func formSignupFlowData(){
//        var arrayOfScannedDocuments:[SignupFlowAlDoc]=[]
//        for n in 0...(self.modelArray.count-1){
//            let scanIDModel = self.modelArray[n]
//            //let imagesArr = scanIDModel.images
//            //Prepare data for document
//            for m in 0...(scanIDModel.images.count-1){
//                let image = scanIDModel.images[m]
//                let base64Image=image.toBase64();
//                let fullBase64String = "data:image/png;base64,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"
//String(format:"data:image/png;base64,%@",base64Image ?? "")
                //let fullBase64String = String(format:"data:image/png;base64,%@",base64Image ?? "")
                //print(String(format:"data:image/png;base64,%@",base64Image ?? ""))
//                let doc:SignupFlowAlDoc = SignupFlowAlDoc.init(documentValue: fullBase64String, documentType: scanIDModel.type.rawValue)
//                arrayOfScannedDocuments.append(doc)
//            }
//        }
//        //save data to SignupFlowData
//        if let _ = self.signupData{
//            self.signupData.documents.physicalDocs = arrayOfScannedDocuments
//        }
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
                self.imageArray.append(image)
                let btn = sender as! UIButton
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
                self.checkForCompletedStateOfScanId()
            }
        }
    /// This function will check whether images of all scan ID has been uploaded or not. If so, then enable next button
        func checkForCompletedStateOfScanId(){
            if let optionSelected = self.selectedOption{
                
                if optionSelected == AppConstants.SelectIDTYPES.PASSPORT || optionSelected == AppConstants.SelectIDTYPES.F1VISA ||  optionSelected == AppConstants.SelectIDTYPES.USIDTYPE ||
                    optionSelected == AppConstants.SelectIDTYPES.ADDRESSPROOF{
                    if self.imageArray.count == 1 {
                        self.model  = SelectIDType.init(type: optionSelected, images: self.imageArray)
                        self.modelArray.append(self.model)
                    }
                }else{
                    if self.imageArray.count == 3{
                        self.model  = SelectIDType.init(type: optionSelected, images: self.imageArray)
                        self.modelArray.append(self.model)
                    }
                }
            }
            if self.modelArray.count == self.optionsArr.count{
                self.nextBtn.isEnabled=true
            }else{
                self.nextBtn.isEnabled=false
                self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.COMPLETE_DOCUMENT_UPLOAD.rawValue)
            }
        }
    }

extension ScanIDNewViewController:ImagePreviewDelegate{
    func imageUpdatedFor(index: Int, image:UIImage){
        print(index)
        self.imageArray.insert(image, at: index)
        self.refreshImages(image: image, index: index)
    }
    
    func refreshImages(image:UIImage,index:Int){
        switch index {
        case 0:
            self.uploadedImageFront.image=image
        case 1:
            self.uploadedImageBack.image=image
        case 2:
            self.uploadedImageExtra.image=image
        default:
            break
            
        }
    }
}

