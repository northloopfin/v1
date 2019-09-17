//
//  CameraHandler.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 26/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
import UIKit

class CameraHandler: NSObject{
    static let shared = CameraHandler()
    
    fileprivate var currentVC: UIViewController!
    
    //MARK: Internal Properties
    var imagePickedBlock: ((UIImage) -> Void)?
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            if ["ScanPassportController","ScanIDController","ScanVisaController"].contains(currentVC.value(forKey: "storyboardIdentifier") as! String){
                let vc = currentVC.getControllerWithIdentifier("CaptureIDController") as! CaptureIDController
                vc.delegate = self
                currentVC.present(vc, animated: true, completion: nil)
            }else{
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self;
                myPickerController.sourceType = .camera
                currentVC.present(myPickerController, animated: true, completion: nil)
            }
//
////            var f = myPickerController.view.bounds
//////            f.size.height = f.size.height - myPickerController.navigationBar.bounds.size.height
////            let barHeight = f.size.width * 0.5 // (f.size.height - f.size.width) / 2
////            UIGraphicsBeginImageContext(f.size)
////            UIColor(white: 0, alpha: 0.5).set()
////            UIRectFillUsingBlendMode(CGRect(x: 0, y: 0, width: f.size.width, height: barHeight), .normal)
//////            UIRectFillUsingBlendMode(CGRect(x: 0, y: f.size.height - barHeight, width: f.size.width, height: barHeight) , .normal);
////            var overlayImage = UIGraphicsGetImageFromCurrentImageContext()
////            UIGraphicsEndImageContext()
////
////            var overlayIV = UIImageView(frame: f)
////            overlayIV.image = overlayImage
////
////            myPickerController.cameraOverlayView?.addSubview(overlayIV)
//
        }

    }
    
    func photoLibrary()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func showActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
}

extension CameraHandler: CaptureDelegate{
    func capturedImage(_ image: UIImage!) {
        let compressedImageData = image.jpegData(compressionQuality: 0.8)
        //convert this compressed data to image
        let compressedImage = UIImage.init(data: compressedImageData!)
        self.imagePickedBlock?(compressedImage!)
    }
}

extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            //reduce image size here
            let compressedImageData = image.jpegData(compressionQuality: 0.8)
            //convert this compressed data to image
            let compressedImage = UIImage.init(data: compressedImageData!)
            self.imagePickedBlock?(compressedImage!)
        }else{
            print("Something went wrong")
        }
        currentVC.dismiss(animated: true, completion: nil)
    }
}
