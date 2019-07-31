//
//  CalendarTableViewCell.swift
//  Test
//
//  Created by Admin on 8/1/19.
//  Copyright © 2019 itworksinua. All rights reserved.
//

import UIKit

protocol CalendarTableViewCellDelegate: class {
    func onDate(_ title:String?)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            super.setSelected(selected, animated: animated)
            delegate?.onDate(dateTitle)
        }
    }
    
}
