//
//  MyCardTableCell.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import PWSwitch

class MyCardTableCell: UITableViewCell {
    @IBAction func switchClicked(_ sender: Any) {
//        let lock = sender as! UISwitch
//        if (lock.isOn){
//            lock.thumbTintColor = Colors.Taupe776857
//        }
    }
    @IBOutlet weak var lock: PWSwitch!
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
            let shadowOffst = CGSize.init(width: 0, height: -55)
            let shadowOpacity = 0.1
            let shadowRadius = 49
            let shadowColor = Colors.Zorba161149133
            self.lock.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
            lock.isHidden=false
        }else{
            lock.isHidden=true
        }
    }
    
}
