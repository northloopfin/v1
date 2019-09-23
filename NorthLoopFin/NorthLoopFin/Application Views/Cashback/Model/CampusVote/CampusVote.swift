//
//  CampusVote.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 21/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol CampusVoteDelegate:BaseViewProtocol {
    func didCampusVote(data:CampusVote)
}

struct CampusVote: Codable {
    let message: String
}
