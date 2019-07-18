//
//  DeleteACHBusinessLogic.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 18/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class DeleteACHBusinessLogic {
    
    deinit {
        print("DeleteACHBusinessLogic deinit")
    }

    
    func performDeleteACH(withRequestModel model: DeleteACHRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        DeleteACHAPIRequest().makeAPIRequest(withReqFormData: model, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
}
