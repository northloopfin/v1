//
//  CheckAddressRequestBody.swift
//  NorthLoopFin
//
//  Created by Admin on 8/2/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

// MARK: - Address
class CheckAddress: Codable {
    let authId, authToken, match: String
    let street, city, state, zipcode: String
    
    enum CodingKeys: String, CodingKey {
        case authId = "auth-id"
        case authToken = "auth-token"
        case match, street, city, state, zipcode
    }
    
    init(street:String, city:String, state:String, zipcode:String) {
        self.street = street
        self.city = city
        self.state = state
        self.zipcode = zipcode
        self.match = "invalid"
        self.authId = AppConstants.SS_Auth_ID ?? ""
        self.authToken = AppConstants.SS_Auth_Token ?? ""
    }
}

// MARK: - VerifiedAddress
class VerifiedAddress {
    var street, house, city, state, zipcode, dpv_match_code: String
    
    init(data:Any) {
        self.street = ""
        self.house = ""
        self.city = ""
        self.state = ""
        self.zipcode = ""
        self.dpv_match_code = ""
        
        if let list = data as? [[String:Any]],
            let option = list[0] as? [String:Any] {
            if let components = option["components"] as? [String:String] {
                if let cityName = components["city_name"] {
                    self.city = cityName
                }
                if let state = components["state_abbreviation"] {
                    self.state = state
                }
                if let zipcode = components["zipcode"] {
                    self.zipcode = zipcode
                }
            }
            if let delivery_line_1 = option["delivery_line_1"] as? String {
                self.street = delivery_line_1
            }
            if let analysis = option["analysis"] as? [String:String] {
                if let dpvMatchCode = analysis["dpv_match_code"] {
                    self.dpv_match_code = dpvMatchCode
                }
            }
        }
    }
}
