//
//  TransactionDetailData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct TransactionDetailData: Codable {
    let id: ID
    let v: Int
    let amount: Amount
    let client: Client
    let extra: Extra
    //let fees: [Fee]
    //let from: From
    //let recentStatus: RecentStatus
    //let timeline: [RecentStatus]
    let to: Recipient
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "_v"
        case amount, client, extra, fees, from
        case recentStatus = "recent_status"
        case timeline, to, statusCode
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(ID.self, forKey: .id)!
        v = try values.decodeIfPresent(Int.self, forKey: .v) ?? 0
        amount = try values.decodeIfPresent(Amount.self, forKey: .amount)!
        client = try values.decodeIfPresent(Client.self, forKey: .client)!
        extra = try values.decodeIfPresent(Extra.self, forKey: .extra)!
        to = try values.decodeIfPresent(Recipient.self, forKey: .to)!
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? 0
    }
    
}
