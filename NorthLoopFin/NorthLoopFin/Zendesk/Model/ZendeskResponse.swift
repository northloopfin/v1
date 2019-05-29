//
//  Zendesk.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct ZendeskResponse: Codable {
    let message: String
    let data: ZendeskData
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        data = try values.decodeIfPresent(ZendeskData.self, forKey: .data)!
    }
}
