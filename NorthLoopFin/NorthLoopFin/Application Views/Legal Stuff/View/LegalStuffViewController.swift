//
//  LegalStuffViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 16/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class LegalStuffViewController: BaseViewController {
    @IBOutlet weak var containerView: CommonTable!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    override func viewDidLayoutSubviews() {
        let shadowOffst = CGSize.init(width: 0, height: -55)
        let shadowOpacity = 0.1
        let shadowRadius = 49
        let shadowColor = Colors.Taupe776857
        self.containerView.delegate=self
        self.containerView.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
        self.containerView.containerView.layer.roundCorners(radius: 15.0)

    }
    /// Prepare View For display
    func prepareView(){
        var dataSource:[String] = []
        dataSource.append(AppConstants.LegalTCOptions.DEPOSITAGREEMENT.rawValue)
        dataSource.append(AppConstants.LegalTCOptions.TERMSOFSERVICE.rawValue)
        dataSource.append(AppConstants.LegalTCOptions.PRIVACYPOLICY.rawValue)
        dataSource.append(AppConstants.LegalTCOptions.CARDHOLDERAGREEMENT.rawValue)

        
        containerView.dataSource = dataSource
        containerViewHeightConstraint.constant = CGFloat(dataSource.count*70)
        self.setNavigationBarTitle(title: "Legal Stuff")
        self.setupRightNavigationBar()
    }
}

extension LegalStuffViewController:CommonTableDelegate{
    func didSelectOption(optionVal: Int) {
        // open relevant document here
        switch optionVal {
        case 0:
            self.navigateToAgreement(agreementType: AppConstants.AGREEMENTTYPE.DEPOSIT)
        case 1:
            self.navigateToAgreement(agreementType: AppConstants.AGREEMENTTYPE.ACCOUNT)
        case 2:
            self.navigateToAgreement(agreementType: AppConstants.AGREEMENTTYPE.ACCOUNT)
        case 3:
            self.navigateToAgreement(agreementType: AppConstants.AGREEMENTTYPE.CARD)
        default:
            break
        }
    }
    
    func navigateToAgreement(agreementType:AppConstants.AGREEMENTTYPE){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AgreementViewController") as! AgreementViewController
        vc.agreementType = agreementType
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
