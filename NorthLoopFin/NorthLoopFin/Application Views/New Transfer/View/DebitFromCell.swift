//
//  DebitFromCell.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 09/09/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


class DebitFromCell: UITableViewCell {
    
    @IBOutlet weak var imgCheckbox: UIImageView!
    @IBOutlet weak var bankName: LabelWithLetterSpace!
    @IBOutlet weak var vwNorthLoop: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(){
    }
}
