//
//  DisputeTransactionConfirmationViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 31/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class DisputeTransactionConfirmationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func okBtnClicked(_ sender: Any) {
        AppUtility.moveToHomeScreen()
    }
}
