//
//  WireCell.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 07/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class WireCell: UITableViewCell {

    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var amountField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
