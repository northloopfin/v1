//
//  CalendarTableViewCell.swift
//  Test
//
//  Created by Admin on 8/1/19.
//  Copyright © 2019 itworksinua. All rights reserved.
//

import UIKit

protocol CalendarTableViewCellDelegate: class {
    func onPeriod(_ cell:UITableViewCell)
}

class CalendarTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    public weak var delegate: CalendarTableViewCellDelegate?
    
    var dateTitle:String? {
        didSet {
            labelTitle.text = dateTitle ?? ""
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onSelect(_ sender: Any) {
        delegate?.onPeriod(self)
    }
}
