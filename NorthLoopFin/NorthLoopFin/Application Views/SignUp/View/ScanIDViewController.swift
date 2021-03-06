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
    @IBOutlet weak var selectYourIDLbl: LabelWithLetterSpace!
    
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var scanFrontView: UIView!
    @IBOutlet weak var optionsView: UIScrollView!
    @IBOutlet weak var optionsStack: UIStackView!
    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var scanBackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextBtn.isEnabled=false
        self.setupRightNavigationBar()
        self.renderIDOptions()
        self.prepareView()
    }
    
    /// Prepare view by setting text color and font to view components
    func prepareView(){
        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.selectYourIDLbl.textColor = Colors.Cameo213186154
        
        //set font
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.selectYourIDLbl.font = AppFonts.btnTitleCalibri18
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
    }
    
    func renderIDOptions(){
        self.optionsStack.spacing = 10.0
        let array = ["Passport", "Driver License", "State ID"]
        //let colorArray = [UIColor.yellow, UIColor.blue,  UIColor.cyan,UIColor.blue, UIColor.darkGray, UIColor.yellow, UIColor.blue, UIColor.cyan, UIColor.darkGray,  UIColor.blue]
        
        for n in 0...(array.count-1) {
            let btn = UIButton(type: .custom)
            //btn.spacing=0.43
            btn.sizeToFit()
            btn.setTitle(array[n], for: .normal)
            //btn.tintColor = UIColor.white
            btn.setTitleColor(Colors.DustyGray155155155, for: .normal)
            btn.backgroundColor = Colors.Mercury226226226
            btn.layer.cornerRadius=5.0
            btn.layer.borderWidth=1.0
            btn.layer.borderColor=Colors.Mercury226226226.cgColor
            btn.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
            btn.addTarget(self, action: #selector(self.handleButton(_:)), for: .touchUpInside)
            optionsStack.addArrangedSubview(btn)
        }
    }
        
        
    @objc func handleButton(_ sender: AnyObject) {
            //change background color and other UI
            let selectedButton=sender as! UIButton
            selectedButton.layer.borderWidth=0.0
            selectedButton.setTitleColor(UIColor.white, for: .normal)
            selectedButton.backgroundColor = Colors.PurpleColor17673149//UIColor.lightGray
            selectedButton.set(image: UIImage.init(named: "tick"), title: (selectedButton.titleLabel?.text)!, titlePosition: .left, additionalSpacing: 10.0, state: .normal)
            
        }

    
    override func viewDidLayoutSubviews() {
        let color = Colors.Mercury226226226
        self.scanFrontView.addDashedBorder(width: self.scanFrontView.frame.size.width, height: self.scanFrontView.frame.size.height, lineWidth: 1, lineDashPattern: [6,3], strokeColor: color, fillColor: UIColor.clear)
        self.scanBackView.addDashedBorder(width: self.scanBackView.frame.size.width, height: self.scanBackView.frame.size.height, lineWidth: 1, lineDashPattern: [6,3], strokeColor: color, fillColor: UIColor.clear)
    }
    
    
    @IBAction func nextClicked(_ sender: Any) {
        // move to Selfie Screen
        UserDefaults.saveToUserDefault(AppConstants.Screens.SELFIETIME.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
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
        }
    }
}
