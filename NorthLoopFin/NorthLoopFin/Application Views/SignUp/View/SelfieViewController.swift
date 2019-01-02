//
//  SelfieViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class SelfieViewController: BaseViewController {

    @IBOutlet weak var nextBtn: UIButton!
    
    private var selfieImage:UIImage!
    @IBOutlet weak var openCameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.nextBtn.isEnabled=false
        // Do any additional setup after loading the view.
    }
    func setupRightNavigationBar(){
        let leftBarItem = UIBarButtonItem()
        leftBarItem.style = UIBarButtonItem.Style.plain
        leftBarItem.target = self
        leftBarItem.image = UIImage(named: "Back")?.withRenderingMode(.alwaysOriginal)
        leftBarItem.action = #selector(self.goBack)
        navigationItem.leftBarButtonItem = leftBarItem
    }
    //Method to go back to previous screen
    @objc func goBack(){
        self.navigationController?.popViewController(animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        let color = Colors.Mercury226226226
        self.openCameraView.addDashedBorder(width: self.openCameraView.frame.size.width, height: self.openCameraView.frame.size.height, lineWidth: 1, lineDashPattern: [6,3], strokeColor: color, fillColor: UIColor.clear)
    }
    
    @IBAction func openCameraClicked(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.selfieImage = image
            self.nextBtn.isEnabled = true
            self.nextBtn.backgroundColor = Colors.Zorba161149133
            self.addBorderToOpenCameraView(view: self.openCameraView)
        }
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SetPasswordViewController") as! SetPasswordViewController
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
