//
//  SelectIDType.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 19/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class SelectIDType{
    var type: AppConstants.SelectIDTYPES
    var images: [UIImage] = []
    
    init(type:AppConstants.SelectIDTYPES, images:[UIImage]) {
        self.type = type
        self.images = images
    }
}
