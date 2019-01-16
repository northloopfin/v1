//
//  SelfSizedTableView.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import UIKit

class SelfSizedTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}
