//
//  AddressVerificationTableViewCell.swift
//  Test
//
//  Created by Admin on 8/3/19.
//  Copyright © 2019 itworksinua. All rights reserved.
//

import UIKit

class AddressVerificationTableViewCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imgIconNew: UIImageView!
    
    var option:AddreddCompareModel? {
        didSet {
            labelTitle.text = option?.title ?? ""
            if !(option?.isEqual ?? true) {
                labelTitle.textColor = UIColor(red: 46.0/255, green: 144.0/255, blue: 40.0/255, alpha: 1.0)
                imgIconNew.isHidden = false
            } else {
                labelTitle.textColor = UIColor.black
                imgIconNew.isHidden = true
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
