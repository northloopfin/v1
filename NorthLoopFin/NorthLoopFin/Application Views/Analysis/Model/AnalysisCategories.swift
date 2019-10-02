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

struct AnalysisCategory: Codable {
    let data: [AnalysisCategoryData]
}
struct AnalysisCategoryData: Codable {
    let toMerchantCategory,toMerchantName, transId: String
    let sumAmount: Double
    
    enum CodingKeys: String, CodingKey {
        case toMerchantCategory = "to_merchant_category"
        case sumAmount = "amount_amount"
        case toMerchantName = "to_merchant_name"
        case transId = "trans_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        toMerchantName = try values.decodeIfPresent(String.self, forKey: .toMerchantName) ?? ""
        sumAmount = try values.decodeIfPresent(Double.self, forKey: .sumAmount) ?? 0
        toMerchantCategory = try values.decodeIfPresent(String.self, forKey: .toMerchantCategory) ?? ""
        transId = try values.decodeIfPresent(String.self, forKey: .transId) ?? ""
    }
}

struct UserAnalysisCategory {
    let categoryKey: String
    var categoryForTrans: String
    let sumAmount: Double
    var categoryTitle: String
    var categoryIcon: String
    var categotyColor: UIColor
    subscription_service
    retail
    transfer
    init(_ analysisOption: AnalysisOption) {
        self.categoryKey = analysisOption.toMerchantCategory
        self.categoryForTrans = analysisOption.toMerchantCategory
        self.sumAmount = analysisOption.sumAmount
        switch analysisOption.toMerchantCategory {
        case "subscription_service":
            self.categoryTitle = "Subscriptions"
            self.categoryIcon = "icon_subscription"
            self.categotyColor = UIColor(red: 68/255, green: 198/255, blue: 120/255, alpha: 1.0)
            break
        case "retail":
            self.categoryTitle = "Retail"
            self.categoryIcon = "icon_retail"
            self.categotyColor = UIColor(red: 92/255, green: 181/255, blue: 255/255, alpha: 1.0)
            break
        case "service":
            self.categoryTitle = "Services"
            self.categoryIcon = "icon_services"
            self.categotyColor = UIColor(red: 179/255, green: 102/255, blue: 211/255, alpha: 1.0)
            break
        case "travel/transportation":
            self.categoryForTrans = "Travel"
            self.categoryTitle = "Travel"
            self.categoryIcon = "icon_travel"
            self.categotyColor = UIColor(red: 98/255, green: 134/255, blue: 237/255, alpha: 1.0)
            break
        case "travel":
            self.categoryTitle = "Travel"
            self.categoryIcon = "icon_travel"
            self.categotyColor = UIColor(red: 98/255, green: 134/255, blue: 237/255, alpha: 1.0)
            break
        case "transportation":
            self.categoryTitle = "Travel"
            self.categoryIcon = "icon_travel"
            self.categotyColor = UIColor(red: 98/255, green: 134/255, blue: 237/255, alpha: 1.0)
            break
        case "dining":
            self.categoryTitle = "Dining"
            self.categoryIcon = "icon_dining"
            self.categotyColor = UIColor(red: 244/255, green: 140/255, blue: 55/255, alpha: 1.0)
            break
        case "grocery":
            self.categoryForTrans = "grocery"
            self.categoryTitle = "Groceries"
            self.categoryIcon = "icon_groceries"
            self.categotyColor = UIColor(red: 234/255, green: 202/255, blue: 10/255, alpha: 1.0)
            break
        case "withdrawal":
            self.categoryTitle = "Cash Withdrawals"
            self.categoryIcon = "icon_withdraw"
            self.categotyColor = UIColor(red: 57/255, green: 178/255, blue: 198/255, alpha: 1.0)
            break
        case "pos":
            self.categoryTitle = "General Spending"
            self.categoryIcon = "icon_pos"
            self.categotyColor = UIColor(red: 206/255, green: 99/255, blue: 168/255, alpha: 1.0)
            break
        case "medica":
            self.categoryTitle = "Medical"
            self.categoryIcon = "icon_medical"
            self.categotyColor = UIColor(red: 113/255, green: 100/255, blue: 204/255, alpha: 1.0)
            break
        case "transfer":
            self.categoryTitle = "Transfer"
            self.categoryIcon = "icon_transfer"
            self.categotyColor = UIColor(red: 142/255, green: 193/255, blue: 68/255, alpha: 1.0)
            break
        case "entertainment":
            self.categoryTitle = "Entertainment"
            self.categoryIcon = "icon_entertainment"
            self.categotyColor = UIColor(red: 252/255, green: 119/255, blue: 136/255, alpha: 1.0)
            break
        default:
            self.categoryForTrans = "other"
            self.categoryTitle = "Other"
            self.categoryIcon = "icon_miscellaneous"
            self.categotyColor = .gray
            break
        }
    }
}
