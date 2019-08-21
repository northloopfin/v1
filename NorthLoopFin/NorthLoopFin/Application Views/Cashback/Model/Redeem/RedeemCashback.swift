//
//  RedeemCashback.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 21/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol RedeemCashbackDelegate:BaseViewProtocol {
    func didRedeemCashback(data:RedeemCashback)
}

// MARK: - UserAnalysisCategories
struct RedeemCashback: Codable {
    let data: String
}
