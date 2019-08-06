//
//  AnalysisCategories.swift
//  NorthLoopFin
//
//  Created by Admin on 8/6/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

// MARK: - UserAnalysisCategories
struct AnalysisOptions: Codable {
    let data: [AnalysisOption]
}

// MARK: - AnalysisCategories
struct AnalysisOption: Codable {
    let toMerchantCategory: String
    let sumAmount: Double
    
    enum CodingKeys: String, CodingKey {
        case toMerchantCategory = "to_merchant_category"
        case sumAmount = "sum_amount"
    }
}

struct UserAnalysisCategory {
    let categoryKey: String
    let sumAmount: Double
    var categoryTitle: String
    var categoryIcon: String
    var categotyColor: UIColor
    
    init(_ analysisOption: AnalysisOption) {
        self.categoryKey = analysisOption.toMerchantCategory
        self.sumAmount = analysisOption.sumAmount
        switch analysisOption.toMerchantCategory {
        case "subscription_service":
            self.categoryTitle = "Subscriptions"
            self.categoryIcon = "icon_miscellaneous"
            self.categotyColor = UIColor(red: 123/255, green: 186/255, blue: 247/255, alpha: 1.0)
            break
        case "retail":
            self.categoryTitle = "Retail"
            self.categoryIcon = "icon_miscellaneous"
            self.categotyColor = UIColor(red: 123/255, green: 247/255, blue: 219/255, alpha: 1.0)
            break
        case "service":
            self.categoryTitle = "Services"
            self.categoryIcon = "icon_miscellaneous"
            self.categotyColor = UIColor(red: 123/255, green: 186/255, blue: 247/255, alpha: 1.0)
            break
        case "travel/transportation":
            self.categoryTitle = "Travel"
            self.categoryIcon = "icon_miscellaneous"
            self.categotyColor = UIColor(red: 38/255, green: 194/255, blue: 159/255, alpha: 1.0)
            break
        case "dining":
            self.categoryTitle = "Dining"
            self.categoryIcon = "icon_food"
            self.categotyColor = UIColor(red: 204/255, green: 101/255, blue: 167/255, alpha: 1.0)
            break
        case "grocery":
            self.categoryTitle = "Groceries"
            self.categoryIcon = "icon_shopping"
            self.categotyColor = UIColor(red: 113/255, green: 103/255, blue: 201/255, alpha: 1.0)
            break
        case "withdrawal":
            self.categoryTitle = "Cash Withdrawals"
            self.categoryIcon = "icon_entertainment"
            self.categotyColor = UIColor(red: 250/255, green: 120/255, blue: 138/255, alpha: 1.0)
            break
        case "pos":
            self.categoryTitle = "General Spending"
            self.categoryIcon = "icon_miscellaneous"
            self.categotyColor = UIColor(red: 145/255, green: 225/255, blue: 109/255, alpha: 1.0)
            break
        case "medica":
            self.categoryTitle = "Medical"
            self.categoryIcon = "icon_miscellaneous"
            self.categotyColor = UIColor(red: 236/255, green: 178/255, blue: 76/255, alpha: 1.0)
            break
        case "transfer":
            self.categoryTitle = "Transfer"
            self.categoryIcon = "icon_miscellaneous"
            self.categotyColor = UIColor(red: 236/255, green: 160/255, blue: 76/255, alpha: 1.0)
            break
        default:
            self.categoryTitle = "Other"
            self.categoryIcon = "icon_miscellaneous"
            self.categotyColor = .gray
            break
        }
    }
}
