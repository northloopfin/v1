//
//  TransferDetailTableViewCell.swift
//  NorthLoopFin
//
//  Created by Gaurav Malik on 20/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class TransferDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var mainTitleLabel: LabelWithLetterSpace!
    @IBOutlet weak var subtitleLabel: LabelWithLetterSpace!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(data:TransferDetailCellModel){
        self.mainTitleLabel!.text = data.mainTitleText
        self.detailTextLabel!.text = data.detailTitleText
    }
}
