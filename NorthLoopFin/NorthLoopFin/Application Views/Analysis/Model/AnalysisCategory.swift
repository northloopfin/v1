//
//  AnalysisCategory.swift
//  Test
//
//  Created by Admin on 7/31/19.
//  Copyright © 2019 itworksinua. All rights reserved.
//

import Foundation

struct AnalysisCategory {
    let summa: Int
    let title: String
    let iconName: String
    let type: AnalysisCategoryType
    
    enum AnalysisCategoryType {
        case entertainment
        case food
        case shopping
        case miscellaneous
    }
    
    init(summa: Int?, type:AnalysisCategoryType) {
        self.summa = summa ?? 0
        self.type = type
        switch type {
        case .entertainment:
            title = "Entertainment"
            iconName = "icon_entertainment"
            break
        case .food:
            title = "Food and Dining"
            iconName = "icon_food"
            break
        case .shopping:
            title = "Shopping"
            iconName = "icon_shopping"
            break
        case .miscellaneous:
            title = "Miscellaneous"
            iconName = "icon_miscellaneous"
            break
        }
    }
}
