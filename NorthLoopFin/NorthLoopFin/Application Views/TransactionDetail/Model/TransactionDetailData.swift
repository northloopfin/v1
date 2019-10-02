//
//  TransactionDetailData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct TransactionDetailData: Codable {
    let id: String
    let v: Int
    let amount: TransactionDetailAmount
    let client: Client
    let extra: TransactionListExtra
    //let fees: [Fee]
    //let from: From
    //let recentStatus: RecentStatus
    //let timeline: [RecentStatus]
    let to: TransactionListTo
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "_v"
        case amount, client, extra
        case to
        case statusCode
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        v = try values.decodeIfPresent(Int.self, forKey: .v) ?? 0
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? 0
        amount = try values.decodeIfPresent(TransactionDetailAmount.self, forKey: .amount)!
        client = try values.decodeIfPresent(Client.self, forKey: .client)!
        extra = try values.decodeIfPresent(TransactionListExtra.self, forKey: .extra)!
        to = try values.decodeIfPresent(TransactionListTo.self, forKey: .to)!
    }
    
}
