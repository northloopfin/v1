//
//  2FABusinessLogic.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 05/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class TwoFABusinessLogic {
    
    deinit {
        print("TwoFABusinessLogic deinit")
    }
    
    /**
     This method is used for perform CapsuleList With Valid Inputs constructed into a CapsuleListRequestModel
     
     - parameter inputData: Contains info for CapsuleList
     - parameter success:   Returning Success Response of API
     - parameter failure:   NSError Response Contaons ErrorInfo
     */
    
    func performTwoFA(withRequestModel requestModel: TwoFARequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        TwoFAAPIRequest().makeAPIRequest(withReqFormData: requestModel, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
    
}

