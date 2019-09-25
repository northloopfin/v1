//
//  DeleteNodePresenter.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 18/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class DeleteNodePresenter: ResponseCallback{
    
    private weak var delegate          : DeleteNodeDelegate?
    private lazy var businessLogic         : DeleteNodeBusinessLogic = DeleteNodeBusinessLogic()
    
    //    Constructor
    init(delegate deleteDelegate:DeleteNodeDelegate){
        self.delegate = deleteDelegate
    }
    
    //    Send Login Request to Business Login
    func deleteNodeRequest(nodeids: [String]){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = DeleteNodeRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: "Content-Type", value: "application/json")
            .addRequestQueryParams(key: "nodes_to_delete", value: nodeids as AnyObject)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performDeleteNode(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        print(responseObject)
        if let response = responseObject as? DeleteNode{
            self.delegate?.didDeleteNode(data: response)
        }
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}
