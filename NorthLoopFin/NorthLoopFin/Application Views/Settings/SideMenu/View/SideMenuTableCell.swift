//
//  SideMenuTableCell.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class SideMenuTableCell: UITableViewCell {

    @IBOutlet weak var menuOptionLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
            
        // Configure the view for the selected state
    }
    
    func bindData(data:String){
        self.menuOptionLbl.text = data
    }
    
}
