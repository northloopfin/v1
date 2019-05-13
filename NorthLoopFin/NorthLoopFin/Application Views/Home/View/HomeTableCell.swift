//
//  HomeTableCell.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableCell: UITableViewCell {

    @IBOutlet weak var beneficiaryName: UILabel!
    @IBOutlet weak var transactionAmt: UILabel!
    @IBOutlet weak var beneficiaryImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(data: TransactionHistory){
        self.beneficiaryName.text = data.to.merchantName
        self.transactionAmt.text = "$" + String(data.amount.amount)
        let url = URL(string: data.to.merchantLogo)
        self.beneficiaryImg.kf.setImage(with: url)
    }
//    func bindData(data: Dummy){
//        self.beneficiaryName.text = data.name
//        self.transactionAmt.text =  String(data.amount)
//        self.beneficiaryImg.image = data.image
//    }
    
}
