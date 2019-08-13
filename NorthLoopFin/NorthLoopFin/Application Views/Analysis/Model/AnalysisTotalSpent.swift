//
//  AnalysisTotalSpent.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 13/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

struct AnalysisTotalData: Codable {
    let data: [AnalysisTotalSpent]
}

// MARK: - AnalysisCategories
struct AnalysisTotalSpent: Codable {
    let sumAmount: Double
    
    enum CodingKeys: String, CodingKey {
        case sumAmount = "sum_amount"
    }
}
