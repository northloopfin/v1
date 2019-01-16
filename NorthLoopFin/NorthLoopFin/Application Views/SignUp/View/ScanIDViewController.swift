//
//  ScanIDViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 20/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class ScanIDViewController: BaseViewController {
    private var idFront:UIImage = UIImage()
    private var idBack:UIImage = UIImage()
    
    private var isFront:Bool = false
    
    @IBOutlet weak var scanFrontView: UIView!
    @IBOutlet weak var optionsView: ScanIDOptionsView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var scanBackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextBtn.isEnabled=false
        self.setupRightNavigationBar()
        self.optionsView.wordsArray = ["Passport","Driver License","State ID"]
    }
    
    override func viewDidLayoutSubviews() {
        let color = Colors.Mercury226226226
        self.scanFrontView.addDashedBorder(width: self.scanFrontView.frame.size.width, height: self.scanFrontView.frame.size.height, lineWidth: 1, lineDashPattern: [6,3], strokeColor: color, fillColor: UIColor.clear)
        self.scanBackView.addDashedBorder(width: self.scanBackView.frame.size.width, height: self.scanBackView.frame.size.height, lineWidth: 1, lineDashPattern: [6,3], strokeColor: color, fillColor: UIColor.clear)
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
                self.addBorder(view: self.scanFrontView)
            }else{
                self.idBack = image
                self.addBorder(view: self.scanBackView)
            }
            self.changeApperanceOfNextBtn()
        }
    }
    
    //Add Border to given view
    func addBorder(view:UIView){
        view.removeDashedBorder(view)
        let color = Colors.Mercury226226226
        let width = 1.0
        view.addBorderWithColorWidth(color: color, width: CGFloat(width))
    }
    func changeApperanceOfNextBtn(){
        if (self.idFront.size.width != 0 && self.idBack.size.width != 0 ){
            self.nextBtn.isEnabled = true
            self.nextBtn.backgroundColor = Colors.Zorba161149133
        }
    }
}
