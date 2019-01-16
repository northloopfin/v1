//
//  GoalCollectionViewCell.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class GoalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var amountLbl: LabelWithLetterSpace!
    @IBOutlet weak var goalNameLbl: LabelWithLetterSpace!
    
    @IBOutlet weak var goalsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func bindData(){
        
    }

}
