//
//  TransactionDetailHistoryCell.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 16/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit

class TransactionDetailHistoryCell: UITableViewCell {
    @IBOutlet weak var optionLbl: LabelWithLetterSpace!
    @IBOutlet weak var valueLbl: LabelWithLetterSpace!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(value:String){
        self.optionLbl.text=value
    }
    
}
