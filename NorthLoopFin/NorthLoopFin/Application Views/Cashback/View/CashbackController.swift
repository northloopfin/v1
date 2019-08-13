
//
//  CashbackController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 13/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
class CashbackController: BaseViewController {
    
    @IBOutlet weak var vwCashbackDetail: UIView!
    @IBOutlet weak var vwCashbackSummary: CommonTable!
    @IBOutlet weak var constSelectionUnderlineLeading: NSLayoutConstraint!
    
    @IBOutlet weak var btnRestaurant: UIButton!
    @IBOutlet weak var btnGeneral: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }
    
    @IBAction func general_clicked(_ sender: UIButton) {
        sender.titleLabel?.font = AppFonts.calibriBold17
        btnRestaurant.titleLabel?.font = AppFonts.calibri17
        constSelectionUnderlineLeading.constant = 0
    }
    
    @IBAction func restaurant_clicked(_ sender: UIButton) {
        sender.titleLabel?.font = AppFonts.calibriBold17
        btnGeneral.titleLabel?.font = AppFonts.calibri17
        constSelectionUnderlineLeading.constant = sender.frame.origin.x
    }
    
    func prepareView(){
        self.setupRightNavigationBar()
        self.setNavigationBarTitle(title: "Cashback")
        
        styleContainer(vw: vwCashbackDetail)
        styleContainer(vw: vwCashbackSummary)
    }
    
    func styleContainer(vw:UIView){
        let shadowOffst = CGSize.init(width: 0, height: 1)
        let shadowOpacity = 0.4
        let shadowRadius = 2
        let shadowColor = Colors.DustyGray155155155
        vw.layer.addShadowAndRoundedCorners(roundedCorner: 5, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)        
    }

}
