//
//  FetchCashbackPresenter.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 21/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class FetchCashbackPresenter: ResponseCallback{
    
    private weak var delegate          : FetchCashbackDelegate?
    private lazy var businessLogic         : FetchCashbackBusinessModel = FetchCashbackBusinessModel()
    
    //    Constructor
    init(delegate responseDelegate:FetchCashbackDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendFetchCashbackRequest(){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = FetchCashbackRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.USERID.rawValue, value: currentUser.userID)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performFetchCashback(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        if let response = responseObject as? FetchCashback{
            self.delegate?.didFetchCashback(data: response.data)
        }
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}
