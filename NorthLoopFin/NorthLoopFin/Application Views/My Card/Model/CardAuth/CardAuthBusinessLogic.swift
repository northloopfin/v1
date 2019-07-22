//
//  CardInfoBusinessLogic.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 22/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CardAuthBusinessLogic {

    deinit {
        print("CardBusinessLogic deinit")
    }
    
    /**
     This method is used for perform CapsuleList With Valid Inputs constructed into a CapsuleListRequestModel
     
     - parameter inputData: Contains info for CapsuleList
     - parameter success:   Returning Success Response of API
     - parameter failure:   NSError Response Contaons ErrorInfo
     */
    
    func performFetchCardAuth(withRequestModel cardAuthRequestModel: CardAuthRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        CardAuthAPIRequest().makeAPIRequest(withReqFormData: cardAuthRequestModel, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
    
}
