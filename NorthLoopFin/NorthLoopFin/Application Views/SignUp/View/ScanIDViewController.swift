//
//  ScanIDViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 20/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class ScanIDViewController: BaseViewController {
    
    @IBOutlet weak var selectYourIDLbl: LabelWithLetterSpace!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    
    @IBOutlet weak var uploadImageFrontLbl: LabelWithLetterSpace!
    @IBOutlet weak var uploadImageBackLbl: LabelWithLetterSpace!
    //@IBOutlet weak var uploadImageExtraLbl: LabelWithLetterSpace!
    
    @IBOutlet weak var optionsStack: UIStackView!
    @IBOutlet weak var optionsView: UIScrollView!
    
    @IBOutlet weak var scanBackView: UIView!
    @IBOutlet weak var scanFrontView: UIView!
    //@IBOutlet weak var uploadImage3: UIView!
    
    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var uploadedImageFront : UIImageView!
    @IBOutlet weak var uploadedImageBack : UIImageView!
    //@IBOutlet weak var uploadedImageExtra : UIImageView!
    
    var imageArray:[UIImage]=[]
    var selectedOption:AppConstants.SelectIDTYPES!
    var optionsArr:[AppConstants.SelectIDTYPES]=[AppConstants.SelectIDTYPES.PASSPORT,AppConstants.SelectIDTYPES.DRIVINGLICENSE,AppConstants.SelectIDTYPES.STATEID]
    var model:SelectIDType!
    
    var modelArray:[SelectIDType]=[]
    var optionBtnsArray:[CommonButton] = []
    
    //var to define the state wether data coming from Realm DB
    var isGetDataFromDB:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Scan ID")
        self.checkDBForImages()
        self.renderIDOptions()
        self.addTapGesture()
        self.nextBtn.isEnabled=false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func checkDBForImages(){
        let images = RealmHelper.retrieveImages()
        var passportImages:[UIImage]=[]
        var licenseImages:[UIImage]=[]
        var stateIDImages:[UIImage]=[]
        if images.count>0{
            self.isGetDataFromDB=true
            
            for n in 0...(images.count-1){
                let image = StorageHelper.getImageFromPath(path: images[n].imagePath)
                if images[n].type == AppConstants.SelectIDTYPES.PASSPORT.rawValue{
                    passportImages.append(image!)
                }else if images[n].type == AppConstants.SelectIDTYPES.DRIVINGLICENSE.rawValue{
                    licenseImages.append(image!)
                }else{
                    stateIDImages.append(image!)
                }
            }
            let passportModel = SelectIDType.init(type: AppConstants.SelectIDTYPES.PASSPORT, images: passportImages)
            let drivingModel = SelectIDType.init(type: AppConstants.SelectIDTYPES.DRIVINGLICENSE, images: licenseImages)
            let stateIDModel = SelectIDType.init(type: AppConstants.SelectIDTYPES.STATEID, images: stateIDImages)
            self.modelArray.append(passportModel)
            self.modelArray.append(drivingModel)
            self.modelArray.append(stateIDModel)
            self.selectedOption = self.optionsArr[0]
            self.getImageFromDBForSelctedOption()
            self.setImages()
        }
    }
    ///Methode will set image array read from db
    func getImageFromDBForSelctedOption(){
        if let optionSelected = self.selectedOption{
            for n in 0...(self.optionsArr.count-1){
                if optionSelected == self.optionsArr[n]{
                    let model = self.modelArray.first(where: { $0.type == self.optionsArr[n] })
                    self.imageArray=(model?.images)!
                }
            }
        }
    }
    
    func prepareView(){
        
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
        if isGetDataFromDB{
            print("Get Data")
            self.getImageFromDBForSelctedOption()
            self.setImages()
        }else{
            let selectedButton=sender as! CommonButton
            if selectedButton.isBtnSelected{
                let model = self.modelArray[selectedButton.tag]
                self.imageArray = model.images
                self.selectedOption = model.type
                self.setImages()
            }else{
                selectedButton.isBtnSelected = true
                //get button from array and update its selection state
                let btn:CommonButton = self.optionBtnsArray[selectedButton.tag]
                btn.isBtnSelected=true
                self.optionBtnsArray.insert(btn, at: selectedButton.tag)
                self.handleSelectedOption(selectedButton)
            }
        }
    }
    ///Methode will handle the selected option and decide whether allow selection of next option or throw error and make some UI changes
    func handleSelectedOption(_ sender:CommonButton){
        if let optionSelected = self.selectedOption{
            
            if optionSelected == AppConstants.SelectIDTYPES.PASSPORT || optionSelected == AppConstants.SelectIDTYPES.DRIVINGLICENSE || optionSelected==AppConstants.SelectIDTYPES.STATEID{
                if self.imageArray.count < 2 {
                    print("show error for passport")
                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.COMPLETE_DOCUMENT_UPLOAD.rawValue)
                    return
                }
           }
        }
        self.resetImages()
        self.imageArray = []
        self.selectedOption = self.optionsArr[sender.tag]
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
   
    
    func setImages(){
        if self.selectedOption==AppConstants.SelectIDTYPES.PASSPORT || self.selectedOption==AppConstants.SelectIDTYPES.DRIVINGLICENSE{
            //self.uploadImage3HeightConstraint.constant=0
            //self.view.layoutIfNeeded()
            self.uploadedImageFront.image = self.imageArray[0]
            self.uploadedImageBack.image = self.imageArray[1]
        }else{
            //self.uploadImage3HeightConstraint.constant=60
            //self.view.layoutIfNeeded()
            self.uploadedImageFront.image = self.imageArray[0]
            self.uploadedImageBack.image = self.imageArray[1]
            //self.uploadedImageExtra.image = self.imageArray[2]
        }
    }
    func resetImages(){
        self.uploadedImageBack.image=UIImage.init(named: "scanBackId")
        self.uploadedImageFront.image=UIImage.init(named: "scanFrontId")
        //self.uploadedImageExtra.image=UIImage.init(named: "scanFrontId")
        
        self.uploadedImageFront.tappable=false
        self.uploadedImageBack.tappable=false
        //self.uploadedImageExtra.tappable=false
    }
    @IBAction func nextClicked(_ sender: Any) {
        // move to Selfie Screen
        self.showErrForSelectedOptions()
        self.saveImageInDB()
        UserDefaults.saveToUserDefault(AppConstants.Screens.SELFIETIME.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SelfieViewController") as! SelfieViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    func showErrForSelectedOptions(){
        if let optionSelected = self.selectedOption{
            
            if optionSelected == AppConstants.SelectIDTYPES.PASSPORT || optionSelected == AppConstants.SelectIDTYPES.DRIVINGLICENSE || optionSelected == AppConstants.SelectIDTYPES.STATEID {
                if self.imageArray.count < 2 {
                    print("show error for passport")
                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.COMPLETE_DOCUMENT_UPLOAD.rawValue)
                    return
                }
           }
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
                
            default:
                break
            }
            self.checkForCompletedStateOfScanId()
        }
    }
    
    func saveImageInDB(){
        RealmHelper.deleteAllScanID()
        for n in 0...(self.modelArray.count-1){
            let imageData1:Data = self.modelArray[n].images[0].jpegData(compressionQuality: 0.5)!
            let imageData2:Data = self.modelArray[n].images[1].jpegData(compressionQuality: 0.5)!
            let fileName1 = self.modelArray[n].type.rawValue+"0.jpg"
            let fileName2 = self.modelArray[n].type.rawValue+"1.jpg"
            StorageHelper.saveImageDocumentDirectory(fileName: fileName1, data: imageData1)
            StorageHelper.saveImageDocumentDirectory(fileName: fileName2, data: imageData2)
            let scanIDObj1 = ScanIDImages()
        scanIDObj1.email=UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String//"Sunita"
            scanIDObj1.type = self.modelArray[n].type.rawValue
            scanIDObj1.imagePath = StorageHelper.getImagePath(imgName: fileName1)
            RealmHelper.addScanIDInfo(info: scanIDObj1)
            let scanIDObj2 = ScanIDImages()
        scanIDObj2.email=UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String//"Sunita"
            scanIDObj2.type = self.modelArray[n].type.rawValue
            scanIDObj2.imagePath = StorageHelper.getImagePath(imgName: fileName2)
            RealmHelper.addScanIDInfo(info: scanIDObj2)
        }
    }
    /// This function will check whether images of all scan ID has been uploaded or not. If so, then enable next button
    func checkForCompletedStateOfScanId(){
        if let optionSelected = self.selectedOption{
            
            if optionSelected == AppConstants.SelectIDTYPES.PASSPORT || optionSelected == AppConstants.SelectIDTYPES.DRIVINGLICENSE || optionSelected == AppConstants.SelectIDTYPES.STATEID{
                if self.imageArray.count == 2 {
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

extension ScanIDViewController:ImagePreviewDelegate{
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

        default:
            break
            
        }
    }
}
