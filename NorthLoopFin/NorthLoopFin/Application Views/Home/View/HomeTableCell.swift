//
//  HomeTableCell.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import UIKit
import Kingfisher

protocol HomeTableCellDelegate: class  {
    func disputeTransactionClicked(data:IndividualTransaction)
}
class HomeTableCell: UITableViewCell {

    @IBOutlet weak var beneficiaryName: UILabel!
    @IBOutlet weak var transactionAmt: UILabel!
    @IBOutlet weak var beneficiaryImg: UIImageView!
    var individualTransaction:IndividualTransaction?
    private weak var delegate: HomeTableCellDelegate?
    
    @IBAction func disputeBtnClicked(_ sender: Any) {
        if let _ = self.individualTransaction{
            self.delegate?.disputeTransactionClicked(data: self.individualTransaction!)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(data: IndividualTransaction,delegate:HomeTableCellDelegate){
        self.delegate = delegate
        self.individualTransaction=data
        if data.to.type == "EXTERNAL-US"{
            if let _  = data.to.meta{
                self.beneficiaryName.text = data.to.meta?.merchantName
                let url = URL(string: (data.to.meta?.merchantLogo)!)
                self.beneficiaryImg.kf.setImage(with: url)
            }
        }else if data.to.type == "ACH-US"{
            self.beneficiaryName.text = data.to.user.legalNames[0]
        }        
        self.transactionAmt.text = "$" + String(data.amount.amount)
        
    }
}
