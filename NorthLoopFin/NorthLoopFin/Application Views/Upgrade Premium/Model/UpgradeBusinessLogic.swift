//
//  UpgradeBusinessLogic.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 18/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class UpgradeBusinessLogic {
    
    deinit {
        print("UpgradeBusinessLogic deinit")
    }
    
    /**
     This method is used for perform CapsuleList With Valid Inputs constructed into a CapsuleListRequestModel
     
     - parameter inputData: Contains info for CapsuleList
     - parameter success:   Returning Success Response of API
     - parameter failure:   NSError Response Contaons ErrorInfo
     */
    
    func performUpgaredPremium(withRequestModel requestModel: UpgradeRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        
        UpgradeAPIRequest().makeAPIRequest(withReqFormData: requestModel, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
    
}

