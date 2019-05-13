//
//  LoginDelegate.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

protocol LoginDelegate:BaseViewProtocol {
    func didLoggedIn(data: LoginData)
    func didLoginFailed(error:ErrorModel)
}
