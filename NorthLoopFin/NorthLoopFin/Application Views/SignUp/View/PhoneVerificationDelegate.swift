//
//  PhoneVerificationDelegate.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation

protocol PhoneVerificationDelegate: BaseViewProtocol{
     func didSentOTP(result:PhoneVerifyStart)
     func didCheckOTP(result:PhoneVerifyCheck)
}

protocol Auth0Delegates {
    func didLoggedIn()
    func didRetreivedProfile()
    func didUpdatedProfile()
    func didLoggedOut()
}
