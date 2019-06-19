//
//  ATMFinderPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 29/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class ATMFinderPresenter: ResponseCallback{
    
    private weak var delegate          : ATMFinderDelegates?
    private lazy var businessLogic         : ATMFinderBusinessModel = ATMFinderBusinessModel()
    
    //    Constructor
    init(delegate responseDelegate:ATMFinderDelegates){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendATMFetch(lat:String,long:String,zip:String){
        self.delegate?.showLoader()
        
        let currentUser:User = UserInformationUtility.sharedInstance.getCurrentUser()!
        
        var requestModel = ATMFinderRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: "127.0.0.1")//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestQueryParams(key: "lat", value: lat as AnyObject)
            .addRequestQueryParams(key: "lon", value: long as AnyObject)
            .build()
        if zip != ""{
             requestModel = ATMFinderRequestModel.Builder()
                .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: "127.0.0.1")//UIDeviceHelper.getIPAddress()!)
                .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
                .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
                .addRequestQueryParams(key: "zip", value: zip as AnyObject)
                .build()
        }
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performATMFetch(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        let response = responseObject as! ATMFinder
        self.delegate?.didFetchATM(data: response.data)
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}
