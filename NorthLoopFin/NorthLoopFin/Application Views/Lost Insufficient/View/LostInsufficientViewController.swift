//
//  LostInsufficientViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 18/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class LostInsufficientViewController: BaseViewController {

    @IBOutlet weak var messageLbl: LabelWithLetterSpace!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarTitle(title: "Lost Insufficient")
        self.setupRightNavigationBar()
        self.prepareView()
    }
    
    func prepareView(){
        self.messageLbl.textColor = Colors.MainTitleColor
        self.messageLbl.font=AppFonts.calibri15
    }
}
