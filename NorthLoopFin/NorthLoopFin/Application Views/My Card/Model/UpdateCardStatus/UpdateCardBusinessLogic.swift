//
//  UpdateCardBusinessLogic.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 04/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


class UpdateCardBusinessLogic {
    
    deinit {
        print("UpdateCardBusinessLogic deinit")
    }
    
    /**
     This method is used for perform CapsuleList With Valid Inputs constructed into a CapsuleListRequestModel
     
     - parameter inputData: Contains info for CapsuleList
     - parameter success:   Returning Success Response of API
     - parameter failure:   NSError Response Contaons ErrorInfo
     */
    
    func performUpdateCardStatus(withRequestModel cardRequestModel: UpdateCardRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        UpdateCardAPIRequest().makeAPIRequest(withReqFormData: cardRequestModel, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
    
}
