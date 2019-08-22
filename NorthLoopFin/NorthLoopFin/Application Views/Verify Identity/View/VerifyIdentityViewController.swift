//
//  VerifyIdentityViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 11/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class VerifyIdentityViewController: BaseViewController {

    @IBOutlet weak var mainTitleLbl: LabelWithLetterSpace!
    @IBOutlet weak var SSNTextField: UITextField!
    @IBOutlet weak var nextBtn: CommonButton!
    @IBOutlet weak var discriptionLabel: LabelWithLetterSpace!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SSNTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged);
        // Do any additional setup after loading the view.
    }
    @objc func textFieldDidChange(textField: UITextField){
        if ((textField.text?.isEmpty)!){
            self.nextBtn.isEnabled=false
        }else{
           // self.checkForMandatoryFields()
        }
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
