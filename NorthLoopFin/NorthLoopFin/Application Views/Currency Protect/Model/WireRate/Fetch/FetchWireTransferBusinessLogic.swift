//
//  FetchWireTransferBusinessLogic.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class FetchWireTransferBusinessLogic {
    
    deinit {
        print("LinkACHBusinessLogic deinit")
    }
    
    
    /// Perform login with
    ///
    /// - Parameters:
    ///   - loginModel: LoginRequestModel
    ///   - presenterDelegate: ResponseCallBack delegate
    
    func performFetchWireTransfer(withRequestModel model: FetchWireTransferRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        FetchWireTransferAPIRequest().makeAPIRequest(withReqFormData: model, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
}
