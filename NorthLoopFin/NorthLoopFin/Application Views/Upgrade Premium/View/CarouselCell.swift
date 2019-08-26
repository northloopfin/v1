//
//  CarouselCell.swift
//  NorthLoopFin
//
//  Created by SagarR on 26/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {

    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitleHight: NSLayoutConstraint!
    @IBOutlet weak var vwUpgradeHeight: NSLayoutConstraint!
    @IBOutlet weak var carouselImage: UIImageView!
    @IBOutlet weak var btnMonthly: UIButton!
    @IBOutlet weak var btnAnnually: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnMonthly.setTitle(AppConstants.UPGRADETYPE.MONTHLY.rawValue, for: .normal)
        self.btnAnnually.setTitle(AppConstants.UPGRADETYPE.ANNUALLY.rawValue, for: .normal)
    }

}
