//
//  AnalysisCategoryTableViewCell.swift
//  Test
//
//  Created by Admin on 7/31/19.
//  Copyright © 2019 itworksinua. All rights reserved.
//

import UIKit

class AnalysisCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSumma: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var category:UserAnalysisCategory? {
        didSet {
            labelTitle.text = category?.categoryTitle ?? ""
            imgIcon.image = UIImage.init(named: category?.categoryIcon ?? "")
//            let formatter = NumberFormatter()
//            formatter.locale = Locale.current
//            formatter.numberStyle = .currency
//            if let formattedTipAmount = formatter.string(from: NSNumber(value: (category?.sumAmount ?? 0))) {
                labelSumma.text = "$ " + String(category?.sumAmount ?? 0)
//            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
