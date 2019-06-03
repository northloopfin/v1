//
//  ATMTableViewCell.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class ATMTableViewCell: UITableViewCell {
    @IBOutlet weak var atmName: LabelWithLetterSpace!
    @IBOutlet weak var atmAddress: LabelWithLetterSpace!
    @IBOutlet weak var atmDistance: LabelWithLetterSpace!
    @IBOutlet weak var dayNightImage: UIImageView!
    @IBOutlet weak var cashImage: UIImageView!
    @IBOutlet weak var wheelchairImage: UIImageView!

    var data:ATM?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.atmAddress.tappable=true
        self.atmAddress.callback = {
            // open Google Map from gere
            
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func bindData(data:ATM){
        self.data  = data
        self.atmName.text = data.atmLocation.name
        self.atmAddress.text = data.atmLocation.address.street + " (get directions)"
        self.atmDistance.text = String(data.distance)+" miles"
        if data.atmLocation.isAvailable24Hours{
            self.dayNightImage.isHidden = false
        }
        if data.atmLocation.isDepositAvailable{
            self.cashImage.isHidden = false
        }
        if data.atmLocation.isHandicappedAccessible{
            self.wheelchairImage.isHidden=false
        }
    }
}
