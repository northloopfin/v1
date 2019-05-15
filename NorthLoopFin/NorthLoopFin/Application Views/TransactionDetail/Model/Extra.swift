//
//  Extra.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct Extra: Codable {
    //let asset: JSONNull?
    let createdOn: CreatedOn
    let encryptedNote: String
    //let groupID: JSONNull?
    let ip, latlon, note: String
    let other: Other
    let processOn: CreatedOn
    let sameDay: Bool
    let settlementDelay: Int
    let suppID: String
    
    enum CodingKeys: String, CodingKey {
        //case asset
        case createdOn = "created_on"
        case encryptedNote = "encrypted_note"
        //case groupID = "group_id"
        case ip, latlon, note, other
        case processOn = "process_on"
        case sameDay = "same_day"
        case settlementDelay = "settlement_delay"
        case suppID = "supp_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdOn = try values.decodeIfPresent(CreatedOn.self, forKey: .createdOn)!
        encryptedNote = try values.decodeIfPresent(String.self, forKey: .encryptedNote) ?? ""
        ip = try values.decodeIfPresent(String.self, forKey: .ip) ?? ""
        latlon = try values.decodeIfPresent(String.self, forKey: .latlon) ?? ""
        other = try values.decodeIfPresent(Other.self, forKey: .other)!
        processOn = try values.decodeIfPresent(CreatedOn.self, forKey: .processOn)!

        sameDay = try values.decodeIfPresent(Bool.self, forKey: .sameDay) ?? false
        settlementDelay = try values.decodeIfPresent(Int.self, forKey: .settlementDelay) ?? 0
        suppID = try values.decodeIfPresent(String.self, forKey: .suppID) ?? ""

    }
}
