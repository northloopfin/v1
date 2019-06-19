//
//  UniversityPresenter.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 19/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class UniversityPresenter:ResponseCallback{
    
    private weak var delegate          : FetchUniversityDelegates?
    private lazy var logic         : FetchUniversityBusinessModel = FetchUniversityBusinessModel()
    
    init(delegate responseDelegate:FetchUniversityDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendFEtchUniversityListRequest(sendToAPI:Bool){
        
        // convert requestbody to json string and assign to request model request param
        
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = FetchUniversityRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue
                , value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: "ip", value: "127.0.0.1")
            .addRequestQueryParams(key: "isUpgrade", value: sendToAPI as AnyObject)
            .addRequestQueryParams(key: "ip", value: UIDeviceHelper.getIPAddress() as AnyObject)
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
        
        self.logic.performFetchUniversityList(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        // let response = responseObject as! SetPinResponse
        self.delegate?.hideLoader()
        self.delegate?.didFetchedUniversityList()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}
