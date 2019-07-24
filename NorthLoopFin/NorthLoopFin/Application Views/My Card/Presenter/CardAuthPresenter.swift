//
//  CardAuthPresenter.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 22/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CardAuthPresenter: ResponseCallback {
    
    private weak var delegate          : CardAuthDelegates?
    private lazy var logic         : CardAuthBusinessLogic = CardAuthBusinessLogic()
    
    init(delegate responseDelegate:CardAuthDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func getCardAuth(){
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = CardAuthRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue
                , value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: "ip", value: UIDevice.current.ipAddress())
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
        self.logic.performFetchCardAuth(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        let response = responseObject as! CardAuthData
        self.delegate?.hideLoader()
        self.delegate?.didFetchCardAuth(data: response)
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}
