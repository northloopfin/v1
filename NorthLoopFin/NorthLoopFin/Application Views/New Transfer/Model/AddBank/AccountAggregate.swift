//
//  AccountAggregate.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct AccountAggregateData: Codable {
    let errorCode,httpCode: String
    let success: Bool
    let statusCode: Int
    let mfa: MFA?

     enum CodingKeys: String, CodingKey {
        case success
        case statusCode
        case mfa
        case errorCode = "error_code"
        case httpCode = "http_code"
    }
    
    init(from decoder: Decoder) throws {
        let val = try decoder.container(keyedBy: CodingKeys.self)
        
        errorCode = try val.decodeIfPresent(String.self, forKey: .errorCode) ?? ""
        httpCode = try val.decodeIfPresent(String.self, forKey: .httpCode) ?? ""
        success = try val.decodeIfPresent(Bool.self, forKey: .success) ?? false
        statusCode = try val.decodeIfPresent(Int.self, forKey: .statusCode) ?? 0
        mfa = try val.decodeIfPresent(MFA.self, forKey: .mfa) ?? nil
    }
}


struct AccountAggregate: Codable {
    let data: AccountAggregateData
    let message: String

    enum CodingKeys: String, CodingKey {
        case data
        case message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(AccountAggregateData.self, forKey: .data)!
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
}

struct MFA: Codable {
    let accessToken,message,type: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case message
        case type
    }
    
    init(from decoder: Decoder) throws {
        let val = try decoder.container(keyedBy: CodingKeys.self)
        
        accessToken = try val.decodeIfPresent(String.self, forKey: .accessToken) ?? ""
        message = try val.decodeIfPresent(String.self, forKey: .message) ?? ""
        type = try val.decodeIfPresent(String.self, forKey: .type) ?? ""
    }
}



protocol AccountAggregateDelegate:BaseViewProtocol {
    func didFetchAccountAggregate(data:AccountAggregate)
    
}

