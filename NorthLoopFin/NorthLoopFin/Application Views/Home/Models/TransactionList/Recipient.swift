//
//  Recipient.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 13/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct Recipient: Codable {
    let address: String
    let foreignTransaction: Bool
    let merchantCategory: String
    let merchantLogo: String
    let merchantName: String
    let merchantOfficialPage: String
    let merchantPhoneNumber: String
    let merchantSubcategory: String
    let primaryCategory: String
    let secondaryCategory: String
    let surcharge: String
    let type: String
    let nickname: String

    
    enum CodingKeys: String, CodingKey {
        case address
        case foreignTransaction = "foreign_transaction"
        case merchantCategory = "merchant_category"
        case merchantLogo = "merchant_logo"
        case merchantName = "merchant_name"
        case merchantOfficialPage = "merchant_official_page"
        case merchantPhoneNumber = "merchant_phone_number"
        case merchantSubcategory = "merchant_subcategory"
        case primaryCategory = "primary_category"
        case secondaryCategory = "secondary_category"
        case surcharge
        case type
        case nickname
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address) ?? ""
        foreignTransaction = try values.decodeIfPresent(Bool.self, forKey: .foreignTransaction) ?? false
        merchantCategory = try values.decodeIfPresent(String.self, forKey: .merchantCategory) ?? ""
        merchantLogo = try values.decodeIfPresent(String.self, forKey: .merchantLogo) ?? ""
        merchantName = try values.decodeIfPresent(String.self, forKey: .merchantName) ?? ""
        merchantOfficialPage = try values.decodeIfPresent(String.self, forKey: .merchantOfficialPage) ?? ""
        merchantPhoneNumber = try values.decodeIfPresent(String.self, forKey: .merchantPhoneNumber) ?? ""
        merchantSubcategory = try values.decodeIfPresent(String.self, forKey: .merchantSubcategory) ?? ""
        primaryCategory = try values.decodeIfPresent(String.self, forKey: .primaryCategory) ?? ""
        secondaryCategory = try values.decodeIfPresent(String.self, forKey: .secondaryCategory) ?? ""
        surcharge = try values.decodeIfPresent(String.self, forKey: .surcharge) ?? ""
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname) ?? ""
    }
}
