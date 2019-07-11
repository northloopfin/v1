//
//  TransactionHistoryData.swift
//  
//
//  Created by Daffolapmac-19 on 03/06/19.
//

import Foundation

struct DataClass: Codable {
    let errorCode, httpCode: String
    let limit, page, pageCount: Int
    let success: Bool
    let trans: [Tran]
    let transCount: Int
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case httpCode = "http_code"
        case limit, page
        case pageCount = "page_count"
        case success, trans
        case transCount = "trans_count"
    }
}
