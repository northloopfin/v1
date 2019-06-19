//
//  ATMFinderData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
struct ATMFinderData: Codable {
    let atms: [ATM]
    let atmsCount: Int
    let errorCode, httpCode: String
    let limit, page, pageCount: Int
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case atms
        case atmsCount = "atms_count"
        case errorCode = "error_code"
        case httpCode = "http_code"
        case limit, page
        case pageCount = "page_count"
        case success
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        atms = try values.decodeIfPresent(Array<ATM>.self, forKey: .atms)!
        atmsCount = try values.decodeIfPresent(Int.self, forKey: .atmsCount) ?? 0
        errorCode = try values.decodeIfPresent(String.self, forKey: .errorCode) ?? ""
        httpCode = try values.decodeIfPresent(String.self, forKey: .httpCode) ?? ""
        limit = try values.decodeIfPresent(Int.self, forKey: .limit) ?? 0
        page = try values.decodeIfPresent(Int.self, forKey: .page) ?? 0
        pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount) ?? 0
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
       
    }
}
