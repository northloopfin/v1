//
//  ScanOptionCell.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 19/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit


class clsScanOption: NSObject{
    
    var title:String = ""
    var subTitle:String = ""
    var imgName:String = ""
    
    override init() {
        
    }
    
    init(_ title : String, _ subtitle : String, _ image : String) {
        self.title = title
        self.subTitle = subtitle
        self.imgName = image
    }
}


class ScanOptionCell: UITableViewCell {
    @IBOutlet weak var imgPreview: UIImageView!
    @IBOutlet weak var lblTitle: LabelWithLetterSpace!
    @IBOutlet weak var lblSubtitle: LabelWithLetterSpace!
    @IBOutlet weak var btnNext: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(option:clsScanOption) {
        self.lblTitle.text = option.title
        self.lblSubtitle.text = option.subTitle
        self.imgPreview.image = UIImage(named: option.imgName)
    }
}
