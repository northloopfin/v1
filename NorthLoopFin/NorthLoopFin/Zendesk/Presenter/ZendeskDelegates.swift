//
//  ZendeskDelegates.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol ZendeskDelegates:BaseViewProtocol {
    func didSentZendeskToken(data: ZendeskData)
}
