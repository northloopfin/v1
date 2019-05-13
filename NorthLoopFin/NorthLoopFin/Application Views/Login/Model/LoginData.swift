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
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case basicInformation = "basic_information"
        case statusCode = "statusCode"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken) ?? ""
        basicInformation = try values.decodeIfPresent(BasicInformation.self, forKey: .basicInformation)!
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? 0
        
    }
}
