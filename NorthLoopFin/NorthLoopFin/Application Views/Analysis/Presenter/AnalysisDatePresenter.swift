//
//  AnalysisDatePresenter.swift
//  NorthLoopFin
//
//  Created by Admin on 8/6/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class AnalysisDatePresenter {

    func getDateListForAnalysis() -> [AnalysisPeriod] {
        var peridList:[AnalysisPeriod] = []
        for i in 0...12 {
            if let date = Calendar.current.date(byAdding: .month, value: (-1 * i), to: Date()) {
                let currentDate = AnalysisPeriod.init(date)
                peridList.append(currentDate)
            }
        }
        return peridList.reversed()
    }
}
