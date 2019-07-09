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
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}
