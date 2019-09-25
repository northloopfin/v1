//
//  DeleteNodeBusinessLogic.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 18/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class DeleteNodeBusinessLogic {
    
    deinit {
        print("DeleteNodeBusinessLogic deinit")
    }

    
    func performDeleteNode(withRequestModel model: DeleteNodeRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        DeleteNodeAPIRequest().makeAPIRequest(withReqFormData: model, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
}
