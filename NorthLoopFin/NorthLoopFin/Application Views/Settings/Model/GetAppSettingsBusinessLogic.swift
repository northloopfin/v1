//
//  AppSettingsBusinessLogic.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 20/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation



class GetAppSettingsBusinessLogic {
    
    deinit {
        print("AppSettingsBusinessLogic deinit")
    }
    
    /**
     This method is used for perform CapsuleList With Valid Inputs constructed into a CapsuleListRequestModel
     
     - parameter inputData: Contains info for CapsuleList
     - parameter success:   Returning Success Response of API
     - parameter failure:   NSError Response Contaons ErrorInfo
     */
    
    func performSaveAppSettings(withRequestModel requestModel: GetAppSettingsRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        
        GetAppSettingsAPIRequest().makeAPIRequest(withReqFormData: requestModel, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
    
}
