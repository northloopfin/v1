//
//  MyCardOtionsModel.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct MyAccountOptionsModel {
    let option: String
    let imageName: String
    
    init(_ option:String, image:String){
        self.option = option
        self.imageName = image
    }
}
