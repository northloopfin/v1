//
//  LoginBussinessLogic.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 10/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class LoginBusinessLogic {
    
    deinit {
        print("Login deinit")
            }
    
    
    /// Perform login with
    ///
    /// - Parameters:
    ///   - loginModel: LoginRequestModel
    ///   - presenterDelegate: ResponseCallBack delegate
    
    func performLogin(withLoginRequestModel loginModel: LoginRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        LoginApiRequest().makeAPIRequest(withReqFormData: loginModel, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
}
