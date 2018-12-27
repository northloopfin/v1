//
//  ScanIDViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 20/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class ScanIDViewController: UIViewController {
    private var idFront:UIImage!
    private var idBack:UIImage!
    
    private var isFront:Bool = false
    
    @IBOutlet weak var scanFrontView: UIView!
    @IBOutlet weak var optionsView: ScanIDOptionsView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var scanBackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextBtn.isEnabled=false
        self.optionsView.wordsArray = ["Passport","Driver License","State ID"]
    }
    @IBAction func nextClicked(_ sender: Any) {
        // move to Selfie Screen
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SelfieViewController") as! SelfieViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    @IBAction func scanFrontClicked(_ sender: Any) {
        self.isFront = true
        self.openCamera()
    }
    @IBAction func scanBackClicked(_ sender: Any) {
        self.isFront = false
        self.openCamera()
    }
    //Open Camera
    func openCamera(){
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            if self.isFront{
                self.idFront = image
            }else{
                self.idBack = image
            }
            self.changeApperanceOfNextBtn()
        }
    }
    func changeApperanceOfNextBtn(){
        if (self.idFront.size.width != 0 && self.idBack.size.width != 0 ){
            self.nextBtn.isEnabled = true
            self.nextBtn.backgroundColor = UIColor.init(red: 161, green: 149, blue: 133)
        }
    }
}
