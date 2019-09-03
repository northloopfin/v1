//
//  RoutingVerification.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol RoutingVerificationDelegate:BaseViewProtocol {
    func didRoutingVerified()
    func failedRoutingVerification()
}

struct RoutingVerification: Codable {
    let error_code: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case error_code = "error_code"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error_code = try values.decodeIfPresent(String.self, forKey: .error_code) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}

