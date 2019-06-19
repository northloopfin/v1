//
//  ChangePhoneResponse.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 06/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct ChangePhoneResponse: Codable {
    let message: String
    enum CodingKeys: String, CodingKey {
        case message
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
}
