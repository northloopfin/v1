//
//  AnalysisBusinessModel.swift
//  NorthLoopFin
//
//  Created by Admin on 8/6/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class AnalysisBusinessModel {
    
    deinit {
        print("AnalysisBusinessModel deinit")
    }
    
    
    /// Get Analysis categories
    ///
    /// - Parameters:
    ///   - loginModel: AnalysisRequestModel
    ///   - presenterDelegate: ResponseCallBack delegate
    
    func performFetchAnalysisCategories(withRequestModel model: AnalysisAPIRequestModel, presenterDelegate:ResponseCallback) -> Void {
        let errorResolver:ErrorResolver = ErrorResolver.registerErrorsForApiRequests()
        self.makeAPIRequest(withReqFormData:model, errorResolver: errorResolver, responseCallback: presenterDelegate)
    }
    
    var apiRequestUrl:String!
    
    //MARK:- Helper methods
    
    func makeAPIRequest(withReqFormData reqFromData: AnalysisAPIRequestModel, errorResolver: ErrorResolver, responseCallback: ResponseCallback) {
        self.apiRequestUrl = reqFromData.getEndPoint()
        print(self.apiRequestUrl)
        let responseWrapper = ResponseWrapper(errorResolver: errorResolver, responseCallBack: responseCallback)
        ServiceManager.sharedInstance.requestGETWithURL(self.apiRequestUrl, requestHeader: reqFromData.requestHeader, responseCallBack: responseWrapper, returningClass: AnalysisOptions.self)
    }
    
    func isInProgress() -> Bool {
        return ServiceManager.sharedInstance.isInProgress(self.apiRequestUrl)
    }
    
    func cancel() -> Void{
        ServiceManager.sharedInstance.cancelTaskWithURL(self.apiRequestUrl)
    }
}
