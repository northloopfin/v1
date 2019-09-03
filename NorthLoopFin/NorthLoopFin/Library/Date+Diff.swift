//
//  Date+Diff.swift
//  NorthLoopFin
//
//  Created by Admin on 9/3/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

extension Date {
    
    static func -(recent: Date, previous: Date) -> (Int?) {
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
        return (second)
    }
    
}
