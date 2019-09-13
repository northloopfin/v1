//
//  SSNInfoViewController.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 17/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class SSNInfoViewController: BaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var crossButton: UIButton!
    
    @IBAction func crossBtnClicked(_ sender: Any) {
    
        //self.navigationController?.dismiss(animated: false, completion: nil)
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        let shadowOffst = CGSize.init(width: 0, height: 0)
        let shadowOpacity = 0.5
        let shadowRadius = 3
        let shadowColor = UIColor.init(red: 205, green: 205, blue: 205)
        self.containerView.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }
}
