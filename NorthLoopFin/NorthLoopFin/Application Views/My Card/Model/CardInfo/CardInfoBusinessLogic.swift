//
//  CardInfoBusinessLogic.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 22/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CardInfoBusinessLogic {

    deinit {
        print("CardBusinessLogic deinit")
    }
    
    /**
     This method is used for perform CapsuleList With Valid Inputs constructed into a CapsuleListRequestModel
     
     - parameter inputData: Contains info for CapsuleList
     - parameter success:   Returning Success Response of API
     - parameter failure:   NSError Response Contaons ErrorInfo
     */
    
    func performFetchCardInfo(withRequestModel cardRequestModel: CardInfoRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        CardInfoAPIRequest().makeAPIRequest(withReqFormData: cardRequestModel, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
    
}
