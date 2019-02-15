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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.nextBtn.isEnabled=false
        self.prepareView()
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
            self.nextBtn.isEnabled = true
            self.addBorderToOpenCameraView(view: self.openCameraView)
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
}
