//
//  ChangeAddressBusinessModel.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 06/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class ChangeAddressBusinessModel {
    
    deinit {
        print("ChangeAddressBusinessModel deinit")
    }
    
    /**
     This method is used for perform CapsuleList With Valid Inputs constructed into a CapsuleListRequestModel
     
     - parameter inputData: Contains info for CapsuleList
     - parameter success:   Returning Success Response of API
     - parameter failure:   NSError Response Contaons ErrorInfo
     */
    
    func performChangeAddress(withRequestModel requestModel: ChangeAddressRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        ChangeAddressAPIRequest().makeAPIRequest(withReqFormData: requestModel, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
    
}


