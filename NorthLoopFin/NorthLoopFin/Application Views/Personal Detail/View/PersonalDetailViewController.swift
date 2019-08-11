//
//  PersonalDetailViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 11/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class PersonalDetailViewController: BaseViewController {
    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var DOBtextField: UITextField!
    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: LabelWithLetterSpace!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueButtonAction(_ sender: CommonButton) {
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
