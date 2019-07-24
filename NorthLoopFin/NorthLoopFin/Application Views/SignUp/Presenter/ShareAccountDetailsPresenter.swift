//
//  ShareAccountDetailsPresenter.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 20/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class ShareAccountDetailsPresenter:ResponseCallback{
    
    private weak var delegate          : ShareAccountDetailDelegates?
    private lazy var logic         : ShareAccountDetailsBusinessLogic = ShareAccountDetailsBusinessLogic()
    
    init(delegate responseDelegate:ShareAccountDetailDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendShareAccountDetailsRequest(email:String){
        
        // convert requestbody to json string and assign to request model request param
        
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = ShareAccountDetailsRequestModel.Builder()
            .addRequestHeader(key: "ip", value: UIDevice.current.ipAddress())
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestQueryParams(key: "email", value: email as AnyObject)
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
        
        self.logic.performShareAccountDetails(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        //let response = responseObject as! FetchUniversityResponse
        self.delegate?.hideLoader()
       self.delegate?.didSharedAccounTDetails()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}
