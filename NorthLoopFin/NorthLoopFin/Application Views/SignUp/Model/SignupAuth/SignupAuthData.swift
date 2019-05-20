//
//  SignupAuthData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 17/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct SignupAuthData: Codable {
    let id: String
    let emailVerified: Bool
    let email: String
    let statusCode: Int
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case emailVerified = "email_verified"
        case email, statusCode
        case accessToken="access_token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        emailVerified = try values.decodeIfPresent(Bool.self, forKey: .emailVerified) ?? false
        email = try values.decodeIfPresent(String.self, forKey: .email) ?? ""
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? 0
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken) ?? ""
    }
}
