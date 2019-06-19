//
//  TransactionHistoryData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 03/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct TransactionHistoryData: Codable {
    let errorCode, httpCode: String
    let limit, page, pageCount: Int
    let success: Bool
    let trans: [IndividualTransaction]
    let transCount: Int
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case httpCode = "http_code"
        case limit, page
        case pageCount = "page_count"
        case success, trans
        case transCount = "trans_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(String.self, forKey: .errorCode) ?? ""
        httpCode = try values.decodeIfPresent(String.self, forKey: .httpCode) ?? ""
        limit = try values.decodeIfPresent(Int.self, forKey: .limit) ?? 0
        page = try values.decodeIfPresent(Int.self, forKey: .page) ?? 0
        pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount) ?? 0
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        trans = try values.decodeIfPresent(Array<IndividualTransaction>.self, forKey: .trans)!

        transCount = try values.decodeIfPresent(Int.self, forKey: .transCount) ?? 0

        
    }
}
