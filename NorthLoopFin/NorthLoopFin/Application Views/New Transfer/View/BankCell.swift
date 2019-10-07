//
//  DebitFromCell.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 09/09/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


class BankCell: UITableViewCell {
    
    @IBOutlet weak var imgCheckbox: UIImageView!
    @IBOutlet weak var bankName: LabelWithLetterSpace!
    @IBOutlet weak var imgBank: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(){
    }
    
    func bindData(data:Institutions){
        self.bankName.text = data.bankName
        self.btnDelete.isHidden = true
        self.imgBank.image = nil
        if let imgUrl = data.logo.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            if let url = URL(string:imgUrl){
                self.imgBank.setImageWith(url)
            }
        }
    }
    
    func bindData(data:ACHNode){
        self.bankName.text = data.nickname
        self.imgBank.image = nil
        if let imgUrl = data.bank_logo.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            if let url = URL(string:imgUrl){
                self.imgBank.setImageWith(url)
            }
        }
    }
}
