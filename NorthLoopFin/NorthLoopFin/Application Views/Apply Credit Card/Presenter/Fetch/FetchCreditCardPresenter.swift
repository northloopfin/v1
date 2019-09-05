//
//  FetchCreditCardPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class FetchCreditCardPresenter: ResponseCallback{
    
    private weak var delegate          : FetchCreditCardDelegate?
    private lazy var businessLogic         : FetchCreditCardBusinessLogic = FetchCreditCardBusinessLogic()
    
    //    Constructor
    init(delegate responseDelegate:FetchCreditCardDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendFetchCreditCardRequest(){
        self.delegate?.showLoader()
        
        let currentUser:User = UserInformationUtility.sharedInstance.getCurrentUser()!

        let requestModel = FetchCreditCardRequestModel.Builder()
            .addRequestHeader(key: "Content-Type", value: "application/json")
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performFetchCreditCard(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        if let response = responseObject as? FetchCreditCard{
            self.delegate?.didFetchCreditCard(data: response)
        }
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.didFaildCreditCard()
//        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}
