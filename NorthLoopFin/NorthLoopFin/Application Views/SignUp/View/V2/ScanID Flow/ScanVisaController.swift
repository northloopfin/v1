//
//  ScanVisaController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 20/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import RealmSwift

class ScanVisaController: BaseViewController {


    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var vwNext: UIView!
    @IBOutlet weak var vwPrevious: UIView!
    
    var typeData:SelectIDType = SelectIDType.init(type: AppConstants.SelectIDTYPES.F1VISA, images: [])
    
    lazy var scanIDImages: Results<ScanIDImages> = RealmHelper.retrieveImages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.checkDBForImages()
        btnUpload.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        if let vc = self.previousViewController {
            if vc.self.isKind(of: ScanI20Controller.self){
                self.vwPrevious.isHidden = false
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
                        self.setImage(images[0])
                    }
                }
            }
            typeData = SelectIDType.init(type: typeData.type, images: images)// self.modelArray[n]
        }
    }
    
    func setImage(_ image: UIImage){
        self.btnUpload.setImage(image, for: .normal)
        self.vwNext.isUserInteractionEnabled = true
        self.vwNext.alpha = 1
    }
    
    @IBAction func btnNext_pressed(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScanAddressProofController") else { return  }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnPrevious_pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUpload_pressed(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.typeData.images = [image]
            self.setImage(image)
            let imagedata:Data = image.jpegData(compressionQuality: 0.5)!
            let filename:String = self.typeData.type.rawValue+"0.jpg"
            StorageHelper.saveImageDocumentDirectory(fileName: filename, data: imagedata)
            
            let modelToSaveInDB:ScanIDImages = ScanIDImages()
            modelToSaveInDB.email=UserDefaults.getUserDefaultForKey(AppConstants.UserDefaultKeyForEmail) as! String
            modelToSaveInDB.type = self.typeData.type.rawValue
            modelToSaveInDB.imagePath=filename
            RealmHelper.addScanIDInfo(info: modelToSaveInDB)
        }
    }
}
