//
//  MyOffersViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 17/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class MyOffersViewController: BaseViewController {
    @IBOutlet weak var containerView: CommonTable!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mainTitlelbl: LabelWithLetterSpace!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "My Offers")
        self.prepareView()
    }
    
    override func viewDidLayoutSubviews() {
        let shadowOffst = CGSize.init(width: 0, height: -55)
        let shadowOpacity = 0.1
        let shadowRadius = 49
        let shadowColor = Colors.PurpleColor17673149
        self.containerView.containerView.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }
    /// Prepare View For display
    func prepareView(){
        var dataSource:[String] = []
        dataSource.append("Offer 1")
        dataSource.append("Offer 2")
        dataSource.append("Offer 3")
        containerView.dataSource = dataSource
        containerViewHeightConstraint.constant = CGFloat(dataSource.count*70)
        self.mainTitlelbl.font = AppFonts.mainTitleCalibriBold25
        self.mainTitlelbl.textColor = Colors.MainTitleColor
    }

}
