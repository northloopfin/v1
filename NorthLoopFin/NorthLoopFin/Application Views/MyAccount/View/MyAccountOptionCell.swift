//
//  MyAccountOptionCell.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 26/09/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class MyAccountOptionCell: UITableViewCell {

    @IBOutlet weak var imgPreview: UIImageView!
    @IBOutlet weak var lblTitle: LabelWithLetterSpace!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
