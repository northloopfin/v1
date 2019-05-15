//
//  CardData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 14/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct CardData: Codable {
    let id, accountClass, cardNumber, cardStyleID: String
    let exp, nickname: String
    let preferences: CardPreferences
    let status: String
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case accountClass = "account_class"
        case cardNumber = "card_number"
        case cardStyleID = "card_style_id"
        case exp, nickname, preferences, status, statusCode
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        accountClass = try values.decodeIfPresent(String.self, forKey: .accountClass) ?? ""
        cardNumber = try values.decodeIfPresent(String.self, forKey: .cardNumber) ?? ""
        cardStyleID = try values.decodeIfPresent(String.self, forKey: .cardStyleID) ?? ""
        exp = try values.decodeIfPresent(String.self, forKey: .exp) ?? ""
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname) ?? ""
        preferences = try values.decodeIfPresent(CardPreferences.self, forKey: .preferences)!
        status = try values.decodeIfPresent(String.self, forKey: .status) ?? ""
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? 0
    }
}
