//
//  ZendeskAPIRequest.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class ZendeskAPIRequest:ApiRequestProtocol {
    
    //MARK:- local properties
    var apiRequestUrl:String!
    
    //MARK:- Helper methods
    
    /**
     This method is used make an api request to service manager
     
     - parameter reqFromData: CapsuleListRequestModel which contains Request header and request body for the signup api call
     - parameter errorResolver: ErrorResolver contains all error handling with posiible error codes
     - parameter responseCallback: ResponseCallback used to throw callback on recieving response
     */
    func makeAPIRequest(withReqFormData reqFromData: ZendeskRequestModel, errorResolver: ErrorResolver, responseCallback: ResponseCallback) {
        
        self.apiRequestUrl = reqFromData.getEndPoint()
        print(self.apiRequestUrl)
        let responseWrapper = ResponseWrapper(errorResolver: errorResolver, responseCallBack: responseCallback)
        ServiceManager.sharedInstance.requestGETWithURL(self.apiRequestUrl, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: ZendeskResponse.self)
        //ServiceManager.sharedInstance.requestPOSTWithURL(self.apiRequestUrl, andRequestDictionary: reqFromData.requestQueryParams, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: ACHTransaction.self)
    }
    
    /**
     This method is used to know that whether the api request is in progress or not
     
     - returns: Boolean value either true or false
     */
    func isInProgress() -> Bool {
        return ServiceManager.sharedInstance.isInProgress(self.apiRequestUrl)
    }
    
    /**
     This method is used to cancel the particular API request
     */
    func cancel() -> Void{
        ServiceManager.sharedInstance.cancelTaskWithURL(self.apiRequestUrl)
    }
}
