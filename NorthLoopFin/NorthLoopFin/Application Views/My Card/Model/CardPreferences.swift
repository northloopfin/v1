//
//  CardPreferences.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct CardPreferences: Codable {
    let allowForeignTransactions: Bool
    let dailyATMWithdrawalLimit, dailyTransactionLimit: Int
    
    enum CodingKeys: String, CodingKey {
        case allowForeignTransactions = "allow_foreign_transactions"
        case dailyATMWithdrawalLimit = "daily_atm_withdrawal_limit"
        case dailyTransactionLimit = "daily_transaction_limit"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        allowForeignTransactions = try values.decodeIfPresent(Bool.self, forKey: .allowForeignTransactions) ?? false
        dailyATMWithdrawalLimit = try values.decodeIfPresent(Int.self, forKey: .dailyATMWithdrawalLimit) ?? 0
        dailyTransactionLimit = try values.decodeIfPresent(Int.self, forKey: .dailyTransactionLimit) ?? 0
        
    }
}
