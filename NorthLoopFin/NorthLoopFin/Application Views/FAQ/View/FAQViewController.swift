//
//  FAQViewController.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 16/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class FAQViewController: BaseViewController {
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
        self.containerView.containerView.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }
    /// Prepare View For display
    func prepareView(){
        var dataSource:[String] = []
    
        dataSource.append(AppConstants.FAQOptions.TERMSANDPOLICY.rawValue)
        dataSource.append(AppConstants.FAQOptions.PRIVACY.rawValue)
        dataSource.append(AppConstants.FAQOptions.OTHERSTUFF.rawValue)
        
        containerView.dataSource = dataSource
        containerViewHeightConstraint.constant = CGFloat(dataSource.count*70)
        self.setNavigationBarTitle(title: "FAQ")
        self.setupRightNavigationBar()
    }
}
