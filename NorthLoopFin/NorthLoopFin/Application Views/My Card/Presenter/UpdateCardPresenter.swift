//
//  UpdateCardPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 04/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class UpdateCardPresenter:ResponseCallback{
    
    private weak var delegate          : UpdateCardDelegates?
    private lazy var logic         : UpdateCardBusinessLogic = UpdateCardBusinessLogic()
    
    init(delegate responseDelegate:UpdateCardDelegates){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func updateCardStatus(requestBody:UpdateCardRequestBody){
        
        // convert requestbody to json string and assign to request model request param
        
        self.delegate?.showLoader()
        let currentUser: User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = UpdateCardRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue
                , value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: "ip", value: UIDevice.current.ipAddress())
            .build()
        requestModel.apiUrl = requestModel.getEndPoint()
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(requestBody)
            let jsonString = String(data: jsonData, encoding: .utf8)
            //print(jsonString!)
            let dic:[String:AnyObject] = jsonString?.convertToDictionary() as! [String : AnyObject]
            //print(dic)
            requestModel.requestQueryParams = dic
        }catch {
            //handle error
            print(error)
        }
        
        self.logic.performUpdateCardStatus(withRequestModel: requestModel, presenterDelegate: self)
        
    }
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        let response = responseObject as! Card
        self.delegate?.hideLoader()
        self.delegate?.didUpdateCardStatus(data: response)
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}
