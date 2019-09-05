//
//  ApplyCreditCardVC.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 05/09/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ApplyCreditCardVC: BaseViewController {

    @IBOutlet weak var btnApply: RippleButton!
    var fetchPresenter:FetchCreditCardPresenter!
    var requestPresenter:RequestCreditCardPresenter!

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.spinner.startAnimating()
        fetchPresenter = FetchCreditCardPresenter(delegate: self)
        fetchPresenter.sendFetchCreditCardRequest()
    }
    
    @IBAction func btnApply_clicked(_ sender: RippleButton) {
        self.spinner.startAnimating()
        requestPresenter = RequestCreditCardPresenter(delegate: self)
        requestPresenter.sendRequestCreditCardRequest()
    }

    func setRequestedMode(requested:Bool){
        spinner.stopAnimating()
        btnApply.isUserInteractionEnabled = !requested
        if requested {
            btnApply.setTitle("You're on the waitlist", for: .normal)
        }else{
            btnApply.setTitle("I'M INTERESTED", for: .normal)
        }
    }
}


extension ApplyCreditCardVC: FetchCreditCardDelegate {
    func didFetchCreditCard(data: FetchCreditCard) {
        setRequestedMode(requested: data.data.requested)
    }
    
    func didFaildCreditCard() {
        setRequestedMode(requested: false)
    }
}


extension ApplyCreditCardVC: RequestCreditCardDelegate {
    func didRequestCreditCard() {
        setRequestedMode(requested: true)
    }
    
}
