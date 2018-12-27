//
//  SelfieViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 21/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class SelfieViewController: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    
    private var selfieImage:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextBtn.isEnabled=false
        // Do any additional setup after loading the view.
    }
    @IBAction func openCameraClicked(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.selfieImage = image
            self.nextBtn.isEnabled = true
            self.nextBtn.backgroundColor = UIColor.init(red: 161, green: 149, blue: 133)

        }
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "SetPasswordViewController") as! SetPasswordViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
}
