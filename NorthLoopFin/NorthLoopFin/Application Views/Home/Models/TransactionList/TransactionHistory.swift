//
//  TransactionHistory.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 13/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


struct TransactionHistory: Codable {
    let amount: Amount
    let recentStatus: RecentStatus
    let to: Recipient
    var createdAt:String = ""
    
    enum CodingKeys: String, CodingKey {
        case amount
        case recentStatus = "recent_status"
        case to
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(Amount.self, forKey: .amount)!
        recentStatus = try values.decodeIfPresent(RecentStatus.self, forKey: .recentStatus)!
        to = try values.decodeIfPresent(Recipient.self, forKey: .to)!
        createdAt = AppUtility.dateFromMilliseconds(seconds: Double(recentStatus.date))
    }
}
