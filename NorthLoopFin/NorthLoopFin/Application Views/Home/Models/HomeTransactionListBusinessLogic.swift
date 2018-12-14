//
//  HomeTransactionListBusinessLogic.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 13/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation

class HomeTransactionListBusinessLogic {
    
    deinit {
        print("TransactionList deinit")
    }
    
    /**
     This method is used for perform CapsuleList With Valid Inputs constructed into a CapsuleListRequestModel
     
     - parameter inputData: Contains info for CapsuleList
     - parameter success:   Returning Success Response of API
     - parameter failure:   NSError Response Contaons ErrorInfo
     */
    func performTransactionList(withCapsuleListRequestModel homeTransactionModel: HomeLedgerRequestModel, presenterDelegate:ResponseCallback) ->Void {
        
        //Adding predefined set of errors
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests() //self.registerErrorForCapsuleList()
        TransactionListApiRequest().makeAPIRequest(withReqFormData: homeTransactionModel, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
}
