//
//  AnalysisCategoryTableHeader.swift
//  Test
//
//  Created by Admin on 7/31/19.
//  Copyright © 2019 itworksinua. All rights reserved.
//

import UIKit
import RKPieChart

class AnalysisCategoryTableHeader: UITableViewHeaderFooterView {
    
    var categories:[UserAnalysisCategory] = [] {
        didSet {
            var totalSum = 0.0
            for category in categories {
                totalSum += category.sumAmount
            }
            var totalSumPercent = 0
            var sumPercent:[Int] = []
            if categories.count == 0 {
                return
            }
            if categories.count == 1 {
                createPie(0, color: categories.first?.categotyColor ?? UIColor.gray, drownSum: 0)
            } else {
                for i in 0...(categories.count - 2) {
                    let percent = Int(round(100.0 * categories[i].sumAmount / totalSum))
                    sumPercent.append(percent)
                    createPie(percent, color: categories[i].categotyColor, drownSum: totalSumPercent)
                    totalSumPercent += percent
                }
            }
        }
    }
    
    func createPie(_ amount:Int, color:UIColor, drownSum:Int) {
        let pie:RKPieChartItem = RKPieChartItem(ratio:uint(amount), color: color, title: "")
        let chartView = RKPieChartView(items: [pie], centerTitle: "")
        chartView.circleColor = drownSum == 0 ? color : .clear
        chartView.arcWidth = 25
        chartView.style = .round
        chartView.isAnimationActivated = false
        chartView.frame = CGRect(x: (self.frame.size.width - 120) / 2, y: 20, width: 120, height: 120)
        chartView.isTitleViewHidden = true
        let startAngle = (360.0 * Double(drownSum) / 100.0) * Double.pi / 180.0
        chartView.transform = chartView.transform.rotated(by: CGFloat(startAngle))
        self.addSubview(chartView)
    }
}
