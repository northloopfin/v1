//
//  CountryCell.swift
//  NorthLoopFin
//
//  Created by MyMac on 27/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var lblcountryCode: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
