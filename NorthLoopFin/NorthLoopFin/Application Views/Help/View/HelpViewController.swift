//
//  HelpViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class HelpViewController: BaseViewController {
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
        let shadowColor = Colors.Zorba161149133
        self.containerView.delegate=self
        self.containerView.containerView.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }
    
    /// Prepare View For display
    func prepareView(){
        var dataSource:[String] = []
        dataSource.append(AppConstants.HelpOptions.FAQ.rawValue)
        dataSource.append(AppConstants.HelpOptions.LEGALSTUFF.rawValue)
        
        containerView.dataSource = dataSource
        containerViewHeightConstraint.constant = CGFloat(dataSource.count*70)
        self.setNavigationBarTitle(title: "Help")
        self.setupRightNavigationBar()
    }
}

extension HelpViewController:HelpDelegate{
    func didSelectOption(optionVal:Int) {
        switch optionVal {
        case 0:
            self.moveToFAQ()
        case 1:
            self.moveToLegalStuff()
        default:
            break
        }
    }
    
    func moveToFAQ(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
    func moveToLegalStuff(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let transactionDetailController = storyBoard.instantiateViewController(withIdentifier: "LegalStuffViewController") as! LegalStuffViewController
        self.navigationController?.pushViewController(transactionDetailController, animated: false)
    }
}
