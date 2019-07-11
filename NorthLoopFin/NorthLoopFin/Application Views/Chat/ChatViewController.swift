//
//  ChatViewController.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 05/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import  ZDCChat

class ChatViewController: ZDCChatViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }
}
