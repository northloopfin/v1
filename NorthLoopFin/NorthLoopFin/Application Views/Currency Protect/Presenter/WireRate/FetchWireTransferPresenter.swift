//
//  FetchWireTransferPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class FetchWireTransferPresenter: ResponseCallback{
    
    private weak var delegate          : FetchWireTransferDelegates?
    private lazy var businessLogic         : FetchWireTransferBusinessLogic = FetchWireTransferBusinessLogic()
    
    //    Constructor
    init(delegate responseDelegate:FetchWireTransferDelegates){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendFetchRequest(transactionID:String){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = FetchWireTransferRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl = requestModel.getEndPoint(transactionID: transactionID)
        self.businessLogic.performFetchWireTransfer(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        let response = responseObject as! WireTransfer
        self.delegate?.didFetcWireTransfer(data: response)
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}
