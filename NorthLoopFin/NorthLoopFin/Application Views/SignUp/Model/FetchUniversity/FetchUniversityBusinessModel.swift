//
//  FetchUnivaersityBusinessModel.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 19/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
class FetchUniversityBusinessModel {
    
    deinit {
        print("FetchUniversityBusinessModel deinit")
    }
    
    /**
     This method is used for perform CapsuleList With Valid Inputs constructed into a CapsuleListRequestModel
     
     - parameter inputData: Contains info for CapsuleList
     - parameter success:   Returning Success Response of API
     - parameter failure:   NSError Response Contaons ErrorInfo
     */
    
    func performFetchUniversityList(withRequestModel requestModel: FetchUniversityRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        
        FetchUniversityAPIRequest().makeAPIRequest(withReqFormData: requestModel, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
    
}

