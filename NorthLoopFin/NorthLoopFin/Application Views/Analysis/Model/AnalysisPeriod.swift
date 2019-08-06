//
//  AnalysisPeriod.swift
//  NorthLoopFin
//
//  Created by Admin on 8/6/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

struct AnalysisPeriod {
    let title: String
    let month: String
    let year: String
    let date: Date
    
    init(_ date:Date) {
        self.date = date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        self.title = formatter.string(from: date)
        formatter.dateFormat = "MM"
        self.month = formatter.string(from: date)
        formatter.dateFormat = "yyyy"
        self.year = formatter.string(from: date)
    }
}
