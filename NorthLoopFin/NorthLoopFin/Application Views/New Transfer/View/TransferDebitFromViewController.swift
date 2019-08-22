//
//  TransferDebitFromViewController.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 19/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class TransferDebitFromViewController: UIViewController {

    @IBOutlet weak var firstBankView: FirstBankDetailView!
    @IBOutlet weak var secondBankView: SecondBankDetailView!
    @IBOutlet weak var addBankAccountView: UIView!
    @IBOutlet weak var addAmountTextField: UITextField!
    @IBOutlet weak var firstBankHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondBankHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
class FirstBankDetailView:UIView
{
    @IBOutlet weak var checkBox:UIImageView!
    @IBOutlet weak var bankImageView : UIImageView!
    @IBOutlet weak var mainLabel: LabelWithLetterSpace!
    @IBOutlet weak var tickImageView : UIImageView!
    @IBOutlet weak var clockImageView: UIImageView!
    @IBOutlet weak var firstSubtitle: LabelWithLetterSpace!
    @IBOutlet weak var secondSubtitle: LabelWithLetterSpace!
}
class SecondBankDetailView:UIView
{
    @IBOutlet weak var checkBox:UIImageView!
    @IBOutlet weak var bankImageView : UIImageView!
    @IBOutlet weak var mainLabel: LabelWithLetterSpace!
    @IBOutlet weak var subtitleLabel: LabelWithLetterSpace!
}
