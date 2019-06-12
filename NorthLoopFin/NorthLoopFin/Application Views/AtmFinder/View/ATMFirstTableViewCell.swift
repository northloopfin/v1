//
//  ATMFirstTableViewCell.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ATMFirstTableViewCell: UITableViewCell {
    @IBOutlet weak var countLbl: LabelWithLetterSpace!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(count:String){
        self.countLbl.text = "Found "+count+" results"
    }
}
