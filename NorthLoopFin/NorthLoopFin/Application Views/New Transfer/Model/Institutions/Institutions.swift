//
//  Institutions.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol InstitutionsDelegate:BaseViewProtocol {
    func didFetchInstitutions(data:InstitutionsData)
    
}

class clsInstitutions: NSObject {
    var bankCode = "",bankName = "",logo: String = ""
    
    override init() {
        super.init()
    }
    
    init(name:String, code:String, image:String) {
        bankName = name
        bankCode = code
        logo = image
    }
}

struct Institutions: Codable {
    let bankCode,bankName,logo: String
    let is_active: Bool
    
    enum CodingKeys: String, CodingKey {
        case logo
        case bankCode = "bank_code"
        case bankName = "bank_name"
        case is_active
    }
    
    init(from decoder: Decoder) throws {
        let val = try decoder.container(keyedBy: CodingKeys.self)
        
        bankName = try val.decodeIfPresent(String.self, forKey: .bankName) ?? ""
        bankCode = try val.decodeIfPresent(String.self, forKey: .bankCode) ?? ""
        logo = try val.decodeIfPresent(String.self, forKey: .logo) ?? ""
        is_active = try val.decodeIfPresent(Bool.self, forKey: .is_active) ?? false       
    }
}


struct InstitutionsData: Codable {
    let values: [Institutions]
    let errorCode, httpCode: String
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case values = "banks"
        case errorCode = "error_code"
        case httpCode = "http_code"
        case success
    }
    
    init(from decoder: Decoder) throws {
        let val = try decoder.container(keyedBy: CodingKeys.self)
        
        values = try val.decodeIfPresent(Array<Institutions>.self, forKey: .values) ?? []
        errorCode = try val.decodeIfPresent(String.self, forKey: .errorCode) ?? ""
        httpCode = try val.decodeIfPresent(String.self, forKey: .httpCode) ?? ""
        success = try val.decodeIfPresent(Bool.self, forKey: .success) ?? false       
    }

}

