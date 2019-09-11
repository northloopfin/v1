//
//  CurrentBalanceViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 16/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CurrentBalanceViewController: BaseViewController {

    @IBOutlet weak var addFundsButton: UIButton!
    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var balanceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addFundsButtonAction(_ sender: Any) {
        AppDelegate.getDelegate().isAddFlow = true
    }
    
    @IBAction func transferButtonAction(_ sender: Any) {
        AppDelegate.getDelegate().isAddFlow = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
