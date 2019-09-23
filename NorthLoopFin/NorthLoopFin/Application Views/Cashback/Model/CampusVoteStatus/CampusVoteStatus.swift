//
//  CampusVote.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 21/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol CampusVoteStatusDelegate:BaseViewProtocol {
    func didCampusVoteStatus(data:CampusVoteStatus)
}

struct CampusVoteStatus: Codable {
    let data: CampusVoteStatusData
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(CampusVoteStatusData.self, forKey: .data)!
        
    }
}

struct CampusVoteStatusData: Codable {
    let voted: Bool
}
