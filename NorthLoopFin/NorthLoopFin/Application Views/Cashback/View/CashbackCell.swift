//
//  CashbackCell.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 21/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CashbackCell: UITableViewCell {

    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var imgPreview: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(transaction:CashbackTransaction){
   
    }
}
