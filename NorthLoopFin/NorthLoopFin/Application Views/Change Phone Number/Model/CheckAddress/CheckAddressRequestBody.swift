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
    var street, street_line_1, house, city, state, zipcode, dpv_match_code: String
    
    init(data:Any) {
        self.street = ""
        self.street_line_1 = ""
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
                if let sec_des = components["secondary_designator"]{
                    self.house = sec_des + " "
                }
                if let sec_numb = components["secondary_number"]{
                    self.house = self.house + sec_numb
                }
                if let primary_number = components["primary_number"]{
                    self.street = primary_number + " "
                }
                if let street_name = components["street_name"]{
                    self.street = self.street + street_name + " "
                }
                if let street_suffix = components["street_suffix"]{
                    self.street = self.street + street_suffix
                }
            }
            if let delivery_line_1 = option["delivery_line_1"] as? String {
                self.street_line_1 = delivery_line_1
            }else{
                self.street_line_1 = self.street
            }
            if let analysis = option["analysis"] as? [String:String] {
                if let dpvMatchCode = analysis["dpv_match_code"] {
                    self.dpv_match_code = dpvMatchCode
                }
            }
        }
    }
}
