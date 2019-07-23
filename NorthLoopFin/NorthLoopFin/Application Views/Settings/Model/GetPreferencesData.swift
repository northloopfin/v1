//
//  GetPreferencesData.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 01/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


struct GetPreferencesData: Codable {
    let transaction, dealsOffers, lowBalance, tipSuggestion: Bool
    let tipPercentage: Int
    
    enum CodingKeys: String, CodingKey {
        case transaction
        case dealsOffers = "deals_offers"
        case lowBalance = "low_balance"
        case tipSuggestion = "tip_suggestion"
        case tipPercentage = "tip_percentage"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        transaction = try values.decodeIfPresent(Bool.self, forKey: .transaction) ?? false
        dealsOffers = try values.decodeIfPresent(Bool.self, forKey: .dealsOffers) ?? false
        lowBalance = try values.decodeIfPresent(Bool.self, forKey: .lowBalance) ?? false
        tipSuggestion = try values.decodeIfPresent(Bool.self, forKey: .tipSuggestion) ?? false
        tipPercentage = try values.decodeIfPresent(Int.self, forKey: .tipPercentage) ?? 0
    }
}
