//
//  LostCardPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 05/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class LostCardPresenter:ResponseCallback{
    
    private weak var delegate          : LostCardDelegates?
    private lazy var logic         : LostCardBusinessLogic = LostCardBusinessLogic()
    
    init(delegate responseDelegate:LostCardDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendLostCardRequest(toExpedite:Bool ,toIssueNewCard:Bool){
        
        // convert requestbody to json string and assign to request model request param
        
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = LostCardRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue
                , value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: "ip", value: UIDevice.current.ipAddress())
            .addRequestQueryParams(key: "expedite", value: toExpedite as AnyObject)
            .addRequestQueryParams(key: "issueNewCard", value: toIssueNewCard as AnyObject)
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
        self.logic.performLostCard(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        // let response = responseObject as! SetPinResponse
        self.delegate?.hideLoader()
        self.delegate?.didSentLostCardRequest()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}
