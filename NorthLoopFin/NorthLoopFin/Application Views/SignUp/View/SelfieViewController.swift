//
//  SelfieViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class SelfieViewController: BaseViewController {

    @IBOutlet weak var nextBtn: CommonButton!
    private var selfieImage:UIImage!
    @IBOutlet weak var openCameraView: UIView!
    //@IBOutlet weak var step2Lbl: LabelWithLetterSpace!
    @IBOutlet weak var step1Lbl: LabelWithLetterSpace!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var openCamera: LabelWithLetterSpace!
    @IBOutlet weak var selfieImageView: UIImageView!

    var signupFlowData:SignupFlowData!=nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.nextBtn.isEnabled=false
        self.prepareView()
        self.addTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchDatafromRealmIfAny()
    }
    
    func fetchDatafromRealmIfAny(){
        let result = RealmHelper.retrieveSelfieImages()
        print(result)
        if result.count > 0{
            let selfie:SelfieImage = result.first!
            let image1 = StorageHelper.getImageFromPath(path: StorageHelper.getImagePath(imgName: selfie.imagePath))
            self.selfieImage = image1
            self.selfieImageView.image=image1
            self.nextBtn.isEnabled=true
        }
    }
    
    override func viewDidLayoutSubviews() {
        let color = Colors.Mercury226226226
        self.openCameraView.addDashedBorder(width: self.openCameraView.frame.size.width, height: self.openCameraView.frame.size.height, lineWidth: 1, lineDashPattern: [6,3], strokeColor: color, fillColor: UIColor.clear)
    }
    
    /// Prepare View by setting color and font to view components
    func prepareView(){
        // Set Text Color
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.step1Lbl.textColor = Colors.DustyGray155155155
        //self.step2Lbl.textColor = Colors.DustyGray155155155
        self.openCamera.textColor = Colors.Taupe776857
        
        // Set font
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
       // self.step2Lbl.font = AppFonts.btnTitleCalibri18
        self.step1Lbl.font = AppFonts.btnTitleCalibri18
        self.openCamera.font = AppFonts.textBoxCalibri16
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
    }
    
    @IBAction func openCameraClicked(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.selfieImage = image
            self.nextBtn.isEnabled = true
            self.selfieImageView.tappable=true
            self.addBorderToOpenCameraView(view: self.openCameraView)
            self.selfieImageView.image=image
            self.saveImageInDB(image: image)
        }
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        // save data to SignupFlow Data
        self.addImageToSingupFlowData()
        UserDefaults.saveToUserDefault(AppConstants.Screens.VERIFYADDRESS.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignupStepConfirm") as! SignupStepConfirm
        vc.signupFlowData=self.signupFlowData
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func addImageToSingupFlowData(){
        do {
            try self.selfieImage.compressImage(1000, completion: { (image, compressRatio) in
                let base64Image = self.selfieImage.toBase64()
                let fullBase64String = String(format:"data:image/png;base64,%@",base64Image ?? "")
                let docObject:SignupFlowAlDoc = SignupFlowAlDoc.init(documentValue: fullBase64String, documentType: "SELFIE")
                var physicalDocArr = self.signupFlowData.documents.physicalDocs
                physicalDocArr.append(docObject)
                if let _ = self.signupFlowData{
                    self.signupFlowData.documents.physicalDocs = physicalDocArr
                }
            })
        } catch  {
            print("Error")
        }
        
        //let base64Image = self.selfieImage.toBase64()
        //let fullBase64String = String(format:"data:image/png;base64,%@",base64Image ?? "")
        
//        let fullBase64String = "data:image/png;base64,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"        
    }
    //Add Border to given view
    func addBorderToOpenCameraView(view:UIView){
        view.removeDashedBorder(view)
        let color = Colors.Mercury226226226
        let width = 1.0
        view.addBorderWithColorWidth(color: color, width: CGFloat(width))
    }
    
    func saveImageInDB(image:UIImage){
        RealmHelper.deleteAllSelfie()
        let imgData:Data = image.jpegData(compressionQuality: 0.5)!//UIImageJPEGRepresentation(image, 0.5)!
        let fileName:String = "Selfie.jpg"
        StorageHelper.saveImageDocumentDirectory(fileName: fileName, data: imgData)
        let selfieObj:SelfieImage = SelfieImage()
        selfieObj.email = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String
        selfieObj.imagePath = fileName//StorageHelper.getImagePath(imgName: fileName)
        selfieObj.type = "Selfie"
        RealmHelper.addSelfieInfo(info: selfieObj)
    }
    
    /// Methode add Tap gesture to imageview
    func addTapGesture(){
        self.selfieImageView.callback = {
            // Some actions etc.
            self.tapped(self.selfieImageView)
        }
    }
    
    func  tapped(_ sender:UIImageView){
        //print("you tap image number : \(sender.view.tag)")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ImagePreviewViewController") as! ImagePreviewViewController
        vc.delegate=self
        vc.index=sender.tag
        vc.image = self.selfieImage
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension SelfieViewController:ImagePreviewDelegate{
    func imageUpdatedFor(index: Int, image:UIImage){
        self.selfieImage=image
        self.selfieImageView.image=image
        self.saveImageInDB(image: image)
    }
}
