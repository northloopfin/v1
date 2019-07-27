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
    @IBOutlet weak var carouselImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
