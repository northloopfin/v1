//
//  TransactionListExtra.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 03/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
// MARK: - Extra
struct TransactionListExtra: Codable {
    //let asset: JSONNull?
    let createdOn: Int
    //let groupID: JSONNull?
    let ip, latlon: String
    let location: TransactionListLocation
    let note: String
   // let other: Other
    let processOn: Int
    let sameDay: Bool
    let settlementDelay: Int
    let suppID: String
    //let trackingNumber: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        //case asset
        case createdOn = "created_on"
        //case groupID = "group_id"
        case ip, latlon,location,note
        case processOn = "process_on"
        case sameDay = "same_day"
        case settlementDelay = "settlement_delay"
        case suppID = "supp_id"
       // case trackingNumber = "tracking_number"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdOn = try values.decodeIfPresent(Int.self, forKey: .createdOn) ?? 0
        ip = try values.decodeIfPresent(String.self, forKey: .ip) ?? ""
        latlon = try values.decodeIfPresent(String.self, forKey: .latlon) ?? ""
        location = try values.decodeIfPresent(TransactionListLocation.self, forKey: .location)!
        note = try values.decodeIfPresent(String.self, forKey: .note) ?? ""
        processOn = try values.decodeIfPresent(Int.self, forKey: .processOn) ?? 0
        sameDay = try values.decodeIfPresent(Bool.self, forKey: .sameDay) ?? false
        settlementDelay = try values.decodeIfPresent(Int.self, forKey: .settlementDelay) ?? 0
        suppID = try values.decodeIfPresent(String.self, forKey: .suppID) ?? ""

    }
}
