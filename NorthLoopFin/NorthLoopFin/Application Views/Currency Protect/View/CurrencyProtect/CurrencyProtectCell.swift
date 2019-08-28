//
//  CurrencyProtectCell.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 08/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CurrencyProtectCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(data: WireTransaction){
        lblTitle.text = data.wire_from
        if let wireDate = AppUtility.getDateObjectFromUTCFormat(dateStr: data.date){
           lblSubTitle.text =  AppUtility.timeStringWithDay(date: wireDate)  + " , " +  AppUtility.getDashedDateStringWithoutTime(date: wireDate)
        }else{
            lblSubTitle.text = ""
        }
        
        lblAmount.text = "$ " + data.amount
    }
}
