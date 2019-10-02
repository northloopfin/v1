//
//  Campus.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol CampusDelegate:BaseViewProtocol {
    func didFetchCampus(data:CampusData)
    func emptyCampus()
    func didFetchUniversities(data:[String])
}

struct Campus: Codable {
    let id,name,logo,campus: String
    let cashback_percentage: Double
    let vote_percentage: Double
    
    enum CodingKeys: String, CodingKey {
        case campus
        case id
        case name
        case logo
        case vote_percentage = "vote_percentage"
        case cashback_percentage = "cashback_percentage"
    }
    
    init(from decoder: Decoder) throws {
        let val = try decoder.container(keyedBy: CodingKeys.self)
        
        campus = try val.decodeIfPresent(String.self, forKey: .campus) ?? ""
        name = try val.decodeIfPresent(String.self, forKey: .name) ?? ""
        logo = try val.decodeIfPresent(String.self, forKey: .logo) ?? ""
        id = try val.decodeIfPresent(String.self, forKey: .id) ?? ""
        vote_percentage = try val.decodeIfPresent(Double.self, forKey: .vote_percentage) ?? 0
        cashback_percentage = try val.decodeIfPresent(Double.self, forKey: .cashback_percentage) ?? 0       
    }
}


struct CampusData: Codable {
    let values: [Campus]
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
        case values = "data"
    }
    
    init(from decoder: Decoder) throws {
        let val = try decoder.container(keyedBy: CodingKeys.self)
        
        values = try val.decodeIfPresent(Array<Campus>.self, forKey: .values)!
        message = try val.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
}

