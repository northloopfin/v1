//
//  ExpensesViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 11/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ExpensesViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()

        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        self.setNavigationBarTitle(title: "Expense")
        self.setupRightNavigationBar()
    }

}
