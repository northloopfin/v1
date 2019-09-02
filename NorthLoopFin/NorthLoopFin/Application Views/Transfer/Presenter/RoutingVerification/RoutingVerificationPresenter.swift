//
//  RoutingVerificationPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class RoutingVerificationPresenter: ResponseCallback{
    
    private weak var delegate          : RoutingVerificationDelegate?
    private lazy var businessLogic         : RoutingVerificationBusinessLogic = RoutingVerificationBusinessLogic()
    
    //    Constructor
    init(delegate responseDelegate:RoutingVerificationDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendRoutingVerificationRequest(routing number:String){
        self.delegate?.showLoader()
        
        let requestModel = RoutingVerificationRequestModel.Builder()
            .addRequestHeader(key: "Content-Type", value: "application/json")
            .addRequestQueryParams(key: "routing_num", value: number as AnyObject)
            .addRequestQueryParams(key: "type", value: "ACH-US" as AnyObject)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performRoutingVerification(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        //let response = responseObject as! RoutingVerification
        self.delegate?.didRoutingVerified()
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.failedRoutingVerification()
    }
}
