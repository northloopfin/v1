//
//  RecentStatus.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 13/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct RecentStatus: Codable {
    let date: Int
    let note: String
    let status: String
    let statusId: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case note
        case status
        case statusId = "status_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(Int.self, forKey: .date) ?? 0
        note = try values.decodeIfPresent(String.self, forKey: .note) ?? ""
        status = try values.decodeIfPresent(String.self, forKey: .status) ?? ""
        statusId = try values.decodeIfPresent(String.self, forKey: .statusId) ?? ""
    }
}
