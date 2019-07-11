//
//  AccountResponseData.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 30/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct UserTransferDetailData: Codable {
    let transferDetails: TransferDetails
    
    enum CodingKeys: String, CodingKey {
        case transferDetails
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        transferDetails = try values.decodeIfPresent(TransferDetails.self, forKey: .transferDetails)!
    }
}
