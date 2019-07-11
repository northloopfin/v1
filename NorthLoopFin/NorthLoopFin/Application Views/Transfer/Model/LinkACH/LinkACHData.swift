//
//  LinkACHData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct LinkACHData: Codable {
    let errorCode, httpCode: String
    let limit, nodeCount: Int
    let pageCount: Int
    let success: Bool
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case httpCode = "http_code"
        case limit
        case nodeCount = "node_count"
        case pageCount = "page_count"
        case success, statusCode
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(String.self, forKey: .errorCode) ?? ""
        httpCode = try values.decodeIfPresent(String.self, forKey: .httpCode) ?? ""
        limit = try values.decodeIfPresent(Int.self, forKey: .limit) ?? 0
        nodeCount = try values.decodeIfPresent(Int.self, forKey: .nodeCount) ?? 0
        pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount) ?? 0
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode) ?? 0
        
    }
}
