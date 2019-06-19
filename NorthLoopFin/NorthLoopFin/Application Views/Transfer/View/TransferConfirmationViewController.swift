//
//  TransferConfirmationViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class TransferConfirmationViewController: BaseViewController {

    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var achLbl: UILabel!
    @IBOutlet weak var mainTitleLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    var presenter:ACHTransactionPresenter!
    var amount:String = ""
    var ach:ACHNode? = nil
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        self.presenter.sendACHTransactionRequest(amount: amount, nodeID: (ach?.nodeID)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
        self.presenter = ACHTransactionPresenter.init(delegate: self)

    }
    func prepareView(){
        self.setNavigationBarTitle(title: "Transfer")
        self.setupRightNavigationBar()
        self.mainTitleLbl.textColor=Colors.MainTitleColor
        self.amountLbl.textColor=Colors.MainTitleColor
        self.achLbl.textColor=Colors.MainTitleColor

        self.amountLbl.font=AppFonts.calibri15
        self.achLbl.font=AppFonts.calibri15
        self.mainTitleLbl.font=AppFonts.mainTitleCalibriBold25
        self.nextBtn.titleLabel?.font=AppFonts.btnTitleCalibri18
        self.amountLbl.text = "$"+self.amount
        self.achLbl.text = self.ach?.nickname
    }
    
}
extension TransferConfirmationViewController:ACHTransactionDelegates{
    func didSentFetchACH() {
        self.moveToSucessScreen()
    }
    
    func moveToSucessScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TransferSuceessViewController") as! TransferSuceessViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
