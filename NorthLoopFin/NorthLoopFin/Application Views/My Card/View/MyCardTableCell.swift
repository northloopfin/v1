//
//  MyCardTableCell.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import PWSwitch

protocol MyCardTableCellDelegate:class {
    func switchClicked(isOn:Bool,tag:Int)
}

class MyCardTableCell: UITableViewCell {
    
     weak var delegate: MyCardTableCellDelegate?

    @IBAction func switchClicked(_ sender: Any) {
        let lock = sender as! UISwitch
        print(lock.isOn)
        self.delegate?.switchClicked(isOn: lock.isOn, tag: lock.tag)

    }
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
    func bindData(data:MyCardOtionsModel,delegate:MyCardTableCellDelegate){
        optionLbl.text = data.option
        if(data.haveSwitch){
            let shadowOffst = CGSize.init(width: 0, height: -55)
            let shadowOpacity = 0.1
            let shadowRadius = 49
            let shadowColor = Colors.PurpleColor17673149
            self.lock.layer.addShadowAndRoundedCorners(roundedCorner: 15.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
            lock.isHidden=false
            lock.setOn(data.isSwitchSelected, animated: true)

        }else{
            lock.isHidden=true
        }
    }
    
}
