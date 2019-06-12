//
//  ATMFinderBusinessModel.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class ATMFinderBusinessModel {
    
    deinit {
        print("ATMFinderBusinessModel deinit")
    }
    
    
    /// Perform login with
    ///
    /// - Parameters:
    ///   - loginModel: LoginRequestModel
    ///   - presenterDelegate: ResponseCallBack delegate
    
    func performATMFetch(withRequestModel model: ATMFinderRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        ATMFinderAPIRequest().makeAPIRequest(withReqFormData: model, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
}
