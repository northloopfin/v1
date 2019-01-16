//
//  PhoneVerificationBusinessLogic.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
class PhoneVerificationBusinessLogic {
    
    deinit {
        print("TransactionList deinit")
    }
    
    /**
     This method is used for perform CapsuleList With Valid Inputs constructed into a CapsuleListRequestModel
     
     - parameter inputData: Contains info for CapsuleList
     - parameter success:   Returning Success Response of API
     - parameter failure:   NSError Response Contaons ErrorInfo
     */
    func performPhoneVerification(withCapsuleListRequestModel phoneVerificationModel: PhoneVerificationRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests()
        PhoneVerificationStartAPIRequest().makeAPIRequest(withReqFormData: phoneVerificationModel, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
    
    func performPhoneVerificationCheck(withPhoneVerification model:PhoneVerificationRequestModel, presenterDelagte:ResponseCallback)->Void {
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests()
        PhoneVerificationCheckAPIRequest().makeAPIRequest(withReqFormData: model, errorResolver: errorResolver, responseCallback: presenterDelagte)
       
    }
}

