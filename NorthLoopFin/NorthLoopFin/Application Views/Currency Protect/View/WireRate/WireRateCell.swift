//
//  WireCell.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 07/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class WireRateCell: UITableViewCell {

    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var amountField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(data: ExchangeRate){
        amountField.text = data.inr
        
        if let inr = Double(amountField.text!) {
            amountField.text = String(format: "%.2f INR" , inr)
        }
        
        if let wireDate = AppUtility.getDateObjectFromUTCFormat(dateStr: data.date){
            dateField.text = AppUtility.getDashedDateStringWithoutTime(date: wireDate)
        }else{
            dateField.text = ""
        }
    }
}
