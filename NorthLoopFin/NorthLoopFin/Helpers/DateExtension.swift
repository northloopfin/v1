//
//  DateExtension.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 12/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}
