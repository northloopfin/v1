//
//  SelfieImage.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 02/03/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import RealmSwift

class SelfieImage: Object {
    @objc dynamic var email = ""
    @objc dynamic var type = ""
    @objc dynamic var imagePath = ""
}
