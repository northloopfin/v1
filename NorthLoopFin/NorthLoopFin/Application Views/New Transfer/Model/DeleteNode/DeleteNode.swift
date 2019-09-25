//
//  DeleteNode.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 18/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

protocol DeleteNodeDelegate:BaseViewProtocol {
    func didDeleteNode(data:DeleteNode)
    
}
struct DeleteNode: Codable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
}
