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
    @IBOutlet weak var step2Lbl: LabelWithLetterSpace!
    @IBOutlet weak var step1Lbl: LabelWithLetterSpace!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var openCamera: LabelWithLetterSpace!
    @IBOutlet weak var selfieImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Image Preview")
        self.nextBtn.isEnabled=false
        self.addTapGesture()
        self.prepareView()
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
            let image1 = StorageHelper.getImageFromPath(path: selfie.imagePath)
            self.selfieImage = image1
            self.selfieImageView.image=image1
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
        self.step2Lbl.textColor = Colors.DustyGray155155155
        self.openCamera.textColor = Colors.Taupe776857
        
        // Set font
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.step2Lbl.font = AppFonts.btnTitleCalibri18
        self.step1Lbl.font = AppFonts.btnTitleCalibri18
        self.openCamera.font = AppFonts.textBoxCalibri16
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
    }
    
    @IBAction func openCameraClicked(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.selfieImage = image
            self.selfieImageView.image=self.selfieImage
            self.nextBtn.isEnabled = true
            self.addBorderToOpenCameraView(view: self.openCameraView)
            self.saveImageInDB(image: image)
        }
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        UserDefaults.saveToUserDefault(AppConstants.Screens.VERIFYADDRESS.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "VerifyAddressViewController") as! VerifyAddressViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    //Add Border to given view
    func addBorderToOpenCameraView(view:UIView){
        view.removeDashedBorder(view)
        let color = Colors.Mercury226226226
        let width = 1.0
        view.addBorderWithColorWidth(color: color, width: CGFloat(width))
    }
    
    func saveImageInDB(image:UIImage){
        let imgData:Data = image.jpegData(compressionQuality: 0.5)!//UIImageJPEGRepresentation(image, 0.5)!
        let fileName:String = "Selfie.jpg"
        StorageHelper.saveImageDocumentDirectory(fileName: fileName, data: imgData)
        let selfieObj:SelfieImage = SelfieImage()
        selfieObj.email = UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String
        selfieObj.imagePath = StorageHelper.getImagePath(imgName: fileName)
        selfieObj.type = "Selfie"
        RealmHelper.addSelfieInfo(info: selfieObj)
    }


    /// Methode will add tap gesture to UIImageView
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
        vc.image=self.selfieImage
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension SelfieViewController:ImagePreviewDelegate{
    func imageUpdatedFor(index: Int, image: UIImage) {
        self.selfieImage=image
        self.selfieImageView.image = image
    }
}
