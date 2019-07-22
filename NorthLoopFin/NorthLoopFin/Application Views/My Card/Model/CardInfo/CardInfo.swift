//
//  CardInfo.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct CardInfo: Codable {
    let card_number: String
    let nickname: String
    let cvc: String
    let exp: String

    enum CodingKeys: String, CodingKey {
        case card_number
        case nickname
        case cvc
        case exp
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        card_number = try values.decodeIfPresent(String.self, forKey: .card_number) ?? ""
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname) ?? ""
        cvc = try values.decodeIfPresent(String.self, forKey: .cvc) ?? ""
        exp = try values.decodeIfPresent(String.self, forKey: .exp) ?? ""
    }
}
