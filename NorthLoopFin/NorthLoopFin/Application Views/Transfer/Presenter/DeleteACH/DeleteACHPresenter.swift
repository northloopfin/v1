//
//  DeleteACHPresenter.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 18/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class DeleteACHPresenter: ResponseCallback{
    
    private weak var delegate          : DeleteACHDelegates?
    private lazy var businessLogic         : DeleteACHBusinessLogic = DeleteACHBusinessLogic()
    
    //    Constructor
    init(delegate deleteDelegate:DeleteACHDelegates){
        self.delegate = deleteDelegate
    }
    
    //    Send Login Request to Business Login
    func deleteACRequest(nodeid: String){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = DeleteACHRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .addRequestHeader(key: "Content-Type", value: "application/x-www-form-urlencoded")
            .addRequestQueryParams(key: "node_id_to_be_deleted", value: nodeid as AnyObject)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performDeleteACH(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        print(responseObject)
        let response = responseObject as! DeleteACH
        self.delegate?.didDeleteACH(data: response.data)
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}
