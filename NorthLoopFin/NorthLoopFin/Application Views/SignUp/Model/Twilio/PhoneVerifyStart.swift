//
//  PhoneVerifyStart.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 31/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//


import Foundation

struct PhoneVerifyStart: Codable {
    let carrier: String
    let isCellphone: Bool
    let message: String
    let secondsToExpire: Int
    let uuid: String
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case carrier
        case isCellphone = "is_cellphone"
        case message
        case secondsToExpire = "seconds_to_expire"
        case uuid, success
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        carrier = try values.decodeIfPresent(String.self, forKey: .carrier) ?? ""
        isCellphone = try values.decodeIfPresent(Bool.self, forKey: .isCellphone) ?? false
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        secondsToExpire = try values.decodeIfPresent(Int.self, forKey: .secondsToExpire) ?? 0
        uuid = try values.decodeIfPresent(String.self, forKey: .uuid) ?? ""
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
    }
}
