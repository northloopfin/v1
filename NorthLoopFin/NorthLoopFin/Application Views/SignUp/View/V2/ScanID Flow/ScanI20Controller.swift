//
//  ScanI20Controller.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 19/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import RealmSwift

class ScanI20Controller: BaseViewController {

    @IBOutlet weak var btnPage1: UIButton!
    @IBOutlet weak var btnPage2: UIButton!
    @IBOutlet weak var btnPage3: UIButton!
    @IBOutlet weak var vwNext: UIView!
    @IBOutlet weak var vwPrevious: UIView!
    
    var typeData:SelectIDType = SelectIDType.init(type: AppConstants.SelectIDTYPES.I20, images: [])
    var allButtons: [UIButton] = []

    lazy var scanIDImages: Results<ScanIDImages> = RealmHelper.retrieveImages()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.checkDBForImages()

        allButtons = [btnPage1, btnPage2, btnPage3]
        for button in allButtons{
            button.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
            if typeData.images.count > button.tag{
                button.setImage(typeData.images[button.tag], for: .normal)
                button.setBackgroundImage(UIImage(named: "ic_upload_shadow"), for: .normal)
            }
        }
        if let vc = self.previousViewController {
            if vc.self.isKind(of: ScanPassportController.self){
                self.vwPrevious.isHidden = false
            }
        }

         self.checkForNext()
    }
    
    func checkForNext(){
        if typeData.images.count >= 3 {
            self.vwNext.isUserInteractionEnabled = true
            self.vwNext.alpha = 1
        }
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
            typeData = SelectIDType.init(type: typeData.type, images: images)// self.modelArray[n]
        }
    }
    
    @IBAction func btnUpload_pressed(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            sender.setImage(image, for: .normal)
            sender.setBackgroundImage(UIImage(named: "ic_upload_shadow"), for: .normal)
            let imagedata:Data = image.jpegData(compressionQuality: 0.5)!
            let filename:String = self.typeData.type.rawValue+String(sender.tag)+".jpg"
            StorageHelper.saveImageDocumentDirectory(fileName: filename, data: imagedata)
            self.typeData.images.append(image)
            let modelToSaveInDB:ScanIDImages = ScanIDImages()
            modelToSaveInDB.email=UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String
            modelToSaveInDB.type = self.typeData.type.rawValue
            modelToSaveInDB.imagePath=filename
            RealmHelper.addScanIDInfo(info: modelToSaveInDB)
            self.checkForNext()
        }
    }
    
    @IBAction func btnPrevious_pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext_pressed(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScanVisaController") else { return  }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
