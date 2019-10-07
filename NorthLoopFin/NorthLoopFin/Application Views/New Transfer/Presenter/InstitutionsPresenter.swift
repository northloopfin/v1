//
//  InstitutionsPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class InstitutionsPresenter: ResponseCallback{
    
    private weak var delegate          : InstitutionsDelegate?
    private lazy var businessLogic         : InstitutionsBusinessLogic = InstitutionsBusinessLogic()
    
    //    Constructor
    init(delegate responseDelegate:InstitutionsDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendInstitutionsRequest(){        
        let requestModel = InstitutionsRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performInstitutions(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        if let response = responseObject as? InstitutionsData{
            self.delegate?.didFetchInstitutions(data: response)
        }
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}
