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
        self.beneficiaryImg.image = nil
    
        if let _  = data.to.meta{
            let imageName = AppUtility.getMerchantCategoryIconName(category: data.to.meta!.merchantCategory)
            if imageName.count > 0{
                self.beneficiaryImg.backgroundColor = UIColor.clear
                self.beneficiaryImg.image = UIImage.init(imageLiteralResourceName: AppUtility.getMerchantCategoryIconName(category: data.to.meta!.merchantCategory))
            }
        }
        
        if data.to.type == "EXTERNAL-US"{
            if let _  = data.to.meta{
                self.beneficiaryName.text = data.to.meta?.merchantName
                let url = URL(string: (data.to.meta?.merchantLogo)!)
                self.beneficiaryImg.kf.setImage(with: url)
            }
            if let _  = data.to.meta, data.to.meta?.type.lowercased() == "ach" {
                self.beneficiaryName.text = data.to.user.legalNames.count > 0 ? data.to.user.legalNames[0] : "No name"
            }
        }else if data.to.type == "ACH-US"{
            self.beneficiaryName.text = data.to.user.legalNames[0]
        } else if data.from.type == "EXTERNAL-US"{
            if let _  = data.from.meta{
                if let name = data.from.meta?.merchantName, !name.isEmpty {
                    self.beneficiaryName.text = name
                } else {
                    if let type = data.from.meta?.type {
                        self.beneficiaryName.text = type
                    }
                }
                if let logo = data.from.meta?.merchantLogo {
                    let url = URL(string:logo)
                    self.beneficiaryImg.kf.setImage(with: url)
                }
            }
        }
        if ( data.to.type == "ACH-US" || data.from.type == "ACH-US") {
            self.beneficiaryImg.clipsToBounds = false
            self.beneficiaryImg.image = UIImage.init(named:"Transfer")
            self.beneficiaryName.text = data.to.nickname
        }else{
            self.beneficiaryImg.clipsToBounds = true
        }
        
        if data.from.type == "DEPOSIT-US", data.from.user.legalNames.count > 0, data.from.user.legalNames[0] == "NORTH LOOP TECHNOLOGIES INC" {
            self.beneficiaryImg.image = UIImage.init(named:"Transfer")
            self.beneficiaryImg.clipsToBounds = false
        }
        
        if let _  = data.from.meta, data.from.meta?.type.lowercased() == "wire" {
            self.beneficiaryImg.image = UIImage.init(named:"Transfer")
            self.beneficiaryImg.clipsToBounds = false
        }
        
        self.transactionAmt.textColor = data.to.type == "DEPOSIT-US" ? Colors.AmountGreen241770 : self.beneficiaryName.textColor
        if let _  = data.to.meta, data.to.meta?.merchantCategory == "withdrawal" {
            self.beneficiaryName.text = "Withdrawal"
        }
        self.transactionAmt.text = "$" + String(format: "%.2f",data.amount.amount)
        
        if data.recentStatus.status.lowercased() == "returned"{
            let attributeString =  NSMutableAttributedString(string: self.transactionAmt.text!)
            
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                         value: NSUnderlineStyle.single.rawValue,
                                         range: NSMakeRange(0, attributeString.length))
            self.transactionAmt.attributedText = attributeString
        }
    }
}
