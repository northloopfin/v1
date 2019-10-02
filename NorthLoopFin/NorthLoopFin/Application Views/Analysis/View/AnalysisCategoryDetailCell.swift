//
//  AnalysisCategoryDetailCell.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 01/10/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class AnalysisCategoryDetailCell: UITableViewCell {

    @IBOutlet weak var lblAmount: LabelWithLetterSpace!
    @IBOutlet weak var lblTitle: LabelWithLetterSpace!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(data:AnalysisCategoryData){
        lblTitle.text = data.toMerchantName
        lblAmount.text = "$" + String(data.sumAmount) 
    }
}
