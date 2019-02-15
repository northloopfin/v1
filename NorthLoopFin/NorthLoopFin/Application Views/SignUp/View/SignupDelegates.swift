//
//  PhoneVerificationDelegate.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
import Firebase

protocol PhoneVerificationDelegate: BaseViewProtocol{
     func didSentOTP(result:PhoneVerifyStart)
     func didCheckOTP(result:PhoneVerifyCheck)
}
//Obsolete Now
protocol Auth0Delegates :BaseViewProtocol{
    func didLoggedIn()
    func didRetreivedProfile()
    func didUpdatedProfile()
    func didLoggedOut()
    func didFailed(err:Error)
}

protocol RailsBankDelegate:BaseViewProtocol {
    func didUserCreated()
    func didFailedWithError(err:Error)
    
}

protocol FirebaseDelegates: BaseViewProtocol{
    func didFirebaseUserCreated(authResult:AuthDataResult?,error:NSError?)
    func didNameUpdated(error:NSError?)
    func didFirebaseDatabaseUpdated()
    func didLoggedIn(error:NSError?)
    func didReadUserFromDatabase(error:NSError?, data:NSDictionary?)
    func didSendPasswordReset(error:NSError?)
}

