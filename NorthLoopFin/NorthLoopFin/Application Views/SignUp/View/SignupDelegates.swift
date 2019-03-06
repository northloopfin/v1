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

protocol FirebaseDelegates: BaseViewProtocol{
    func didFirebaseUserCreated(authResult:AuthDataResult?,error:NSError?)
    func didNameUpdated(error:NSError?)
    func didFirebaseDatabaseUpdated()
    func didLoggedIn(error:NSError?)
    func didReadUserFromDatabase(error:NSError?, data:NSDictionary?)
    func didSendPasswordReset(error:NSError?)
}

protocol ImagePreviewDelegate {
    func imageUpdatedFor(index: Int, image:UIImage)
}

