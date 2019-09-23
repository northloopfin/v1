//
//  CampusCashbackCell.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 23/09/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CampusCashbackCell: UITableViewCell {

    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var imgPreview: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var vwContent: UIView!
    
    @IBOutlet weak var lblCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(data:Campus, selected:Bool){
        lblTitle.text = data.name
        lblSubTitle.text = String(data.cashback_percentage) + "% cashback"
        btnLike.setTitle(String(data.vote_percentage) + "%", for: .normal)
        lblCount.backgroundColor = selected ? Colors.PurpleColor17673149 : Colors.whiteColor
        lblCount.textColor = !selected ? Colors.PurpleColor17673149 : Colors.whiteColor
        vwContent.borderColor = selected ? Colors.PurpleColor17673149 : Colors.whiteColor
        vwContent.borderWidth = 1
    }
    
}
