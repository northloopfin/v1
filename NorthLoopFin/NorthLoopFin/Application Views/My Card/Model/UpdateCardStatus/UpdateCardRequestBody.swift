//
//  UpdateCardRequestBody.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 04/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class UpdateCardRequestBody: Codable {
    var status : String
    var preferences : UpdateCardPreferenceBody
    enum CodingKeys: String, CodingKey {
        case preferences
        case status
    }
    init(status:String,pre:UpdateCardPreferenceBody) {
        self.status = status
        self.preferences = pre
    }
}
