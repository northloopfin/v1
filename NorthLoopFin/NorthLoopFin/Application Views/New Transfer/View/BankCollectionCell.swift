//
//  BankCollectionCell.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 10/09/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class BankCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgPreview: UIImageView!
    @IBOutlet weak var lblName: LabelWithLetterSpace!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgPreview.cornerRadius = imgPreview.frame.size.height/2
        // Initialization code
    }

}
