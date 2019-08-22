//
//  FetchCashback.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 21/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol FetchCashbackDelegate:BaseViewProtocol {
    func didFetchCashback(data:[CashbackDetail])
}

// MARK: - UserAnalysisCategories
struct FetchCashback: Codable {
    let data: [CashbackDetail]
}

// MARK: - AnalysisCategories
struct CashbackDetail: Codable {
    let value: Double
    let transactions: [CashbackTransaction]
}

struct CashbackTransaction: Codable {
    let cashback: String
//    let transactionID: String
//    let merchant_name: String
}
