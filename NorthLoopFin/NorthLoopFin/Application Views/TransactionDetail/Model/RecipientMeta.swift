//
//  RecipientMeta.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 15/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct RecipientMeta: Codable {
    let address: String
    let foreignTransaction: Bool
    //let interchangeObject: InterchangeObject
    let merchantCategory: String
    let merchantLogo: String
    let merchantName: String
    let merchantOfficialPage, merchantPhoneNumber: String
    let merchantSubcategory, primaryCategory, secondaryCategory, surcharge: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case address
        case foreignTransaction = "foreign_transaction"
        //case interchangeObject = "interchange_object"
        case merchantCategory = "merchant_category"
        case merchantLogo = "merchant_logo"
        case merchantName = "merchant_name"
        case merchantOfficialPage = "merchant_official_page"
        case merchantPhoneNumber = "merchant_phone_number"
        case merchantSubcategory = "merchant_subcategory"
        case primaryCategory = "primary_category"
        case secondaryCategory = "secondary_category"
        case surcharge, type
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
    }
}
