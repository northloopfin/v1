//
//  IndividualTransaction.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 03/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct IndividualTransaction: Codable {
    let id: String
    let v: Int
    let amount: Amount
    let client: Client
    let extra: TransactionListExtra
//    let fees: [Fee]
    let from: TransactionListFrom
    let recentStatus: RecentStatus
    let date : Date
//    let timeline: [RecentStatus]
    let to: TransactionListFrom
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "_v"
        case amount, client, extra,from
        case recentStatus = "recent_status"
        case to
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        v = try values.decodeIfPresent(Int.self, forKey: .v) ?? 0
        amount = try values.decodeIfPresent(Amount.self, forKey: .amount)!
        client = try values.decodeIfPresent(Client.self, forKey: .client)!
        extra = try values.decodeIfPresent(TransactionListExtra.self, forKey: .extra)!
        from = try values.decodeIfPresent(TransactionListFrom.self, forKey: .from)!
        recentStatus = try values.decodeIfPresent(RecentStatus.self, forKey: .recentStatus)!
        to = try values.decodeIfPresent(TransactionListFrom.self, forKey: .to)!

        let dateString = AppUtility.dateFromMilliseconds(seconds: Double(extra.createdOn))
        date = AppUtility.getDateFromString(dateString: dateString)
    }
}
