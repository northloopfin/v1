//
//  UpdateCardPreferenceBody.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 04/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class UpdateCardPreferenceBody: Codable {
    var allowForeignTransactions: Bool
    var dailyATMWithdrawalLimit, dailyTransactionLimit: Int
    
    enum CodingKeys: String, CodingKey {
        case allowForeignTransactions = "allow_foreign_transactions"
        case dailyATMWithdrawalLimit = "daily_atm_withdrawal_limit"
        case dailyTransactionLimit = "daily_transaction_limit"
    }
    
 init(allowForeignTransactions:Bool,dailyATMWithdrawalLimit:Int,dailyTransactionLimit:Int) {
        self.allowForeignTransactions = allowForeignTransactions
    self.dailyATMWithdrawalLimit = dailyATMWithdrawalLimit
    self.dailyTransactionLimit = dailyTransactionLimit
    }
}
