//
//  CommonTableCellTableViewCell.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CommonTableCell: UITableViewCell {
    
    @IBOutlet weak var optionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
