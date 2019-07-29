//
//  CardInfoPresenter.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 22/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CardInfoPresenter: ResponseCallback {

    private weak var delegate          : CardInfoDelegates?
    private lazy var logic         : CardInfoBusinessLogic = CardInfoBusinessLogic()
    
    init(delegate responseDelegate:CardInfoDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func getCardInfo(cardAuthData:CardAuthData){
        self.delegate?.showLoader()
        let requestModel = CardInfoRequestModel.Builder()
            .addRequestHeader(key: "X-SP-USER"
                , value: cardAuthData.data.oAuth_key+"|e83cf6ddcf778e37bfe3d48fc78a6502062fc")
            .addRequestHeader(key: Endpoints.APIRequestHeaders.CONTENT_TYPE.rawValue, value: Endpoints.APIRequestHeaders.APPLICATION_JSON.rawValue)
            .addRequestHeader(key: "X-SP-USER-IP", value: cardAuthData.data.formatted_ip)
            .addRequestHeader(key: "full_dehydrate", value: "yes")
            .build()
        requestModel.apiUrl = requestModel.getEndPoint() + "/users/" + cardAuthData.data.user_id + "/nodes/" + cardAuthData.data.node_id + "/subnets/" + cardAuthData.data.subnet_id + "?full_dehydrate=yes"
        self.logic.performFetchCardInfo(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        let response = responseObject as! CardInfo
        self.delegate?.hideLoader()
        self.delegate?.didFetchCardInfo(data: response)
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}
