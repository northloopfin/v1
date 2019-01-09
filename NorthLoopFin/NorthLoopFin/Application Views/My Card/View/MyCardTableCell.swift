//
//  MyCardTableCell.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class MyCardTableCell: UITableViewCell {
    @IBOutlet weak var lock: UISwitch!
    @IBOutlet weak var optionLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(data:MyCardOtionsModel){
        optionLbl.text = data.option
        if(data.haveSwitch){
            lock.isHidden=false
        }else{
            lock.isHidden=true
        }
    }
    
}
