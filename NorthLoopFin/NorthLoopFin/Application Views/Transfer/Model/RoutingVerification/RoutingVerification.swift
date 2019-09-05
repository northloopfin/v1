//
//  RoutingVerification.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol RoutingVerificationDelegate:BaseViewProtocol {
    func didRoutingVerified(data:RoutingVerification)
    func failedRoutingVerification()
}

struct RoutingVerification: Codable {
    let error_code: String
    let bank_name: String
    let address: String
    let logo: String

    enum CodingKeys: String, CodingKey {
        case error_code = "error_code"
        case bank_name = "bank_name"
        case address = "address"
        case logo = "logo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error_code = try values.decodeIfPresent(String.self, forKey: .error_code) ?? ""
        bank_name = try values.decodeIfPresent(String.self, forKey: .bank_name) ?? ""
        address = try values.decodeIfPresent(String.self, forKey: .address) ?? ""
        logo = try values.decodeIfPresent(String.self, forKey: .logo) ?? ""
    }
}

