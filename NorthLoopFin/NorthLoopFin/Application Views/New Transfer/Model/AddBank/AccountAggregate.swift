//
//  AccountAggregate.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct AccountAggregateData: Codable {
    let errorCode,httpCode,access_token: String
    let success: Bool
    let statusCode: Int
    let nodeCount: Int
    let mfa: MFA?
    let nodes: [NodeData]

     enum CodingKeys: String, CodingKey {
        case success
        case statusCode
        case mfa
        case nodes
        case access_token
        case errorCode = "error_code"
        case httpCode = "http_code"
        case nodeCount = "node_count"
    }
    
    init(from decoder: Decoder) throws {
        let val = try decoder.container(keyedBy: CodingKeys.self)
        
        access_token =  try val.decodeIfPresent(String.self, forKey: .access_token) ?? ""
        errorCode = try val.decodeIfPresent(String.self, forKey: .errorCode) ?? ""
        httpCode = try val.decodeIfPresent(String.self, forKey: .httpCode) ?? ""
        success = try val.decodeIfPresent(Bool.self, forKey: .success) ?? false
        statusCode = try val.decodeIfPresent(Int.self, forKey: .statusCode) ?? 0
        nodeCount = try val.decodeIfPresent(Int.self, forKey: .nodeCount) ?? 0
        mfa = try val.decodeIfPresent(MFA.self, forKey: .mfa) ?? nil
        nodes = try val.decodeIfPresent(Array<NodeData>.self, forKey: .nodes) ?? []
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

struct NodeData: Codable {
    let info: ACHNode
    let nodeid: String

    enum CodingKeys: String, CodingKey {
        case info
        case nodeid = "_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        info = try values.decodeIfPresent(ACHNode.self, forKey: .info)!
        nodeid = try values.decodeIfPresent(String.self, forKey: .nodeid) ?? ""
    }
}


protocol AccountAggregateDelegate:BaseViewProtocol {
    func didFetchAccountAggregate(data:AccountAggregate)
    
}

