//
//  FetchWireListPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class FetchWireListPresenter: ResponseCallback{
    
    private weak var delegate          : FetchWireListDelegates?
    private lazy var businessLogic         : FetchWireListBusinessLogic = FetchWireListBusinessLogic()
    
    //    Constructor
    init(delegate responseDelegate:FetchWireListDelegates){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendFetchRequest(){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = FetchWireListRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.USERID.rawValue, value: currentUser.userID)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performFetchWireList(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        let response = responseObject as! WireList
        self.delegate?.didFetcWireList(data: response.data)
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}
