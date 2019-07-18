//
//  ACHAccountCell.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 18/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

protocol ACHCellDelegate: class  {
    func removeClicked(data:ACHNode)
}

class ACHAccountCell: UITableViewCell {

    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var bankName: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var vwContainer: UIView!
    private weak var delegate: ACHCellDelegate?

    var data:ACHNode?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShadow(view:vwContainer)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addShadow(view:UIView){
        //set shadow to container view
        let shadowOffst = CGSize.init(width: 0, height: 26)
        let shadowOpacity = 0.15
        let shadowRadius = 30
        let shadowColor = Colors.Taupe776857
        view.layer.addShadowAndRoundedCorners(roundedCorner: 12.0, shadowOffset: shadowOffst, shadowOpacity: Float(shadowOpacity), shadowRadius: CGFloat(shadowRadius), shadowColor: shadowColor.cgColor)
    }
    
    func bindData(data: ACHNode,delegate:ACHCellDelegate){
        self.data = data
        self.delegate = delegate
        self.nickName.text = "Nickname: " + data.nickname
        self.bankName.text = "Bank Name: " + data.bank_name
        self.accountNumber.text = "Account Number: " + data.account_num
    }
    
    @IBAction func removeBtnClicked(_ sender: Any) {
        if let _ = self.data{
            self.delegate?.removeClicked(data: self.data!)
        }
    }

}
