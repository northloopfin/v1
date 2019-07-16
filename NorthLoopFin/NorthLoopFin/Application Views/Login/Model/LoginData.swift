//
//  LoginData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 12/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct LoginData: Codable {
    let accessToken: String
    let basicInformation: BasicInformation
    let isVerified: Bool
    let oAuthKey: String
    let statusCode: Int
    let userID:String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case basicInformation = "basic_information"
        case isVerified = "isVerified"
        case oAuthKey = "oAuth_key"
        case statusCode = "statusCode"
        case userID = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken) ?? ""
        isVerified = try values.decodeIfPresent(Bool.self, forKey: .isVerified) ?? false
        oAuthKey = try values.decodeIfPresent(String.self, forKey: .oAuthKey) ?? ""
        basicInformation = try values.decodeIfPresent(BasicInformation.self, forKey: .basicInformation)!
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? 0
        userID = try values.decodeIfPresent(String.self, forKey: .userID) ?? ""
        
    }
}
