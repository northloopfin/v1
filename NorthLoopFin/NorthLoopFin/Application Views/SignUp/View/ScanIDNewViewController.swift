//
//  ScanIDNewViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 18/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ScanIDNewViewController: BaseViewController {
    @IBOutlet weak var uploadImage3HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var selectYourIDLbl: LabelWithLetterSpace!
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    
    @IBOutlet weak var optionsStack: UIStackView!
    @IBOutlet weak var optionsView: UIScrollView!

    @IBOutlet weak var scanBackView: UIView!
    @IBOutlet weak var scanFrontView: UIView!
    @IBOutlet weak var uploadImage3: UIView!

    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var uploadedImageFront : UIImageView!
    @IBOutlet weak var uploadedImageBack : UIImageView!
    @IBOutlet weak var uploadedImageExtra : UIImageView!

    var imageArray:[UIImage]=[]
    var selectedOption:AppConstants.SelectIDTYPES!
    var optionsArr:[AppConstants.SelectIDTYPES]=[AppConstants.SelectIDTYPES.PASSPORT,AppConstants.SelectIDTYPES.I20,AppConstants.SelectIDTYPES.ENROLMENTLETTER]
    var model:SelectIDType!
    
    var modelArray:[SelectIDType]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Scan ID")
        self.renderIDOptions()
        self.addTapGesture()
        self.nextBtn.isEnabled=true
        
    }
    override func viewDidLayoutSubviews() {
        //let color = Colors.Mercury226226226
        //self.scanFrontView.addDashedBorder(width: self.scanFrontView.frame.size.width, height: self.scanFrontView.frame.size.height, lineWidth: 1, lineDashPattern: [6,3], strokeColor: color, fillColor: UIColor.clear)
        //self.scanBackView.addDashedBorder(width: self.scanBackView.frame.size.width, height: self.scanBackView.frame.size.height, lineWidth: 1, lineDashPattern: [6,3], strokeColor: color, fillColor: UIColor.clear)
        //self.uploadImage3.addDashedBorder(width: self.uploadImage3.frame.size.width, height: self.uploadImage3.frame.size.height, lineWidth: 1, lineDashPattern: [6,3], strokeColor: color, fillColor: UIColor.clear)
    }
  
    func prepareView(){
        uploadImage3HeightConstraint.constant=0

        self.mainTitleLbl.textColor = Colors.MainTitleColor
        self.selectYourIDLbl.textColor = Colors.Cameo213186154
        self.mainTitleLbl.font = AppFonts.mainTitleCalibriBold25
        self.selectYourIDLbl.font = AppFonts.btnTitleCalibri18
        self.nextBtn.titleLabel?.font = AppFonts.btnTitleCalibri18
    }
    
    func addTapGesture(){
        self.uploadedImageFront.callback = {
            // Some actions etc.
            self.tapped(self.uploadedImageFront)
        }
        self.uploadedImageBack.callback = {
            // Some actions etc.
            self.tapped(self.uploadedImageBack)
        }
        self.uploadedImageExtra.callback = {
            // Some actions etc.
            self.tapped(self.uploadedImageExtra)
        }
    }
    
    func  tapped(_ sender:UIImageView){
        //print("you tap image number : \(sender.view.tag)")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ImagePreviewViewController") as! ImagePreviewViewController
        vc.delegate=self
        switch sender.tag{
        case 0:
            vc.index=0
            vc.image=self.imageArray[0]
        case 1:
            vc.index=1
            vc.image=self.imageArray[1]
        case 2:
            vc.index=2
            vc.image=self.imageArray[2]
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func renderIDOptions(){
        self.optionsStack.spacing = 10.0
        
        for n in 0...(optionsArr.count-1) {
            let btn = CommonButton(type: .custom)
            //btn.spacing=0.43
            btn.sizeToFit()
            btn.setTitle(optionsArr[n].rawValue, for: .normal)
            //btn.tintColor = UIColor.white
            btn.setTitleColor(Colors.DustyGray155155155, for: .normal)
            btn.backgroundColor = Colors.Mercury226226226
            btn.layer.cornerRadius=5.0
            btn.layer.borderWidth=1.0
            btn.layer.borderColor=Colors.Mercury226226226.cgColor
            btn.tag=n
            btn.isBtnSelected=false
            btn.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
            btn.addTarget(self, action: #selector(self.handleButton(_:)), for: .touchUpInside)
            
            optionsStack.addArrangedSubview(btn)
        }
    }
    @objc func handleButton(_ sender: AnyObject) {
        //change background color and other UI
        let selectedButton=sender as! CommonButton
        if selectedButton.isBtnSelected{
            let model = self.modelArray[selectedButton.tag]
            self.imageArray = model.images
            self.selectedOption = model.type
            self.setImages()
        }else{
            selectedButton.isBtnSelected = true
            self.handleSelectedOption(selectedButton)
        }
    }
    
    func handleSelectedOption(_ sender:CommonButton){
        if let optionSelected = self.selectedOption{
            
            if optionSelected == AppConstants.SelectIDTYPES.PASSPORT || optionSelected == AppConstants.SelectIDTYPES.ENROLMENTLETTER{
                if self.imageArray.count < 2 {
                    print("show error for passport")
                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.COMPLETE_DOCUMENT_UPLOAD.rawValue)
                    return
                }
            }else{
                if self.imageArray.count < 3{
                    print("show error for I-20")
                    self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.COMPLETE_DOCUMENT_UPLOAD.rawValue)
                    return
                }
            }
        }
        if let option = self.selectedOption{
            self.model  = SelectIDType.init(type: option, images: self.imageArray)
            self.modelArray.append(self.model)
        }
        print("Select next option3")
        self.resetImages()
        self.imageArray = []
        self.selectedOption = self.optionsArr[sender.tag]
        if self.selectedOption == AppConstants.SelectIDTYPES.I20{
            uploadImage3HeightConstraint.constant=60
        }else{
            uploadImage3HeightConstraint.constant=0
        }
        self.view.layoutIfNeeded()
        sender.isBtnSelected=true
        sender.layer.borderWidth=0.0
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = Colors.Cameo213186154
        sender.set(image: UIImage.init(named: "tick"), title: (sender.titleLabel?.text)!, titlePosition: .left, additionalSpacing: 10.0, state: .normal)
    }
        
    func setImages(){
        if self.selectedOption==AppConstants.SelectIDTYPES.PASSPORT || self.selectedOption==AppConstants.SelectIDTYPES.ENROLMENTLETTER{
            self.uploadImage3HeightConstraint.constant=0
            self.view.layoutIfNeeded()
            self.uploadedImageFront.image = self.imageArray[0]
            self.uploadedImageBack.image = self.imageArray[1]
        }else{
            self.uploadImage3HeightConstraint.constant=60
            self.view.layoutIfNeeded()
            self.uploadedImageFront.image = self.imageArray[0]
            self.uploadedImageBack.image = self.imageArray[1]
            self.uploadedImageExtra.image = self.imageArray[2]
        }
    }
    func resetImages(){
        self.uploadedImageBack.image=UIImage.init(named: "scanBackId")
        self.uploadedImageFront.image=UIImage.init(named: "scanFrontId")
        self.uploadedImageExtra.image=UIImage.init(named: "scanFrontId")
        
        self.uploadedImageFront.tappable=false
        self.uploadedImageBack.tappable=false
        self.uploadedImageExtra.tappable=false
    }
    @IBAction func nextClicked(_ sender: Any) {
        // move to Selfie Screen
        UserDefaults.saveToUserDefault(AppConstants.Screens.SELFIETIME.rawValue as AnyObject, key: AppConstants.UserDefaultKeyForScreen)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SelfieViewController") as! SelfieViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    
    @IBAction func takeImageClicked(_ sender: Any) {
        if let _ = self.selectedOption{
            openCamera(sender)
        }else{
            // show error
            self.showAlert(title: AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, message: AppConstants.ErrorMessages.SELECT_ID_TYPE.rawValue)
        }
    }
    //Open Camera
        func openCamera(_ sender: Any){
            CameraHandler.shared.showActionSheet(vc: self)
            CameraHandler.shared.imagePickedBlock = { (image) in
                self.imageArray.append(image)
                let btn = sender as! UIButton
                switch btn.tag {
                case 0:
                    self.uploadedImageFront.image=image
                    self.uploadedImageFront.tappable=true
                case 1:
                    self.uploadedImageBack.image=image
                    self.uploadedImageBack.tappable=true

                case 2:
                    self.uploadedImageExtra.image=image
                    self.uploadedImageExtra.tappable=true

                default:
                    break
                }
            }
        }
    }

extension ScanIDNewViewController:ImagePreviewDelegate{
    func imageUpdatedFor(index: Int, image:UIImage){
        print(index)
        self.imageArray.insert(image, at: index)
        self.refreshImages(image: image, index: index)
    }
    
    func refreshImages(image:UIImage,index:Int){
        switch index {
        case 0:
            self.uploadedImageFront.image=image
        case 1:
            self.uploadedImageBack.image=image
        case 2:
            self.uploadedImageExtra.image=image
        default:
            break
            
        }
    }
}

