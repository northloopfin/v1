//
//  ScanIDController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 20/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import RealmSwift

class ScanIDController: BaseViewController {
    
    @IBOutlet weak var customProgressView: ProgressView!
    @IBOutlet weak var btnNext: RippleButton!
    @IBOutlet weak var btnUploadFront: UIButton!
    @IBOutlet weak var btnRemoveFront: UIButton!

    @IBOutlet weak var btnUploadBack: UIButton!
    @IBOutlet weak var btnRemoveBack: UIButton!
    @IBOutlet weak var imgFrontShadow: UIImageView!
    @IBOutlet weak var imgBackShadow: UIImageView!

    var typeData:SelectIDType = SelectIDType.init(type: AppConstants.SelectIDTYPES.STATEID, images: [])
    lazy var scanIDImages: Results<ScanIDImages> = RealmHelper.retrieveImages()
    var allButtons: [UIButton] = []
    var signupData:SignupFlowData!=nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.setupRightNavigationBar()
        self.checkDBForImages()
        
        allButtons = [btnUploadFront, btnUploadBack]
        for button in allButtons{
            button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
            if typeData.images.count > button.tag{
                button.setImage(typeData.images[button.tag], for: .normal)
                [self.btnRemoveFront, self.btnRemoveBack][button.tag].isHidden = false
                if button.tag == 0 {
                    self.imgFrontShadow.isHidden = false
                }else{
                    self.imgBackShadow.isHidden = false
                }
            }
        }
        
        checkForNext()

        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        self.customProgressView.progressView.setProgress(0.17*4, animated: true)
    }
    
    func checkDBForImages(){
        if scanIDImages.count > 0{
            var images:[UIImage]=[]
            
            for m in 0...(self.scanIDImages.count-1){
                let model = self.scanIDImages[m]
                if model.type == typeData.type.rawValue{
                    print(StorageHelper.getImagePath(imgName: model.imagePath))
                    if let _ = StorageHelper.getImageFromPath(path: StorageHelper.getImagePath(imgName: model.imagePath)){
                        images.append(StorageHelper.getImageFromPath(path: StorageHelper.getImagePath(imgName: model.imagePath))!)
                    }
                }
            }
            typeData = SelectIDType.init(type: typeData.type, images: images)
        }
    }

    func checkForNext(){
        self.btnNext.isEnabled = typeData.images.count >= 2
    }
    
    func formSignupFlowData(){
        var arrayOfScannedDocuments:[SignupFlowAlDoc]=[]
        let images:[UIImage] = typeData.images
        if images.count > 0{
            for m in 0...(images.count-1){
                let image = images[m]
                do {
                    // compress here
                    try image.compressImage(500, completion: { (image, compressRatio) in
                        let base64Image=image.toBase64();
 
                        let fullBase64String = String(format:"data:image/png;base64,%@",base64Image ?? "")
                        var doc:SignupFlowAlDoc = SignupFlowAlDoc.init(documentValue: fullBase64String, documentType: "OTHER")

                        if m == 0{
                            doc = SignupFlowAlDoc.init(documentValue: fullBase64String, documentType: "GOVT_ID")
                        }else{
                            doc = SignupFlowAlDoc.init(documentValue: fullBase64String, documentType: "GOVT_ID_BACK")
                        }

                        arrayOfScannedDocuments.append(doc)
                    })
                }catch {
                    print("Error")
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
                self.signupData.documents.email = self.signupData.email
                self.signupData.documents.phoneNumber = self.signupData.phoneNumbers[0]

                let vc = self.getControllerWithIdentifier("VerifyAddressViewController") as! VerifyAddressViewController
                vc.signupFlowData=self.signupData
                self.navigationController?.pushViewController(vc, animated: false)

            }
        }
    }

    
    @IBAction func btnRemoveBack_pressed(_ sender: UIButton) {
        self.btnUploadBack.setImage(UIImage(named: "ic_upload_placeholder"), for: .normal)
        if typeData.images.count > 1{
            typeData.images.remove(at: 1)
        }
        imgBackShadow.isHidden = true

        sender.isHidden = true
        self.btnUploadBack.layer.removeShadow()
        checkForNext()
    }

    @IBAction func btnRemoveFront_pressed(_ sender: UIButton) {
        self.btnUploadFront.setImage(UIImage(named: "ic_upload_placeholder"), for: .normal)
        if typeData.images.count > 0{
            typeData.images.remove(at: 0)
        }
        imgFrontShadow.isHidden = true

        self.btnUploadFront.layer.removeShadow()
        sender.isHidden = true
        checkForNext()
    }
    
    @IBAction func btnUpload_pressed(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            [self.btnRemoveFront, self.btnRemoveBack][sender.tag].isHidden = false
            sender.setImage(image, for: .normal)
            let imagedata:Data = image.jpegData(compressionQuality: 0.5)!
            let filename:String = self.typeData.type.rawValue+String(sender.tag)+".jpg"
            StorageHelper.saveImageDocumentDirectory(fileName: filename, data: imagedata)
            self.typeData.images.append(image)
            let modelToSaveInDB:ScanIDImages = ScanIDImages()
            modelToSaveInDB.email=UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String
            modelToSaveInDB.type = self.typeData.type.rawValue
            modelToSaveInDB.imagePath=filename
            RealmHelper.addScanIDInfo(info: modelToSaveInDB)
            if sender.tag == 0 {
                self.imgFrontShadow.isHidden = false
            }else{
                self.imgBackShadow.isHidden = false
            }

            self.checkForNext()
        }
    }

    @IBAction func nextClicked(_ sender: Any) {
        if self.btnNext.isEnabled{
            self.updateSignupFlowDataWithCompressedImages()
        }
    }
    
    @IBAction func policy_pressed(_ sender: UIButton) {
        self.openScanIDPrivacy()
    }
}
