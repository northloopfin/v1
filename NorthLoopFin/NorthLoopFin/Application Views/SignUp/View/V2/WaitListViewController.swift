//
//  WaitListViewController.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 16/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class WaitListViewController: BaseViewController {

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var okBtn: CommonButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func okBtnClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarTitle(title: "Wait")
        //self.setupRightNavigationBar()
        self.navigationItem.hidesBackButton = true
        
        // A UIImageView with async loading
        //let imageView = UIImageView()
        self.imageView.loadGif(name: "queue")

    }
}
