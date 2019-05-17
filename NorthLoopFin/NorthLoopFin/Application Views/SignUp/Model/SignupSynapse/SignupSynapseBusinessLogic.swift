//
//  SignupSynapseBusinessLogic.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 18/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
//
//  SignupAuthBusinessModel.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 17/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class SignupSynapseBusinessLogic {
    
    deinit {
        print("SignupSynapseBusinessLogic deinit")
    }
    
    /**
     This method is used for perform CapsuleList With Valid Inputs constructed into a CapsuleListRequestModel
     
     - parameter inputData: Contains info for CapsuleList
     - parameter success:   Returning Success Response of API
     - parameter failure:   NSError Response Contaons ErrorInfo
     */
    
    func performSignUpAuth(withRequestModel requestModel: SignupSynapseRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        SignupSynapseAPIRequest().makeAPIRequest(withReqFormData: requestModel, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
    
}
