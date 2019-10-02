//
//  ACHDebitTransactionBusinessModel.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 28/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class ACHDebitTransactionBusinessModel {
    
    deinit {
        print("ACHDebitTransactionBusinessModel deinit")
    }
    
    
    /// Perform login with
    ///
    /// - Parameters:
    ///   - loginModel: LoginRequestModel
    ///   - presenterDelegate: ResponseCallBack delegate
    
    func performACHDebitTransaction(withRequestModel model: ACHDebitTransactionRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        ACHDebitTransactionAPIRequest().makeAPIRequest(withReqFormData: model, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
}
